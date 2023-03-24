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


@then("I should see 1 table in the database")
@then("I should see {expected:n} tables in the database")
def check_number_of_tables(context, expected=1):
    """Perform check how many tables are found in the database."""
    # retrieve list of all tables from current database
    query = "SELECT COUNT(*) AS cnt FROM information_schema.tables WHERE table_schema = 'public';"
    cursor = context.connection.cursor()
    cursor.execute(query)

    # retrieve result from query
    count = cursor.fetchone()
    context.connection.commit()

    # result is returned as tuple -> we need to get the 1st item from that tuple
    assert len(count) == 1, "Wrong number of records returned: {}".format(len(count))
    count = count[0]

    # check number of tables returned
    assert count == expected, \
        f"Wrong number of tables found in database: {count} instead of {expected}"


def read_list_of_tables(context):
    """Read list of tables from current database."""
    query = "SELECT table_name FROM information_schema.tables where table_schema='public';"
    cursor = context.connection.cursor()
    cursor.execute(query)

    # retrieve result from query
    tables = cursor.fetchall()
    context.connection.commit()

    # convert to flat list
    return list(table[0] for table in tables)


@then("I should see these tables in the database")
def check_tables_in_database(context):
    """Check existence of tables in database."""
    existing_tables = read_list_of_tables(context)

    # iterate over all items in feature table
    for row in context.table:
        expected_table = row["Table name"]
        assert expected_table in existing_tables, \
            f"Table {expected_table} does not exist in {existing_tables}"


def store_reports_into_database(context, insert_statement):
    """Store reports into database."""
    cursor = context.connection.cursor()

    try:
        # perform several INSERTs
        for row in context.table:
            organization = row["organization"]
            clusterID = row["cluster ID"]

            # try to perform INSERT statement
            print(row)
            cursor.execute(insert_statement, (organization, clusterID))

        context.connection.commit()
    except Exception:
        context.connection.rollback()
        raise


@given("empty reports are stored for following clusters")
def store_empty_reports_into_database(context):
    """Store empty reports into database."""
    insert_statement = \
        "insert into report(org_id, cluster, report, reported_at, last_checked_at) " + \
        "values (%s, %s, '', now(), now());"

    store_reports_into_database(context, insert_statement)


@given("non empty reports are stored for following clusters")
def store_non_empty_reports_into_database(context):
    """Store non empty reports into database."""
    report = """
    {
        "status": "ok",
        "report": {
            "data": {},
            "meta": {
                "count": 0
            }
        }
    }
    """
    insert_statement = \
        "insert into report(org_id, cluster, report, reported_at, last_checked_at) " + \
        "values (%s, %s, '"+report+"', now(), now());"

    store_reports_into_database(context, insert_statement)
