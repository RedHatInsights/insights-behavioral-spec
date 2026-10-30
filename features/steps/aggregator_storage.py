# Copyright © 2023 Pavel Tisnovsky, Red Hat, Inc.
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

"""Insights results aggregator database-related operations performed by BDD tests."""

import psycopg2
from behave import given, then, when
from environment import CLEANUP_FILES, DB_INIT_FILES, create_db, prepare_db

MIGRATION_INFO_TABLE = "migration_info"

# Scenarios that work with two databases name the aggregator database
# explicitly. Other scenarios use the default database as the aggregator one.
DEFAULT_AGGREGATOR_DATABASE = "test"


@given("the aggregator database is named {name}")
def given_aggregator_database_name(context, name):
    """Set the aggregator database name."""
    assert name != "", "Aggregator database name should be specified"
    context.aggregator_database_name = name


@given("aggregator database user is set to {user}")
def given_aggregator_database_user(context, user):
    """Set the aggregator database user name."""
    assert user != "", "Aggregator database user name should be specified"
    context.aggregator_database_user = user


@given("aggregator database password is set to {password}")
def given_aggregator_database_password(context, password):
    """Set the aggregator database user password."""
    assert password != "", "Aggregator database user password should be specified"
    context.aggregator_database_password = password


@given("aggregator database is in initial state")
def ensure_aggregator_db_initial_state(context):
    """Ensure that aggregator database is in initial state."""
    if hasattr(context, "aggregator_database_name"):
        # a database dedicated to the aggregator might not exist on the server yet
        database = context.aggregator_database_name
        create_db(context, database)
    else:
        database = DEFAULT_AGGREGATOR_DATABASE

    # the same scripts prepare the aggregator database, no matter how it is named
    prepare_db(context, {database: CLEANUP_FILES[DEFAULT_AGGREGATOR_DATABASE]}, database)
    prepare_db(context, {database: DB_INIT_FILES[DEFAULT_AGGREGATOR_DATABASE]}, database)


@given("aggregator database connection is established")
@when("aggregator database connection is established")
def establish_connection_to_aggregator_database(context):
    """Perform connection to the aggregator database.

    The connection is kept in a dedicated attribute, so it can be used together
    with the connection to another database stored in context.connection.
    """
    assert context.aggregator_database_name is not None
    assert context.aggregator_database_user is not None
    assert context.aggregator_database_password is not None
    connection_string = (
        f"host={context.database_host} port={context.database_port} "
        f"dbname={context.aggregator_database_name} user={context.aggregator_database_user} "
        f"password={context.aggregator_database_password}"
    )
    context.aggregator_connection = psycopg2.connect(connection_string)
    assert context.aggregator_connection is not None, "connection should be established"
    context.add_cleanup(context.aggregator_connection.close)


@when("I read current migration number from database")
def read_migration_number_from_database(context, connection=None):
    """Test step to read current migration number from database."""
    if connection is None:
        connection = context.connection
    cursor = connection.cursor()
    try:
        cursor.execute(f"SELECT version from {MIGRATION_INFO_TABLE} limit 1")
        context.database_migration = cursor.fetchone()[0]
        assert isinstance(context.database_migration, int)
        connection.commit()
    except Exception as e:
        connection.rollback()
        raise e


@when("I read current migration number from aggregator database")
def read_migration_number_from_aggregator_database(context):
    """Test step to read current migration number from the aggregator database."""
    read_migration_number_from_database(context, context.aggregator_connection)


@when("I read current migration number for DVO from database")
def read_dvo_migration_number_from_database(context):
    """Test step to read current migration number for DVO schema from database."""
    cursor = context.connection.cursor()
    try:
        cursor.execute(f"SELECT version from dvo.{MIGRATION_INFO_TABLE} limit 1")
        context.database_migration = cursor.fetchone()[0]
        assert isinstance(context.database_migration, int)
        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@then("I should see that migration #{migration:n} is returned")
def check_migration(context, migration):
    """Check which migration number is stored in database."""
    assert migration == context.database_migration, (
        f"Expected database migration {migration} but "
        f"migration #{context.database_migration} was found"
    )
