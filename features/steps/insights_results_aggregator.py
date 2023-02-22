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

from behave import when, then
from src.process_output import process_generated_output



@when("I run the Insights Results Aggregator with the {flag} command line flag")
def run_insights_results_aggregator_with_flag(context, flag):
    """Start the Insights Results Aggregator with given command-line flag."""
    out = subprocess.Popen(
        ["insights-results-aggregator", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    assert out is not None
    process_generated_output(context, out, 2)


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

    # check the output
    assert stdout.strip() == expected_output.strip(), "{} != {}".format(
        stdout, expected_output
    )

