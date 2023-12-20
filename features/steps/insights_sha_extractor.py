# Copyright © 2023, José Luis Segura Lucas, Red Hat, Inc.
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

"""Implementation of test steps that run Insights SHA Extractor and check its output."""

import os
import subprocess

import yaml
from behave import given, then, when
from kafka.cluster import ClusterMetadata
from src import kafka_util


@given("SHA extractor service is not started")
def sha_extractor_not_started(context):
    """Check if SHA extractor service has been started."""
    assert not hasattr(context, "sha_extractor")


@given("Kafka broker is started on host and port specified in configuration")
def kafka_broker_running(context):
    """Check if Kafka broker is running on specified address."""
    config = None
    with open("config/insights_sha_extractor.yaml", "r") as file:
        config = yaml.safe_load(file)
        context.sha_config = config
    hostname = config["service"]["consumer"]["kwargs"]["bootstrap.servers"]
    context.hostname = hostname
    context.kafka_hostname = hostname.split(":")[0]
    context.kafka_port = hostname.split(":")[1]

    metadata = ClusterMetadata(bootstrap_servers=hostname)
    context.metadata = metadata
    assert len(metadata.brokers()) > 0


@given('Kafka topic specified in configuration variable "{topic_var}" is created')
def check_topic_created(context, topic_var):
    """Check if specified Kafka topic has been created."""
    context.kafka_hostname = context.hostname.split(":")[0]
    context.kafka_port = context.hostname.split(":")[1]

    visit = []
    visit.append(context.sha_config)
    while visit:
        conf_branch = visit.pop()
        for k, v in conf_branch.items():
            if isinstance(v, dict):
                visit.append(v)
            elif k == topic_var:
                kafka_util.delete_topic(context, v)
                kafka_util.create_topic(context.hostname, v)
                setattr(context, k, v)


@when("SHA extractor service is started")
@when('SHA extractor service is started in group "{group_id}"')
@given("SHA extractor service is started")
def start_sha_extractor(context, group_id=None):
    """Start SHA Extractor service."""
    if group_id:
        os.environ["CDP_GROUP_ID"] = group_id

    sha_extractor = subprocess.Popen(
        ["insights-sha-extractor", "config/insights_sha_extractor.yaml"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        env=os.environ.copy(),
    )
    assert sha_extractor is not None, "Process was not created"
    context.add_cleanup(sha_extractor.terminate)
    context.sha_extractor = sha_extractor


@when('the file "config/workload_info.json" is not found')
def check_workload_info_not_present(context):
    """Step when workload_info.json is not in the archive."""
    expected_msg = "archive does not contain workload info; skipping"

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "archive should not contain workload_info.json for this scenario"


@when('the file "config/workload_info.json" is found')
def check_workload_info_present(context):
    """Step when workload_info.json is present in the archive."""
    expected_msg = "workload info found, starting publishing process"

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "archive should contain workload_info.json for this scenario"


@then("SHA extractor decode the b64_identity attribute")
def check_b64_decode(context):
    """Check if SHA extractor was able to decode b64_identity attribute from a message."""
    expected_msg = "'identity': {'identity':"

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "b64_identity was not extracted"


@then("SHA extractor should consume message about this event")
def check_message_consumed(context):
    """Check if message has been consumed by SHA extractor."""
    assert not context.sha_extractor.returncode, "sha extractor is not running"

    expected_msg = "Deserializing incoming message"
    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "message was not consumed"


@then("SHA extractor service does not exit with an error code")
def sha_extractor_is_running(context):
    """Check if SHA Extractor service has been started."""
    assert not context.sha_extractor.poll(), "sha extractor service was not started"


@then('SHA extractor service should be registered to topic "{topic}"')
def topic_registered(context, topic):
    """Check if SHA Extractor registered itself to consume given topic."""
    topic_name = context.__dict__["_stack"][0][topic]
    expected_msg = (
        f"Consuming topic '{topic_name}' " + f"from brokers {context.hostname}"
    )

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "consumer topic not registered"


@then("this message should contain following attributes")
def check_message(context):
    """Check if consumed message is represented in JSON."""
    expected_msg = "JSON schema validated"

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "can't parse message"


@then('SHA extractor retrieve the "url" attribute from the message')
def check_url(context):
    """Check that sha extractor is able to retrieve URL from incoming message."""
    expected_msg = "Extracted URL from input message"
    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "can't parse url from message"


@then("SHA extractor should download tarball from given URL attribute")
def check_start_download(context):
    """Check that sha extractor is able to start download."""
    expected_msg = "Downloading"
    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "download not started"


@then("the tarball is not further processed")
def archive_not_precessed(context):
    """Check that sha extractor did not process any event."""
    consumed = kafka_util.consume_event(context.kafka_hostname, context.outgoing_topic)
    assert not consumed, "message should not exist in outgoing topic"


@then('the content of this file needs to be sent into topic "archive_results"')
def archive_processed(context):
    """Check that sha extractor did process the event."""
    expected_msg = "Message has been sent successfully."

    assert message_in_buffer(
        expected_msg, context.sha_extractor.stdout
    ), "sha extractor did not produce a result"


def message_in_buffer(message, buffer):
    """Check if SHA Extractor service prints given message on its output."""
    found = False
    while True:
        # readline can be blocking, run this
        # test with a timeout
        line = buffer.readline()
        if message in line:
            found = True
            break

    return found
