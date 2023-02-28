# Copyright © 2022 Red Hat, Inc.
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

"""Common steps for DB related operations."""


import psycopg2
from behave import when, then


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


@when(u"I connect to database named {database} as user {user} with password {password}")
def connect_to_database(context, database, user, password):
    """Perform connection to selected database."""
    connection_string = "dbname={} user={} password={} host={} port={}".format(
        database, user, password, context.database_host, context.database_port
    )
    context.connection = psycopg2.connect(connection_string)


@then(u"I should be able to connect to such database")
def check_connection(context):
    """Check the connection to database."""
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


@given(u"database connection is established")
@when(u"database connection is established")
def establish_connection_to_database(context):
    """Perform connection to selected database."""
    assert context.database_name is not None
    assert context.database_user is not None
    assert context.database_password is not None
    assert context.database_host is not None
    assert context.database_port is not None
    connection_string = "host={} port={} dbname={} user={} password={}".format(
        context.database_host,
        context.database_port,
        context.database_name,
        context.database_user,
        context.database_password,
    )
    context.connection = psycopg2.connect(connection_string)
    assert context.connection is not None, "connection should be established"


@when(u"I look for the table {table} in database")
def look_for_table(context, table):
    """Try to find a table in database."""
    cursor = context.connection.cursor()
    try:
        cursor.execute("SELECT 1 from {}".format(table))
        _ = cursor.fetchone()
        context.table_found = True
    except UndefinedTable:
        context.table_found = False

    context.connection.commit()


@then(u"I should be able to find it")
def check_table_existence(context):
    """Check the table existence in the database."""
    assert context.table_found is True, "table should exist"


@then(u"I should not be able to find it")
def check_table_non_existence(context):
    """Check the table existence in the database."""
    assert context.table_found is False, "table should not exist"
