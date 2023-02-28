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
from common_aggregator import DB_TABLES


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


@then(u"I should not be able to find it")
def check_table_existence(context):
    """Check the table existence in the database."""
    assert context.table_found is False, "table should not exist"


@given(u"the database is empty")
@then(u"the database is empty")
@then(u"I should find that the database is empty")
def ensure_database_emptiness(context):
    """Perform check if the database is empty."""
    cursor = context.connection.cursor()
    for table in DB_TABLES:
        try:
            cursor.execute("SELECT 1 from {}".format(table))
            _ = cursor.fetchone()
            context.connection.commit()
            print("DB name: ", context.connection.info.dsn_parameters)
            raise Exception("Table '{}' exists".format(table))
        except UndefinedTable:
            # exception means that the table does not exists
            context.connection.rollback()


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
        except Exception:
            raise


@when(u"I delete all tables from database")
def delete_all_tables(context):
    """Delete all relevant tables from database."""
    for table in DB_TABLES:
        cursor = context.connection.cursor()
        try:
            cursor.execute("DROP TABLE {}".format(table))
            context.connection.commit()
        except Exception:
            context.connection.rollback()
            raise


@when(u"I insert following records into {table} table")
def insert_records_into_selected_table(context, table):
    """Insert provided records into specified table."""
    cursor = context.connection.cursor()

    try:
        headings = context.table.headings

        # construct INSERT statement
        insert_statement = construct_insert_statement(table, headings)

        # perform several INSERTs
        for row in context.table:
            # try to perform INSERT statement
            print(row)
            cursor.execute(insert_statement, row)

        context.connection.commit()
    except Exception:
        context.connection.rollback()
        raise
