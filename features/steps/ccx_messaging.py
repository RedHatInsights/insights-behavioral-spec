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

"""Implementation of common steps for all services using ccx-messaging module."""

import gzip
import json
import os
import select
import subprocess
import time

from behave import given, then, when
from src import kafka_util
from src.process_output import filepath_from_context
from src.utils import validate_json

SERVICES = {"SHA extractor": "insights_sha_extractor", "DVO extractor": "dvo_extractor"}


def transform_service_name(service_name):
    """Transform service name used in test steps to name used in dictionaries and config names."""
    return SERVICES[service_name]


@given("{service} service is not started")
def service_not_started(context, service):
    """Check if SHA extractor service has been started."""
    service_name = transform_service_name(service)
    assert not hasattr(context, "services") or service_name not in context.services.keys()


@given('Kafka topic specified in configuration variable "{topic_var}" is created')
def check_topic_created(context, topic_var):
    """Check if specified Kafka topic has been created."""
    context.kafka_hostname = context.hostname.split(":")[0]
    context.kafka_port = context.hostname.split(":")[1]

    visit = []
    visit.append(context.service_config)
    while visit:
        conf_branch = visit.pop()
        for k, v in conf_branch.items():
            if isinstance(v, dict):
                visit.append(v)
            elif k == topic_var:
                kafka_util.delete_topic(context, v)
                kafka_util.create_topic(context.hostname, v)
                setattr(context, k, v)


@when("{service} service is started")
@when('{service} service is started in group "{group_id}"')
@given("{service} service is started")
def start_ccx_messaging_service(context, service, group_id=None):
    """Start service using ccx-messaging module."""
    if group_id:
        os.environ["CDP_GROUP_ID"] = group_id

    service_name = transform_service_name(service)

    # Create log files for stdout and stderr
    stdout_file = filepath_from_context(context, f"logs/{service_name}/", "_stdout")
    stderr_file = filepath_from_context(context, f"logs/{service_name}/", "_stderr")

    process = subprocess.Popen(
        ["ccx-messaging", f"config/{service_name}.yaml"],
        stdout=open(stdout_file, "w"),
        stderr=open(stderr_file, "w"),
        text=True,
        encoding="utf-8",
        env=os.environ.copy(),
    )
    assert process is not None, "Process was not created"
    context.add_cleanup(process.terminate)

    if not hasattr(context, "services"):
        context.services = {}

    if not hasattr(context, "service_logs"):
        context.service_logs = {}

    context.services[service_name] = process
    # Store log file paths in separate dictionary
    context.service_logs[service_name] = {"stdout": stdout_file, "stderr": stderr_file}


@then("{service} validates the message format")
def check_message(context, service):
    """Check if consumed message is represented in JSON."""
    expected_msg = "JSON schema validated"
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "can't parse message"


@when('the file "config/workload_info.json" is not found by {service}')
def check_workload_info_not_present(context, service):
    """Step when workload_info.json is not in the archive."""
    expected_msg = "archive does not contain workload info; skipping"
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "archive should not contain workload_info.json for this scenario"


@when('the file "config/workload_info.json" is found by {service}')
def check_workload_info_present(context, service):
    """Step when workload_info.json is present in the archive."""
    expected_msg = "workload info found, starting publishing process"
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "archive should contain workload_info.json for this scenario"


@then("{service} decode the b64_identity attribute")
def check_b64_decode(context, service):
    """Check if ccx-messaging service was able to decode b64_identity attribute from a message."""
    service_name = transform_service_name(service)
    expected_msg = "'identity': {'identity':"
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "b64_identity was not extracted"


@then("{service} should consume message about this event")
def check_message_consumed(context, service):
    """Check if message has been consumed by ccx-messaging service."""
    service_name = transform_service_name(service)
    assert not context.services[service_name].returncode, f"{service} is not running"

    expected_msg = "Deserializing incoming message"
    stdout_file = context.service_logs[service_name]["stdout"]
    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "message was not consumed"


@then("{service} service does not exit with an error code")
def service_is_running(context, service):
    """Check if ccx-messaging service has been started."""
    service_name = transform_service_name(service)
    assert not context.services[service_name].poll(), f"{service} is not started"


