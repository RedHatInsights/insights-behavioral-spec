# Copyright © 2022 Pavel Tisnovsky, Red Hat, Inc.
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

"""Implementation of test steps that run Insights Aggregator Exporter and check its output."""

import subprocess
from src.process_output import process_generated_output


@when(u"I run the exporter with the {flag} command line flag")
def run_exporter_with_flag(context, flag):
    """Start the exporter with given command-line flag."""
    out = subprocess.Popen(
        ["insights-results-aggregator-exporter", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    assert out is not None
    process_generated_output(context, out, 2)


@when(u"I run the exporter with the following command line flags: {flags}")
def run_exporter_with_flag(context, flags):
    """Start the exporter with given command-line flags."""
    flags = flags.split(" ")
    cli = ["insights-results-aggregator-exporter"] + flags
    out = subprocess.Popen(cli, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    assert out is not None
    process_generated_output(context, out, 2)


@then(u"I should see help messages displayed by exporter on standard output")
def check_help_from_exporter(context):
    """Check if help is displayed by exporter."""
    expected_output = """
Clowder is not enabled, skipping init...
Usage of insights-results-aggregator-exporter:
  -authors
        show authors
  -check-s3-connection
        check S3 connection and exit
  -disabled-by-more-users
        export rules disabled by more users
  -export-log
        export log
  -metadata
        export metadata
  -output string
        output to: file, S3 (default "S3")
  -show-configuration
        show configuration
  -summary
        print summary table after export
  -version
        show version"""

    assert context.stdout is not None
    stdout = context.stdout.decode("utf-8").replace("\t", "    ")

    # preliminary checks
    assert stdout is not None, "stdout object should exist"
    assert type(stdout) is str, "wrong type of stdout object"

    # check the output
    assert stdout.strip() == expected_output.strip(), "{} != {}".format(
        stdout, expected_output
    )


@then(u"I should see version info displayed by exporter on standard output")
def check_version_from_exporter(context):
    """Check if version info is displayed by exporter."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output
    assert (
        "Insights Results Aggregator Exporter version 1.0" in context.output
    ), "Caught output: {}".format(context.output)


@then(u"I should see info about authors displayed by exporter on standard output")
def check_authors_info_from_exporter(context):
    """Check if information about authors is displayed by exporter."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output
    assert (
        "Pavel Tisnovsky, Red Hat Inc." in context.output
    ), "Caught output: {}".format(context.output)


@then(u"I should see info about configuration displayed by exporter on standard output")
def check_configuration_info_from_exporter(context):
    """Check if information about configuration is displayed by exporter."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    stdout = context.stdout.decode("utf-8").replace("\t", "    ")

    # check the output
    expected_artefacts = (
        "DB Name",
        "Username",
        "Host",
        "AccessKeyID",
        "SecretAccessKey",
        "S3 configuration",
        "Storage configuration",
    )
    for expected_artefact in expected_artefacts:
        assert expected_artefact in stdout, "{} not found in output".format(
            expected_artefact
        )
