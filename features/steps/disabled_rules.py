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

# The notification service selects just the key columns of the disabled rules
# tables, so the user_id column only needs any value satisfying NOT NULL.
DEFAULT_USER_ID = "user1"

# One row of the cluster_rule_toggle table as described in a feature file
ClusterRuleToggle = namedtuple(
    "ClusterRuleToggle",
    ("cluster_name", "rule_id", "error_key", "disabled"),
)


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


def read_cluster_rule_toggles(context):
    """Retrieve cluster rule toggles from the table specified in a feature file.

    Columns `org id` and `account number` are not part of the
    cluster_rule_toggle table, they just identify the cluster for the other
    steps of the scenario.
    """
    for row in context.table:
        toggle = ClusterRuleToggle(
            cluster_name=row["cluster name"],
            rule_id=row["rule_id"],
            error_key=row["error_key"],
            disabled=int(row["disabled"]),
        )

        # check the input table
        assert toggle.cluster_name, "Cluster name should be set"
        assert toggle.rule_id, "Rule ID should be set"
        assert toggle.error_key, "Error key should be set"
        assert toggle.disabled in (0, 1), f"Disabled flag should be 0 or 1, not {toggle.disabled}"

        yield toggle


@when("I insert the following rule in the cluster_rule_toggle table for the following cluster")
def insert_rules_into_cluster_rule_toggle_table(context):
    """Insert rows into table cluster_rule_toggle."""
    # timestamps disabled_at and enabled_at are nullable and are not taken into
    # account when the rule is being disabled, so they are left unset
    insert_statement = """INSERT INTO cluster_rule_toggle
                         (cluster_id, rule_id, user_id, disabled, updated_at, error_key)
                         VALUES(%s, %s, %s, %s, %s, %s);"""

    with aggregator_transaction(context) as cursor:
        for toggle in read_cluster_rule_toggles(context):
            cursor.execute(
                insert_statement,
                (
                    toggle.cluster_name,
                    toggle.rule_id,
                    DEFAULT_USER_ID,
                    toggle.disabled,
                    datetime.now(),
                    toggle.error_key,
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

            # the rule has to be disabled by a previous step, otherwise the
            # scenario would silently test something else
            assert cursor.rowcount > 0, (
                f"No rule {toggle.rule_id}|{toggle.error_key} found in "
                f"cluster_rule_toggle for cluster {toggle.cluster_name}"
            )
