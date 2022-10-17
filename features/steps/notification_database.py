# Copyright © 2021 Pavel Tisnovsky, Red Hat, Inc.
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

"""Database-related operations performed by BDD tests."""

import subprocess
import psycopg2
from psycopg2.errors import UndefinedTable
from datetime import datetime, timedelta


from behave import given, when, then, step


@step("CCX Notification database is created for user {user} with password {password}")
def database_is_created(context, user, password):
    """Perform connection to CCX Notification database to check its ability."""
    from steps.common_db import connect_to_database
    connect_to_database(context, "notification", user, password)


@given(u"CXX Notification Writer database contains all required tables")
def database_contains_all_tables(context):
    """Check if CCX Notification Writer database contains all required tables."""
    # TODO: implement this step
    raise NotImplementedError(
        u"STEP: Given CXX Notification Writer database contains all tables"
    )


@given("CCX Notification Service database is set up")
def ensure_database_is_set_up(context):
    """Check that the tables exist in the DB."""
    # at least following tables should exist
    tables = ("migration_info",
              "new_reports",
              "notification_types",
              "reported",
              "states",
              "event_targets")

    cursor = context.connection.cursor()
    for table in tables:
        try:
            cursor.execute("SELECT 1 from {}".format(table))
            v = cursor.fetchone()
            context.connection.commit()
        except UndefinedTable as e:
            context.connection.rollback()
            raise e
    pass


@given("CCX Notification database is empty")
def notification_db_empty(context):
    """Ensure that the CCX Notification database has no reports, but has all tables."""
    # We actually only want `new_reports` and `reported` table to be empty, so let's clean up
    cursor = context.connection.cursor()
    try:
        cursor.execute("TRUNCATE TABLE new_reports")
        cursor.execute("TRUNCATE TABLE reported")
        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@given(u"CCX Notification Writer database is not set up")
def ensure_database_emptiness(context):
    """Check that the tables do not exist in the DB."""
    # at least following tables should not exists
    tables = (
        "report",
        "cluster_rule_toggle",
        "cluster_rule_user_feedback",
        "cluster_user_rule_disable_feedback",
        "rule_hit",
    )

    cursor = context.connection.cursor()
    for table in tables:
        try:
            cursor.execute("SELECT 1 from {}".format(table))
            v = cursor.fetchone()
            context.connection.commit()
            raise Exception("Table '{}' exists".format(table))
        except UndefinedTable as e:
            # exception means that the table does not exists
            # which is expected behaviour
            context.connection.rollback()
            pass


@when(u"I select all rows from table {table}")
def select_all_rows_from_table(context, table):
    """Select number of all rows from given table."""
    cursor = context.connection.cursor()
    try:
        cursor.execute("SELECT count(*) as cnt from {}".format(table))
        results = cursor.fetchone()
        assert len(results) == 1, "Wrong number of records returned: {}".format(
            len(results)
        )
        context.query_count = results[0]
    except Exception as e:
        raise e


@then(u"I should get {expected_count:d} row")
@then(u"I should get {expected_count:d} rows")
def check_rows_count(context, expected_count):
    """Check if expected number of rows were returned."""
    assert (
        context.query_count == expected_count
    ), "Wrong number of rows returned: {} instead of {}".format(
        context.query_count, expected_count
    )


@given(u"I insert following row into table new_reports")
@given(u"I insert following rows into table new_reports")
def insert_rows_into_new_reports_table(context):
    """Insert rows into table new_reports."""
    cursor = context.connection.cursor()

    try:
        # retrieve table data from feature file
        for row in context.table:
            org_id = int(row["org id"])
            account_number = int(row["account number"])
            cluster_name = row["cluster name"]
            updated_at = row["updated at"]
            kafka_offset = int(row["kafka offset"])

            # check the input table
            assert org_id is not None, "Organization ID should be set"
            assert account_number is not None, "Account number should be set"
            assert cluster_name is not None, "Cluster name should be set"
            assert updated_at is not None, "Timestamp updated_at should be set"
            assert kafka_offset is not None, "Kafka offset should be set"

            # try to perform insert statement
            insertStatement = """INSERT INTO new_reports
                                 (org_id, account_number, cluster, report, updated_at, kafka_offset)
                                 VALUES(%s, %s, %s, '', %s, %s);"""
            cursor.execute(
                insertStatement,
                (org_id, account_number, cluster_name, updated_at, kafka_offset),
            )

        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@given(u"I insert following row into table reported")
