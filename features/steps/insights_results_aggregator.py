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

from steps import kafka_util

from behave import when, then
from src.process_output import process_generated_output, filter_coverage_message
from src.utils import get_array_from_json, construct_rh_token

# Insights Results Aggregator binary file name
INSIGHTS_RESULTS_AGGREGATOR_BINARY = "insights-results-aggregator"

# time for newly started Insights Results Aggregator to setup connections and start HTTP server
BREATH_TIME = 2

# path do directory with rules results to be send into Insights Results Aggregator
DATA_DIRECTORY = "test_data"

# REST API access timeout
TIMEOUT = 5000


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
    context.response = requests.get(url, headers={"x-rh-identity": token}, timeout=TIMEOUT)


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


@when("I ask for list of all disabled rules for organization {org} account number {account}, and user {user}")  # noqa E501
def request_list_of_disbled_acked_rules_from_aggregator(context, org, account, user):
    """Send request to tested service to return list of all disabled rules."""
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}/rules/organizations/{org}/disabled_system_wide"  # noqa E501

    # construct RH identity token for provided user info
    token = construct_rh_token(org, account, user)

    # use the token
    context.response = requests.get(url, headers={"x-rh-identity": token}, timeout=TIMEOUT)

    # basic check if service responded
    assert context.response is not None


@when("I enable rule {rule_id} with error key {error_key} for organization {org} account number {account}, and user {user}")  # noqa E501
def enable_rule_in_aggregator(context, rule_id, error_key, org, account, user):
    """Try to enable rule in Insights Results Aggregator."""
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}/rules/{rule_id}/error_key/{error_key}/organizations/{org}/enable"  # noqa E501

    # construct RH identity token for provided user info
    token = construct_rh_token(org, account, user)

    # use the token and request body
    context.response = requests.put(url, headers={"x-rh-identity": token}, timeout=TIMEOUT)

    # basic check if service responded
    assert context.response is not None


@when("I disable rule {rule_id} with error key {error_key} for organization {org} account number {account} and user {user} with justification '{justification}'")  # noqa E501
def disable_rule_in_aggregator(context, rule_id, error_key, org, account, user, justification):
    """Try to disable rule in Insights Results Aggregator."""
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}/rules/{rule_id}/error_key/{error_key}/organizations/{org}/disable"  # noqa E501

    # construct RH identity token for provided user info
    token = construct_rh_token(org, account, user)

    # construct object to be send to the service
    json_request_body = {"justification": justification}

    # use the token and request body
    context.response = requests.put(url, headers={"x-rh-identity": token},
                                    json=json_request_body, timeout=TIMEOUT)

    # basic check if service responded
    assert context.response is not None


@when("I update rule {rule_id} with error key {error_key} for organization {org} account number {account} and user {user} with justification '{justification}'")  # noqa E501
def update_rule_in_aggregator(context, rule_id, error_key, org, account, user, justification):
    """Try to update rule in Insights Results Aggregator."""
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}/rules/{rule_id}/error_key/{error_key}/organizations/{org}/update"  # noqa E501

    # construct RH identity token for provided user info
    token = construct_rh_token(org, account, user)

    # construct object to be send to the service
    json_request_body = {"justification": justification}

    # use the token and request body
    context.response = requests.post(url, headers={"x-rh-identity": token},
                                     json=json_request_body, timeout=TIMEOUT)

    # basic check if service responded
    assert context.response is not None


@then("I should get empty list of disabled rules")
def check_empty_list_of_disabled_rules(context):
    """Check if list of disabled rules is empty."""
    found_rules = context.response.json()["disabledRules"]

    assert len(found_rules) == 0, \
        f"List of disabled rules should be empty but {found_rules} rules was found"


@then("I should get one disabled rule")
@then("I should get {n:n} disabled rules")
def check_empty_list_of_disabled_rules(context, n=1):
    """Check if list of disabled rules is not empty."""
    found_rules = context.response.json()["disabledRules"]

    assert len(found_rules) == n, \
        f"List of disabled rules should contain {n} rules but {found_rules} rules was found"


@then("List of returned rules should contain following rules")
def check_disabled_rules_list(context):
    """Check if returned list of disabled rules contains all required rules."""
    # try to retrieve data to be checked from response payload
    json = context.response.json()
    assert json is not None

    # JSON attribute with list of disabled rules
    assert "disabledRules" in json, "disabledRules attribute is missing in report attribute"
    disabled_rules = json["disabledRules"]

    # check if all acked rules in scenario is found in returned structure
    for expected_rule in context.table:
        expected_org_id = int(expected_rule["Org ID"])
        expected_rule_id = expected_rule["Rule ID"]
        expected_error_key = expected_rule["Error key"]
        expected_justification = expected_rule["Justification"]

        # try to find the corresponding record in list returned by service
        for disabled_rule in disabled_rules:
            actual_org_id = disabled_rule["org_id"]
            actual_rule_id = disabled_rule["rule_id"]
            actual_error_key = disabled_rule["error_key"]
            actual_justification = disabled_rule["justification"]

            # exact match is required
            if all((actual_org_id == expected_org_id,
                    actual_rule_id == expected_rule_id,
                    actual_error_key == expected_error_key,
                    actual_justification == expected_justification)):
                break
        else:
            # record was not found
            raise KeyError(f"Rule {expected_rule} was not returned by the service")


@when("I send rules results '{filename}' into topic '{topic}' to {broker_type} broker")
def send_rules_results_to_kafka(context, filename, topic, broker_type):
    """Send rule results into seleted topic on selected broker."""
    full_path = f"{DATA_DIRECTORY}/{filename}"
    with open(full_path, "r") as fin:
        payload = fin.read().encode("utf-8")
        if broker_type == "local":
            kafka_util.send_event("localhost:9092", topic, payload)


def retrieve_reports(context, cluster):
    """Retrieve actual reports from report structure returned by Insights Results Aggregator."""
    json = context.response.json()
    assert json is not None

    assert "reports" in json, "Reports attribute is missing"
    reports = json["reports"]

    assert cluster in reports, "Cluster report can't be found"
    cluster_data = reports[cluster]

    assert "reports" in cluster_data, "Reports attribute is missing in cluster data"
    return cluster_data["reports"]


@then("The returned report should contain {expected_count:n} rule hits for cluster {cluster}")
@then("The returned report should contain 1 rule hit for cluster {cluster}")
@then("The returned report should contain one rule hit for cluster {cluster}")
def check_rule_hits(context, expected_count=1, cluster="11111111-2222-3333-4444-555555555555"):
    """Check number of rule hits in report returned from Insights Results Aggregator."""
    # retrieve reports
    reports = retrieve_reports(context, cluster)

    # compute number of reports returned
    actual_count = len(reports)

    # compare actual count with expected count
    assert actual_count == expected_count, \
        f"Expected rule hits count: {expected_count}, actual count: {actual_count}"
