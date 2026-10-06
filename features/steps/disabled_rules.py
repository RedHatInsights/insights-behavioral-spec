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

from datetime import datetime

from behave import when

# The notification service selects just the key columns of the disabled rules
# tables, so the user_id column only needs any value satisfying NOT NULL.
DEFAULT_USER_ID = "user1"


def get_aggregator_connection(context):
    """Retrieve the connection to the database with the disabled rules tables.

    Scenarios working with two databases keep the aggregator one in a dedicated
    attribute, because context.connection is taken by the notification
    database. When just one connection is established, that connection is the
    one holding the aggregator tables.
    """
    connection = getattr(context, "aggregator_connection", None)
    if connection is None:
        connection = getattr(context, "connection", None)
    assert connection is not None, "Connection to aggregator database should be established"
    return connection


@when("I insert the following rule in the cluster_rule_toggle table for the following cluster")
def insert_rules_into_cluster_rule_toggle_table(context):
    """Insert rows into table cluster_rule_toggle."""
    connection = get_aggregator_connection(context)
    cursor = connection.cursor()

    try:
        # retrieve table data from feature file
        # columns `org id` and `account number` are not part of the
        # cluster_rule_toggle table, they just identify the cluster for the
        # other steps of the scenario
        for row in context.table:
            cluster_name = row["cluster name"]
            rule_id = row["rule_id"]
            error_key = row["error_key"]
            disabled = int(row["disabled"])

            # check the input table
            assert cluster_name is not None, "Cluster name should be set"
            assert rule_id is not None, "Rule ID should be set"
            assert error_key is not None, "Error key should be set"
            assert disabled in (0, 1), f"Disabled flag should be 0 or 1, not {disabled}"

            # try to perform insert statement
            # timestamps disabled_at and enabled_at are nullable and are not
            # taken into account when the rule is being disabled, so they are
            # left unset
            insert_statement = """INSERT INTO cluster_rule_toggle
                                 (cluster_id, rule_id, user_id, disabled, updated_at, error_key)
                                 VALUES(%s, %s, %s, %s, %s, %s);"""
            cursor.execute(
                insert_statement,
                (
                    cluster_name,
                    rule_id,
                    DEFAULT_USER_ID,
                    disabled,
                    datetime.now(),
                    error_key,
                ),
            )

        connection.commit()
    except Exception as e:
        connection.rollback()
        raise e


@when("I update the following rule in the cluster_rule_toggle table for the following cluster")
def update_rules_in_cluster_rule_toggle_table(context):
    """Update the disabled flag of rows in table cluster_rule_toggle."""
    connection = get_aggregator_connection(context)
    cursor = connection.cursor()

    try:
        # retrieve table data from feature file
        for row in context.table:
            cluster_name = row["cluster name"]
            rule_id = row["rule_id"]
            error_key = row["error_key"]
            disabled = int(row["disabled"])

            # check the input table
            assert cluster_name is not None, "Cluster name should be set"
            assert rule_id is not None, "Rule ID should be set"
            assert error_key is not None, "Error key should be set"
            assert disabled in (0, 1), f"Disabled flag should be 0 or 1, not {disabled}"

            # try to perform update statement
            update_statement = """UPDATE cluster_rule_toggle
                                 SET disabled = %s, updated_at = %s
                                 WHERE cluster_id = %s AND rule_id = %s AND error_key = %s;"""
            cursor.execute(
                update_statement,
                (disabled, datetime.now(), cluster_name, rule_id, error_key),
            )

            # the rule has to be disabled by a previous step, otherwise the
            # scenario would silently test something else
            assert cursor.rowcount > 0, (
                f"No rule {rule_id}|{error_key} found in cluster_rule_toggle "
                f"for cluster {cluster_name}"
            )

        connection.commit()
    except Exception as e:
        connection.rollback()
        raise e