@given(u"I insert following rows into table reported")
def insert_rows_into_reported_table(context, report='', default_notified_at=None):
    """Insert rows into table reported."""
    cursor = context.connection.cursor()

    try:
        # retrieve table data from feature file
        for row in context.table:
            org_id = int(row["org id"])
            account_number = int(row["account number"])
            cluster_name = row["cluster name"]
            notification_type = int(row["notification type"])
            state = int(row["state"])
            updated_at = row["updated at"]
            notified_at = default_notified_at or row["notified at"]
            event_type_id = row["event type id"]
            try:
                error_log = row["error log"]
            except KeyError:
                error_log = ""
                pass

            # check the input table
            assert org_id is not None, "Organization ID should be set"
            assert account_number is not None, "Account number should be set"
            assert cluster_name is not None, "Cluster name should be set"
            assert updated_at is not None, "Timestamp updated_at should be set"
            assert notified_at is not None, "Timestamp notified_at should be set"
            assert error_log is not None, "Kafka offset should be set"
            assert event_type_id is not None, "Event type ID should be set"

            # try to perform insert statement
            insertStatement = """INSERT INTO reported
                                 (org_id, account_number, cluster, notification_type, state,
                                  report, updated_at, notified_at, error_log, event_type_id)
                                 VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            cursor.execute(
                insertStatement,
                (
                    org_id,
                    account_number,
                    cluster_name,
                    notification_type,
                    state,
                    report,
                    updated_at,
                    notified_at,
                    error_log,
                    event_type_id,
                ),
            )

        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@when("I insert 1 report with {risk:w} total risk for the following clusters")
def insert_report_with_risk_in_new_reports_table(context, risk, updated_at=None):
    """Insert rows into table new_reports."""
    report = generate_report_with_risk(risk)

    if not updated_at:
        updated_at = datetime.now()
    cursor = context.connection.cursor()

    try:
        # try to perform insert statement
        for row in context.table:
            org_id = int(row["org id"])
            account_number = int(row["account number"])
            cluster_name = row["cluster name"]
            insertStatement = """INSERT INTO new_reports
                                    (org_id, account_number, cluster, report, updated_at, kafka_offset)
                                    VALUES(%s, %s, %s, %s, %s, %s);"""  # noqa E501
            cursor.execute(insertStatement, (
                org_id, account_number, cluster_name, report, updated_at, 0))
        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@when("I insert 1 report with {risk:w} total risk after cooldown has passed for the following clusters")  # noqa E501
def insert_report_with_risk_and_cooldown_in_new_reports_table(context, risk):
    """Insert rows into table new_reports after the cooldown has passed."""
    timestamp_after_cooldown = datetime.now() + timedelta(minutes=1)
    insert_report_with_risk_in_new_reports_table(context, risk, updated_at=timestamp_after_cooldown)


@given("I insert 1 previously reported report with {risk:w} total risk")
def insert_report_into_reported_table(context, risk, timestamp=None):
    """Inserts rows into reported table."""
    report = generate_report_with_risk(risk)
    insert_rows_into_reported_table(context, report, timestamp)


@given("I insert 1 previously reported report with {risk:w} total risk notified within cooldown")
def insert_report_within_cooldown_in_reported_table(context, risk):
    """Inserts rows into reported table within cooldown."""
    timestamp_within_cooldown = datetime.now() - timedelta(seconds=30)
    insert_report_into_reported_table(context, risk, timestamp_within_cooldown)


def generate_report_with_risk(risk):
    """Creates a report with specified risk."""
    report = '{"analysis_metadata":{"metadata":"some metadata"},"reports":[{"rule_id":"test_rule|<replace_me>","component":"ccx_rules_ocp.external.rules.test_rule.report","type":"rule","key":"<replace_me>","details":"some details"}]}'  # noqa E501
    risk_rule_key_map = {
        "critical": "TEST_RULE_CRITICAL_IMPACT",
        "important": "TEST_RULE_IMPORTANT_IMPACT",
        "moderate": "TEST_RULE_MODERATE_IMPACT",
        "low": "TEST_RULE_LOW_IMPACT"
    }
    report.replace("<replace_me>", risk_rule_key_map[risk])
    return report
