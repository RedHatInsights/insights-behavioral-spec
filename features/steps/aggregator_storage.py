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

from behave import given, then, when
from environment import CLEANUP_FILES, DB_INIT_FILES, prepare_db

MIGRATION_INFO_TABLE = "migration_info"


@given("aggregator database is in initial state")
def ensure_aggregator_db_initial_state(context):
    """Ensure that aggregator database is in initial state."""
    prepare_db(context, CLEANUP_FILES)
    prepare_db(context, DB_INIT_FILES)


@when("I read current migration number from database")
def read_migration_number_from_database(context):
    """Test step to read current migration number from database."""
    cursor = context.connection.cursor()
    try:
        cursor.execute(f"SELECT version from {MIGRATION_INFO_TABLE} limit 1")
        context.database_migration = cursor.fetchone()[0]
        assert isinstance(context.database_migration, int)
        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@then("I should see that migration #{migration:n} is returned")
def check_migration(context, migration):
    """Check which migration number is stored in database."""
    assert migration == context.database_migration, \
        f"Expected database migration {migration} but migration #{context.database_migration} was found"  # noqa E501
