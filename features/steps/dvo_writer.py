# Copyright © 2024 Jiri Papousek, Red Hat, Inc.
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

"""Implementation of test steps that run DVO writer and check its output."""

import subprocess
import time
from subprocess import TimeoutExpired

from behave import given, then, when
from dateutil import parser
from src.process_output import filepath_from_context

# DVO writer binary file name
DVO_WRITER_BINARY = "insights-results-aggregator"

# time for newly started DVO writer to setup connections
BREATH_TIME = 3


@given("DVO writer service is started in background")
def start_dvo_writer_in_background(context):
    """Start DVO writer service in background if it is not started already."""
    if hasattr(context, "dvo_writer_process"):
        if context.dvo_writer_process.poll() is None:
            return

    # We don't need to communicate with background process and buffering
    # stdout to PIPE will lead to deadlock. We also don't want to mess up
    # Behave output with Aggregator's messages, so at this moment it is
    # best to redirect logs to files for further investigation.
    # Also it allow us to detect error output as well outside BDD framework.
    stdout_file = filepath_from_context(context, "logs/dvo-writer/", "_stdout")
    stderr_file = filepath_from_context(context, "logs/dvo-writer/", "_stderr")
    process = subprocess.Popen(
        [DVO_WRITER_BINARY],
        stdout=open(stdout_file, "w"),
        stderr=open(stderr_file, "w"),
        close_fds=True,
        bufsize=0,
    )
    # background process -> we can't communicate() with it

    # time to breath
    time.sleep(BREATH_TIME)

    # check if process has been created
    assert process is not None, "Process was not created!"

    context.add_cleanup(process.terminate)

    # check if process has been started
    assert process.poll() is None, "DVO writer immediatelly finished!"

    # store process instance for later use
    context.dvo_writer_process = process


@then("DVO table contains the following data")
def dvo_check_db(context):
    """Check that the given data is present in DVO table."""
    cursor = context.connection.cursor()
    try:
        cursor.execute(
            "SELECT org_id, cluster_id, namespace_id, namespace_name, "
            "last_checked_at FROM dvo.dvo_report;",
        )
        results = cursor.fetchall()
        print(results)
        for row in context.table:
            expected = (
                int(row["Organization"]),
                row["Cluster ID"],
                row["Namespace ID"],
                row["Namespace"],
                parser.parse(row["Last checked"]),
            )
            print(expected)
            assert expected in results
        context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e


@given("there are {number} rows in DVO table")
@given("there is {number} row in DVO table")
@then("there are {number} rows in DVO table")
@then("there is {number} row in DVO table")
def dvo_check_db_row_count(context, number):
    """Check there is the given number of rows in DVO table."""
    cursor = context.connection.cursor()
    number = int(number)
    try:
        cursor.execute("SELECT COUNT(*) FROM dvo.dvo_report;")
        row_count = cursor.fetchone()[0]
        assert isinstance(row_count, int)
        context.connection.commit()
        assert (
            row_count == number
        ), f"DVO table contains {row_count} number of rows instead of {number}"
    except Exception as e:
        context.connection.rollback()
        raise e


@when("I terminate DVO writer")
def terminate_dvo_writer(context):
    """Try to terminate DVO writer process."""
    assert hasattr(context, "dvo_writer_process")
    process = context.dvo_writer_process

    # check if process runs
    assert process.poll() is None, "DVO writer does not run!"

    # try to terminate it and wait for termination
    try:
        # try to be nice to DVO writer
        process.terminate()
        process.wait(timeout=10)
    except TimeoutExpired:
        # ok we have to kill this beast
        process.kill()
        process.wait()


@then("DVO writer process should terminate")
def check_dvo_writer_termination(context):
    """Check if DVO writer has been terminated."""
    assert hasattr(context, "dvo_writer_process")
    process = context.dvo_writer_process

    # check if process has been really terminated
    assert process.poll() is not None, "DVO writer should be terminated!"
