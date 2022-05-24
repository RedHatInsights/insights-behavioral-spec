# Copyright © 2021, 2022 Pavel Tisnovsky, Red Hat, Inc.
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

import psycopg2
from psycopg2.errors import UndefinedTable
from src.sql import construct_insert_statement

from behave import given, then, when


CREATE_TABLE_ADVISOR_RATINGS = """
CREATE TABLE advisor_ratings (
                                user_id         VARCHAR NOT NULL,
                                org_id          VARCHAR NOT NULL,
                                rule_fqdn       VARCHAR NOT NULL,
                                error_key       VARCHAR NOT NULL,
                                rated_at        TIMESTAMP,
                                last_updated_at TIMESTAMP,
                                rating          SMALLINT,
                                rule_id         VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_REPORT = """
CREATE TABLE report (
                                org_id          INTEGER NOT NULL,
                                cluster         VARCHAR NOT NULL UNIQUE,
                                report          VARCHAR NOT NULL,
                                reported_at     TIMESTAMP,
                                last_checked_at TIMESTAMP,
                                kafka_offset    BIGINT NOT NULL DEFAULT 0,
                                gathered_at     TIMESTAMP,
                                PRIMARY KEY(org_id, cluster)
                        );

"""

CREATE_TABLE_CLUSTER_RULE_TOGGLE = """
CREATE TABLE cluster_rule_toggle (
                                cluster_id  VARCHAR NOT NULL,
                                rule_id     VARCHAR NOT NULL,
                                user_id     VARCHAR NOT NULL,
                                disabled    SMALLINT NOT NULL,
                                disabled_at TIMESTAMP NULL,
                                enabled_at  TIMESTAMP NULL,
                                updated_at  TIMESTAMP NOT NULL,
                                error_key   VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_CLUSTER_RULE_USER_FEEDBACK = """
CREATE TABLE cluster_rule_user_feedback (
                                        cluster_id VARCHAR NOT NULL,
                                        rule_id    VARCHAR NOT NULL,
                                        user_id    VARCHAR NOT NULL,
                                        message    VARCHAR NOT NULL,
                                        user_vote  SMALLINT NOT NULL,
                                        added_at   TIMESTAMP NOT NULL,
                                        updated_at TIMESTAMP NOT NULL,
                                        error_key  VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_CLUSTER_USER_RULE_DISABLE_FEEDBACK = """
CREATE TABLE cluster_user_rule_disable_feedback (
                                cluster_id VARCHAR NOT NULL,
                                user_id    VARCHAR NOT NULL,
                                rule_id    VARCHAR NOT NULL,
                                message    VARCHAR NOT NULL,
                                added_at   TIMESTAMP NOT NULL,
                                updated_at TIMESTAMP NOT NULL,
                                error_key  VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_RULE_HIT = """
CREATE TABLE rule_hit (
                        org_id          INTEGER NOT NULL,
                        cluster_id      VARCHAR NOT NULL,
                        rule_fqdn       VARCHAR NOT NULL,
                        error_key       VARCHAR NOT NULL,
                        template_data   VARCHAR NOT NULL,
                        PRIMARY KEY(cluster_id, org_id, rule_fqdn, error_key)
                        );
"""

CREATE_TABLE_CONSUMER_ERROR = """
CREATE TABLE consumer_error (
                        topic        VARCHAR NOT NULL,
                        partition    INTEGER NOT NULL,
                        topic_offset INTEGER NOT NULL,
                        key          VARCHAR,
                        produced_at  TIMESTAMP NOT NULL,
                        consumed_at  TIMESTAMP NOT NULL,
                        message      VARCHAR,
                        error        VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_MIGRATION_INFO = """
CREATE TABLE migration_info (
                        version INTEGER NOT NULL
);
"""

CREATE_TABLE_RECOMMENDATION = """
CREATE TABLE recommendation (
                        org_id     INTEGER NOT NULL,
                        cluster_id VARCHAR NOT NULL,
                        rule_fqdn  TEXT NOT NULL,
                        error_key  VARCHAR NOT NULL,
                        rule_id    VARCHAR NOT NULL,
                        created_at TIMESTAMP
);
"""

CREATE_TABLE_REPORT_INFO = """
CREATE TABLE report_info (
                        org_id       INTEGER NOT NULL,
                        cluster_id   VARCHAR NOT NULL,
                        version_info VARCHAR NOT NULL
);
"""

CREATE_TABLE_RULE_DISABLE = """
CREATE TABLE rule_disable (
                        org_id        VARCHAR NOT NULL,
                        user_id       VARCHAR NOT NULL,
                        rule_id       VARCHAR NOT NULL,
                        error_key     VARCHAR NOT NULL,
                        justification VARCHAR,
                        created_at    TIMESTAMP,
                        updated_at    TIMESTAMP
);
"""

# all commands to create tables
CREATE_TABLE_COMMANDS = (
        CREATE_TABLE_ADVISOR_RATINGS,
        CREATE_TABLE_REPORT,
        CREATE_TABLE_CLUSTER_RULE_TOGGLE,
        CREATE_TABLE_CLUSTER_RULE_USER_FEEDBACK,
        CREATE_TABLE_CLUSTER_USER_RULE_DISABLE_FEEDBACK,
        CREATE_TABLE_RULE_HIT,
        CREATE_TABLE_CONSUMER_ERROR,
        CREATE_TABLE_MIGRATION_INFO,
        CREATE_TABLE_RECOMMENDATION,
        CREATE_TABLE_REPORT_INFO,
        CREATE_TABLE_RULE_DISABLE,
        )

# following tables should be processed
DB_TABLES = (
        "advisor_ratings",
        "report",
        "cluster_rule_toggle",
        "cluster_rule_user_feedback",
        "cluster_user_rule_disable_feedback",
        "rule_hit",
        "consumer_error",
        "migration_info",
        "recommendation",
        "report_info",
        "rule_disable",
)


@when(u"I connect to database named {database} as user {user} with password {password}")
def connect_to_database(context, database, user, password):
    """Perform connection to selected database."""
    connection_string = "dbname={} user={} password={}".format(database, user, password)
    context.connection = psycopg2.connect(connection_string)


@then(u"I should be able to connect to such database")
def check_connection(context):
    """Chck the connection to database."""
    assert context.connection is not None, "connection should be established"


@when(u"I close database connection")
def disconnect_from_database(context):
    """Close the connection to database."""
    context.connection.close()
    context.connection = None


@then(u"I should be disconnected")
def check_disconnection(context):
    """Check that the connection has been closed."""
    assert context.connection is None, "connection should be closed"


@when(u"I look for the table {table} in database")
def look_for_table(context, table):
    """Try to find a table in database."""
    cursor = context.connection.cursor()
    try:
        cursor.execute("SELECT 1 from {}".format(table))
        v = cursor.fetchone()
        context.table_found = True
    except UndefinedTable as e:
        context.table_found = False

    context.connection.commit()


@then(u"I should not be able to find it")
def check_table_existence(context):
    """Check the table existence in the database."""
    assert context.table_found is False, "table should not exist"


@given(u"the database is named {name}")
def given_database_name(context, name):
    """Set the database name."""
    assert name != "", "Database name should be specified"
    context.database_name = name


@given(u"database user is set to {user}")
def given_database_user(context, user):
    """Set the database user name."""
    assert user != "", "Database user name should be specified"
    context.database_user = user


@given(u"database password is set to {password}")
def given_database_password(context, password):
    """Set the database user password."""
    assert password != "", "Database user password should be specified"
    context.database_password = password


@given(u"database connection is established")
@when(u"database connection is established")
def establish_connection_to_database(context):
    """Perform connection to selected database."""
    assert context.database_name is not None
    assert context.database_user is not None
    assert context.database_password is not None
    connection_string = "dbname={} user={} password={}".format(
        context.database_name, context.database_user, context.database_password
    )
    context.connection = psycopg2.connect(connection_string)
    assert context.connection is not None, "connection should be established"


@given(u"the database is empty")
@then(u"the database is empty")
@then(u"I should find that the database is empty")
def ensure_database_emptiness(context):
    """Perform check if the database is empty."""

    cursor = context.connection.cursor()
    for table in DB_TABLES:
        try:
            cursor.execute("SELECT 1 from {}".format(table))
            v = cursor.fetchone()
            context.connection.commit()
            raise Exception("Table '{}' exists".format(table))
        except UndefinedTable as e:
            # exception means that the table does not exists
            context.connection.rollback()
            pass


@then(u"I should find that all tables are empty")
def ensure_data_tables_emptiness(context):
    """Perform check if data tables are empty."""
    for table in DB_TABLES:
        cursor = context.connection.cursor()
        try:
            cursor.execute("SELECT count(*) as cnt from {}".format(table))
            results = cursor.fetchone()
            assert len(results) == 1, "Wrong number of records returned: {}".format(
                len(results)
            )
            assert results[0] == 0, "Table '{}' is not empty as expected".format(table)
        except Exception as e:
            raise e


@when(u"I prepare database schema")
def prepare_database_schema(context):
    """Prepare database schema."""
    cursor = context.connection.cursor()
    try:
        for createTableCommand in CREATE_TABLE_COMMANDS:
            cursor.execute(createTableCommand)
            context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@when(u"I delete all tables from database")
def delete_all_tables(context):
    """Delete all relevant tables from database."""
    for table in DB_TABLES:
        cursor = context.connection.cursor()
        try:
            cursor.execute("DROP TABLE {}".format(table))
            context.connection.commit()
        except Exception as e:
            context.connection.rollback()
            raise e


@when(u"I insert following records into {table} table")
def insert_records_into_selected_table(context, table):
    """Insert provided records into specified table."""

    cursor = context.connection.cursor()

    try:
        headings = context.table.headings

        # construct INSERT statement
        insert_statement = construct_insert_statement(table, headings)

        # assert insert_statement == "", insert_statement

        # perform several INSERTs
        for row in context.table:
            # try to perform INSERT statement
            cursor.execute(insert_statement, row)

        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e
