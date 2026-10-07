# Copyright © 2026 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Operations with rules disabled by customers, stored in the aggregator database."""

from collections import namedtuple
from contextlib import contextmanager
from datetime import datetime

from behave import when

# Both tables are used as created by the aggregator migrations, as the
# scenarios migrate the aggregator database to the latest version. Migration 26
# added org_id to cluster_rule_toggle and migrations 29 and 30 dropped the
# user_id column from cluster_rule_toggle and rule_disable respectively, so
# neither table is described by the CREATE TABLE commands in common_aggregator.

# One row of the cluster_rule_toggle table as described in a feature file
ClusterRuleToggle = namedtuple(
    "ClusterRuleToggle",
    ("org_id", "cluster_name", "rule_id", "error_key", "disabled"),
)

# One row of the rule_disable table as described in a feature file
RuleDisable = namedtuple("RuleDisable", ("org_id", "rule_id", "error_key"))


@contextmanager
def aggregator_transaction(context):
    """Provide a cursor to the aggregator database and commit the work done with it.

    Scenarios working with two databases keep the aggregator connection in a
    dedicated attribute, because context.connection is taken by the
    notification database. When just one connection is established, that
    connection is the one holding the aggregator tables.
    """
    connection = getattr(context, "aggregator_connection", None)
    if connection is None:
        connection = getattr(context, "connection", None)
    assert connection is not None, "Connection to aggregator database should be established"

    try:
        yield connection.cursor()
        connection.commit()
    except Exception as e:
        connection.rollback()
        raise e


def check_rule_was_affected(cursor, table, rule):
    """Check that the last executed statement really affected the given rule.

    The rule is expected to be stored by a previous step of the scenario. When
    nothing is updated or deleted, the scenario would silently keep testing a
    rule that is still in its original state.
    """
    assert cursor.rowcount > 0, f"No row matching {rule} found in table {table}"


def read_cluster_rule_toggles(context):
    """Retrieve cluster rule toggles from the table specified in a feature file.

    Column `account number` is not part of the cluster_rule_toggle table, it
    just identifies the cluster for the other steps of the scenario.
    """
    for row in context.table:
        toggle = ClusterRuleToggle(
            org_id=row["org id"],
            cluster_name=row["cluster name"],
            rule_id=row["rule_id"],
            error_key=row["error_key"],
            disabled=int(row["disabled"]),
        )

        # check the input table
        assert toggle.org_id, "Organization ID should be set"
        assert toggle.cluster_name, "Cluster name should be set"
        assert toggle.rule_id, "Rule ID should be set"
        assert toggle.error_key, "Error key should be set"
        assert toggle.disabled in (0, 1), f"Disabled flag should be 0 or 1, not {toggle.disabled}"

        yield toggle


def read_rule_disables(context):
    """Retrieve rule acks from the table specified in a feature file.

    Column `user id` is specified just when the ack is being created, but it is
    not stored anywhere, as re-enabling the rule removes the ack no matter who
    acknowledged it.
    """
    for row in context.table:
        ack = RuleDisable(
            org_id=row["org id"],
            rule_id=row["rule_id"],
            error_key=row["error_key"],
        )

        # check the input table
        assert ack.org_id, "Organization ID should be set"
        assert ack.rule_id, "Rule ID should be set"
        assert ack.error_key, "Error key should be set"

        yield ack


@when("I insert the following rule in the cluster_rule_toggle table for the following cluster")
def insert_rules_into_cluster_rule_toggle_table(context):
    """Insert rows into table cluster_rule_toggle."""
    # timestamps disabled_at and enabled_at are nullable and are not taken into
    # account when the rule is being disabled, so they are left unset
    insert_statement = """INSERT INTO cluster_rule_toggle
                         (org_id, cluster_id, rule_id, error_key, disabled, updated_at)
                         VALUES(%s, %s, %s, %s, %s, %s);"""

    with aggregator_transaction(context) as cursor:
        for toggle in read_cluster_rule_toggles(context):
            cursor.execute(
                insert_statement,
                (
                    toggle.org_id,
                    toggle.cluster_name,
                    toggle.rule_id,
                    toggle.error_key,
                    toggle.disabled,
                    datetime.now(),
                ),
            )


@when("I update the following rule in the cluster_rule_toggle table for the following cluster")
def update_rules_in_cluster_rule_toggle_table(context):
    """Update the disabled flag of rows in table cluster_rule_toggle."""
    update_statement = """UPDATE cluster_rule_toggle
                         SET disabled = %s, updated_at = %s
                         WHERE cluster_id = %s AND rule_id = %s AND error_key = %s;"""

    with aggregator_transaction(context) as cursor:
        for toggle in read_cluster_rule_toggles(context):
            cursor.execute(
                update_statement,
                (
                    toggle.disabled,
                    datetime.now(),
                    toggle.cluster_name,
                    toggle.rule_id,
                    toggle.error_key,
                ),
            )

            check_rule_was_affected(cursor, "cluster_rule_toggle", toggle)


@when("I insert the following rule ack in the rule_disable table")
def insert_rule_acks_into_rule_disable_table(context):
    """Insert rows into table rule_disable."""
    # the justification column is nullable and is not taken into account when
    # the rule is being acknowledged, so it is left unset
    insert_statement = """INSERT INTO rule_disable
                         (org_id, rule_id, error_key, created_at, updated_at)
                         VALUES(%s, %s, %s, %s, %s);"""

    with aggregator_transaction(context) as cursor:
        for ack in read_rule_disables(context):
            now = datetime.now()
            cursor.execute(
                insert_statement,
                (ack.org_id, ack.rule_id, ack.error_key, now, now),
            )


@when("I delete the following rule ack from the rule_disable table")
def delete_rule_acks_from_rule_disable_table(context):
    """Delete rows from table rule_disable.

    The rule_disable table has no disabled flag, the mere presence of a row
    means that the rule is acknowledged. Re-enabling the rule therefore means
    deleting the row, no matter which user created it.
    """
    delete_statement = """DELETE FROM rule_disable
                         WHERE org_id = %s AND rule_id = %s AND error_key = %s;"""

    with aggregator_transaction(context) as cursor:
        for ack in read_rule_disables(context):
            cursor.execute(delete_statement, (ack.org_id, ack.rule_id, ack.error_key))

            check_rule_was_affected(cursor, "rule_disable", ack)
