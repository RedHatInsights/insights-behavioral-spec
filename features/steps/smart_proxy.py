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

"""Implementation of test steps that run Smart Proxy and check its output."""

import subprocess

from behave import when
from src.process_output import process_generated_output


@when("I run the Smart Proxy with the {flag} command line flag")
def run_insights_results_aggregator_with_flag(context, flag):
    """Start the Smart Proxy with given command-line flag."""
    out = subprocess.Popen(
        ["insights-results-smart-proxy", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # check if subprocess has been started and its output caught
    assert out is not None

    context.add_cleanup(out.terminate)

    # it is expected that exit code will be 0 or 2
    process_generated_output(context, out, 2)


def check_help_from_smart_proxy(context):
    """Check if help is displayed by Smart Proxy."""
    # please take into account that some lines can be (and are) added into output by
    # app-common-go library. We can't control the output and it have changed already.
    expected_output = """
Clowder is disabled

Smart Proxy service for insights results

Usage:

    insights-results-smart-proxy [command]

The commands are:

    <EMPTY>             starts smart-proxy
    start-service       starts smart-proxy
    help                prints help
    print-help          prints help
    print-config        prints current configuration set by files & env variables
    print-env           prints env variables
    print-version-info  prints version info
"""

    assert context.stdout is not None
    stdout = context.stdout.decode("utf-8").replace("\t", "    ")

    # preliminary checks
    assert stdout is not None, "stdout object should exist"
    assert isinstance(stdout, str), "wrong type of stdout object"

    # check if the output contains expected help message
    # any optional garbage above and below help message is ignored
    assert expected_output.strip() in stdout.strip(), f"{stdout} != {expected_output}"


def check_version_from_smart_proxy(context):
    """Check if version info is displayed by Smart Proxy."""
    # preliminary checks
    assert context.output is not None
    assert isinstance(context.output, list), "wrong type of output"

    # check the output, line by line
    for line in context.output:
        if "Version:\tv" in line:
            break
    else:
        raise Exception(f"Improper or missing version info in {context.output}")
