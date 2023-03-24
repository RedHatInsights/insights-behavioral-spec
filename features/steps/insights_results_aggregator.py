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

"""Implementation of test steps that run Insights Results Aggregator and check its output."""

import requests
import subprocess
import os
import time

from behave import when, then
from src.process_output import process_generated_output, filter_coverage_message
from src.utils import get_array_from_json, construct_rh_token

# Insights Results Aggregator binary file name
INSIGHTS_RESULTS_AGGREGATOR_BINARY = "insights-results-aggregator"

# time for newly started Insights Results Aggregator to setup connections and start HTTP server
BREATH_TIME = 1


@when("I run the Insights Results Aggregator with the {flag} command line flag")
def run_insights_results_aggregator_with_flag(context, flag):
    """Start the Insights Results Aggregator with given command-line flag."""
    environment = os.environ.copy()
    start_aggregator(context, flag, environment)


@when("I store current environment without Insights Results Aggregator variables")
def store_env_without_insights_results_aggregator_env_vars(context):
    """Store environment variables without variables specific to Insights Results Aggregator."""
    context.no_IRA_environment = {key: value for (key, value) in os.environ.copy().items() if
                                  "INSIGHTS_RESULTS_AGGREGATOR__" not in key}


@when("I run the Insights Results Aggregator with the {flag} command line flag and config file name set to {config}")  # noqa: E501
def run_insights_results_aggregator_with_flag_and_config_file(context, flag, config):
    """Start the Insights Results Aggregator using provided CLI flags and specified config file."""
    environment = os.environ.copy() if not hasattr(context, 'no_IRA_environment') \
        else context.no_IRA_environment
    # add new environment variable into environments
    environment["INSIGHTS_RESULTS_AGGREGATOR_CONFIG_FILE"] = config
    start_aggregator(context, flag, environment)


def start_aggregator(context, flag, environment):
    """Start Insights Results Aggregator with set up command line flags and env. variables."""
    out = subprocess.Popen(
        [INSIGHTS_RESULTS_AGGREGATOR_BINARY, flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        env=environment
    )

    # check if subprocess has been started and its output caught
    assert out is not None

    # don't check exit code at this stage
    process_generated_output(context, out)


def check_help_from_aggregator(context):
    """Check if help is displayed by Insights Results Aggregator."""
    expected_output = """
Clowder is not enabled, skipping init...
Clowder is disabled

Aggregator service for insights results

Usage:

    insights-results-aggregator [command]

The commands are:

    <EMPTY>             starts aggregator
    start-service       starts aggregator
    help                prints help
    print-help          prints help
    print-config        prints current configuration set by files & env variables
    print-env           prints env variables
    print-version-info  prints version info
    migration           prints information about migrations (current, latest)
    migration <version> migrates database to the specified version """

    assert context.stdout is not None
    stdout = context.stdout.decode("utf-8").replace("\t", "    ")

    # preliminary checks
    assert stdout is not None, "stdout object should exist"
    assert type(stdout) is str, "wrong type of stdout object"

    # filter message that can be printed by GOCOVERAGE machinery
    stdout = filter_coverage_message(stdout)

    # check the output
    assert stdout.strip() == expected_output.strip(), "{} != {}".format(
        stdout, expected_output
    )


def check_version_from_aggregator(context):
    """Check if version info is displayed by Insights Results Aggregator."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output, line by line
    for line in context.output:
        if "Version: 0.5" in line:
            break
    else:
        raise Exception("Improper or missing version info in {}".format(context.output))


@then("I should see actual configuration displayed by Insights Results Aggregator on standard output")  # noqa E501
def check_actual_configuration_for_aggregator(context):
    """Check actual configuration printed to standard output by Insights Results Aggregator."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output
    assert "Broker" in context.output[3], "Caught output: {}".format(context.output)
    assert "Address" in context.output[4], "Caught output: {}".format(context.output)
    assert "SecurityProtocol" in context.output[5], "Caught output: {}".format(context.output)
    assert "CertPath" in context.output[6], "Caught output: {}".format(context.output)


@when("I migrate aggregator database to version #{version:n}")
def perform_aggregator_database_migration(context, version):
    """Perform aggregator database migration to selected version."""
    out = subprocess.Popen(
        [INSIGHTS_RESULTS_AGGREGATOR_BINARY, "migrate", str(version)],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # check if subprocess has been started and its output caught
    assert out is not None

    # it is expected that exit code will be 0 or 2
    process_generated_output(context, out, 2)


@when("I migrate aggregator database to latest version")
def perform_aggregator_database_migration_to_latest(context):
    """Perform aggregator database migration to latest version."""
    perform_aggregator_database_migration(context, "latest")


@given("Insights Results Aggregator service is started in background")
def start_insights_results_aggregator_in_background(context):
    """Start Insights Results Aggregator service in background if it is not started already."""
    if hasattr(context, "aggregator_process"):
        if context.aggregator_process.poll() is None:
            return

    process = subprocess.Popen(
        [INSIGHTS_RESULTS_AGGREGATOR_BINARY],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    # background process -> we can't communicate() with it

    # time to breath
    time.sleep(BREATH_TIME)

    # check if process has been created
    assert process is not None, "Process was not created!"

    # check if process has been started
    assert process.poll() is None, "Insights Results Aggregator immediatelly finished!"

    # store process instance for later use
    context.aggregator_process = process


@when("I terminate Insights Results Aggregator")
def terminate_insights_results_aggregator(context):
    """Try to terminate Insights Results Aggregator process."""
    assert hasattr(context, "aggregator_process")
    process = context.aggregator_process

    # check if process runs
    assert process.poll() is None, "Insights Results Aggregator does not run!"

    # try to terminate it and wait for termination
    process.terminate()
    process.kill()
    process.wait()


@then("Insights Results Aggregator process should terminate")
def check_insights_results_aggregator_termination(context):
    """Check if Insights Results Aggregator has been terminated."""
    assert hasattr(context, "aggregator_process")
    process = context.aggregator_process

    # check if process has been really terminated
    assert process.poll() is not None, "Insights Results Aggregator should be terminated!"


@when("I access endpoint {endpoint} using HTTP GET method using token for organization {org} account number {account}, and user {user}")  # noqa: E501
def access_rest_api_endpoint_get_using_token(context, endpoint, org, account, user):
    """Access Insights Results Aggregator service using token generated from provided IDs."""
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}{endpoint}"

    # construct RH identity token for provided user info
    token = construct_rh_token(org, account, user)

    # use the token
    context.response = requests.get(url, headers={"x-rh-identity": token})


@then("I should retrieve empty list of organizations")
def check_empty_list_of_organizations(context):
    """Check if Insights Results Aggregator service returned empty list of organizations."""
    # construct set of actually found organizations
    # from JSON payload returned by the service
    found_organizations = get_array_from_json(context, "organizations")

    # check if the list is empty
    assert len(found_organizations) == 0, \
        "Expected no organizations but {} has been returned".format(found_organizations)


@then("I should retrieve empty list of clusters")
def check_empty_list_of_clusters(context):
    """Check if Insights Results Aggregator service returned empty list of clusters."""
    # construct set of actually found clusters
    # from JSON payload returned by the service
    found_clusters = set(get_array_from_json(context, "clusters"))

    # check if the list is empty
    assert len(found_clusters) == 0, \
        "Expected no clusters but {} has been returned".format(found_clusters)
