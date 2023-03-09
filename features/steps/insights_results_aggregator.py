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

from behave import when, then
from src.process_output import process_generated_output, filter_coverage_message


@when("I run the Insights Results Aggregator with the {flag} command line flag")
def run_insights_results_aggregator_with_flag(context, flag):
    """Start the Insights Results Aggregator with given command-line flag."""
    environment = os.environ.copy()
    start_aggregator(context, flag, environment)


@when("I run the Insights Results Aggregator with the {flag} command line flag and config file name set to {config}")  # noqa: E501
def run_insights_results_aggregator_with_flag_and_config_file(context, flag, config):
    environment = os.environ.copy()
    environment["INSIGHTS_RESULTS_AGGREGATOR_CONFIG_FILE"] = config
    start_aggregator(context, flag, environment)


def start_aggregator(context, flag, environment):
    """Start Insights Results Aggregator with set up command line flags and env. variables."""
    out = subprocess.Popen(
        ["insights-results-aggregator", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        env=environment
    )

    assert out is not None
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
        ["insights-results-aggregator", "migrate", str(version)],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    assert out is not None
    process_generated_output(context, out, 2)