@then('{service} service should be registered to topic "{topic}"')
def topic_registered(context, service, topic):
    """Check if ccx-messaging service registered itself to consume given topic."""
    service_name = transform_service_name(service)
    topic_name = context.__dict__["_stack"][0][topic]
    expected_msg = f"Consuming topic '{topic_name}' " + f"from brokers {context.hostname}"
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "consumer topic not registered"


@then('{service} retrieves the "url" attribute from the message')
def check_url(context, service):
    """Check that ccx-messaging service is able to retrieve URL from incoming message."""
    expected_msg = "Extracted URL from input message"
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "can't parse url from message"


@then("{service} should download tarball from given URL attribute")
def check_start_download(context, service):
    """Check that ccx-messaging service is able to start download."""
    expected_msg = "Downloading"
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "download not started"


@then("the tarball is not further processed")
def archive_not_processed(context):
    """Check that ccx-messaging service did not process any event."""
    consumed = kafka_util.consume_event(context.kafka_hostname, context.outgoing_topic)
    assert not consumed, "message should not exist in outgoing topic"


@then('message has been sent by {service} into topic "archive-results"')
def archive_processed(context, service):
    """Check that ccx-messaging service did process the event."""
    expected_msg = "Message has been sent successfully."
    service_name = transform_service_name(service)
    stdout_file = context.service_logs[service_name]["stdout"]

    assert message_in_buffer(
        expected_msg,
        stdout_file,
    ), "{service} did not produce a result"

    msg = kafka_util.consume_message_from_topic(context.kafka_hostname, context.outgoing_topic)
    assert msg.value is not None, "message has not been sent"


@then('produced message contains "{field}" field')
def valid_message(context, field):
    """Check that the produced message is valid."""
    msg = kafka_util.consume_message_from_topic(context.kafka_hostname, context.outgoing_topic)
    assert field not in msg, f'message does not contain "{field}" field'


@then("message sent by {service} has expected format")
def check_message_schema(context, service):
    """Check the schema of the message produced by the service."""
    msg = kafka_util.consume_message_from_topic(context.kafka_hostname, context.outgoing_topic)
    service_name = transform_service_name(service)

    with open(f"test_data/{service_name}_schema.json") as file:
        schema = json.load(file)
        validate_json(json.loads(msg.value), schema)


@given("{service} service is started with compression")
def start_service_compressed(context, service, group_id=None):
    """Start ccx-messaging service with compressed messages."""
    if group_id:
        os.environ["CDP_GROUP_ID"] = group_id

    service_name = transform_service_name(service)
    process = subprocess.Popen(
        ["ccx-messaging", f"config/{service_name}_compressed.yaml"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        env=os.environ.copy(),
    )
    assert process is not None, "Process was not created"
    context.add_cleanup(process.terminate)

    if not hasattr(context, "services"):
        context.services = {}

    context.services[service_name] = process


@then("published message has to be compressed")
def compressed_archive_sent_to_topic(context):
    """Check that service publishes compressed messages to outgoing topic."""
    decoded = None
    error = None
    message = kafka_util.consume_message_from_topic(
        context.kafka_hostname,
        context.outgoing_topic,
    )
    try:
        decoded = gzip.decompress(message.value)
    except Exception as err:
        error = err
    assert decoded is not None and error is None


@then("published message should not be compressed")
def no_compressed_archive_sent_to_topic(context):
    """Check that service does not publish compressed messages to topic."""
    decoded = None
    error = None
    message = kafka_util.consume_message_from_topic(
        context.kafka_hostname,
        context.outgoing_topic,
    )
    try:
        decoded = gzip.decompress(message.value)
    except Exception as err:
        error = err
    assert decoded is None and error is not None


def message_in_buffer(message, buffer, timeout=60.0):
    """Check if service prints given message on its output."""
    # If buffer is a string (file path), read from file
    if isinstance(buffer, str):
        start_time = time.time()
        while time.time() - start_time < timeout:
            try:
                with open(buffer, "r") as f:
                    content = f.read()
                    if message in content:
                        return True
            except FileNotFoundError:
                pass
            time.sleep(0.1)
        return False

    # Original pipe-based logic for backward compatibility
    while True:
        ready = select.select([buffer], [], [], timeout)[0]
        if ready:
            line = buffer.readline()

            if not line:
                # empty readline means EOF
                return False

            if message in line:
                return True

        else:
            # Timeout!
            return False
