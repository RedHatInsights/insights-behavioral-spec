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

from behave import then, when, given

import subprocess
import psycopg2


@when(u"I connect to database named {database} as user {user} with password {password}")
def connect_to_database(context, database, user, password, host="localhost"):
    """Perform connection to selected database."""
    connection_string = "dbname={} user={} password={} host={}".format(
        database, user, password, host
    )
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


@given("Postgres is running")
def check_if_postgres_is_running(context):
    """Check if Postgresql service is active."""
    p = subprocess.Popen(["pg_isready", "-q", "--host", "localhost", "--port", "5432"])
    assert p is not None

    # interact with the process:
    p.communicate()

    # check the return code
    assert (
        p.returncode == 0
    ), "Postgresql service not running: got return code {code}".format(
        code=p.returncode
    )
