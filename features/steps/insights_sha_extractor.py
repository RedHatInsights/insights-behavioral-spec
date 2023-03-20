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

import subprocess
import yaml
import os

from steps import kafka_util
from behave import given, when, then
from kafka.cluster import ClusterMetadata


@given('SHA extractor service is not started')
def sha_extractor_not_started(context):
    assert not hasattr(context, 'sha_extractor')


@given('Kafka broker is started on host and port specified in configuration')
def kafka_broker_running(context):
    config = None
    with open('config/insights_sha_extractor.yaml', 'r') as file:
        config = yaml.safe_load(file)
        context.sha_config = config
    hostname = \
        config['service']['consumer']['kwargs']['bootstrap_servers']
    context.hostname = hostname
    context.kafka_hostname = hostname.split(":")[0]
    context.kafka_port = hostname.split(":")[1]

    metadata = ClusterMetadata(bootstrap_servers=hostname)
    context.metadata = metadata
    assert len(metadata.brokers()) > 0


@given('Kafka topic specified in configuration variable "{topic_var}" is created')
def check_topic_created(context, topic_var):
    context.kafka_hostname = context.hostname.split(":")[0]
    context.kafka_port = context.hostname.split(":")[1]

    visit = []
    visit.append(context.sha_config)
    while visit:
        conf_branch = visit.pop()
        for k, v in conf_branch.items():
            if isinstance(v, dict):
                visit.append(v)
            else:
                if k == topic_var:
                    kafka_util.delete_kafka_topic(context, v)
                    kafka_util.create_topic(context.hostname, v)
                    setattr(context, k, v)


@when('SHA extractor service is started')
@when('SHA extractor service is started in group "{group_id}"')
@given('SHA extractor service is started')
def start_sha_extractor(context, group_id=None):
    if group_id:
        os.environ['CDP_GROUP_ID'] = group_id

    sha_extractor = subprocess.Popen(
        ['insights-sha-extractor', 'config/insights_sha_extractor.yaml'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding='utf-8',
        env=os.environ.copy()
    )
    context.sha_extractor = sha_extractor


@when('an event is produced into "{topic_var}" topic')
def produce_event(context, topic_var):
    event_data = ''
    with open('test_data/platform_upload_announce_correct.json', 'r') as f:
        event_data = f.read()
    topic_name = context.__dict__["_stack"][0][topic_var]

    kafka_util.send_event(context.hostname, topic_name, event_data)


@then('SHA extractor decode the b64_identity attribute')
def check_b64_decode(context):
    expected_msg = "Identity schema validated"

    assert message_in_buffer(
        expected_msg,
        context.sha_extractor.stdout
    ), "message was not consumed"


@then('SHA extractor should consume message about this event')
def check_message_consumed(context):
    assert not context.sha_extractor.returncode, \
        "sha extractor is not running"

    expected_msg = "Deserializing incoming bytes"
    assert message_in_buffer(
        expected_msg,
        context.sha_extractor.stdout
    ), "message was not consumed"


@then('SHA extractor service does not exit with an error code')
def sha_extractor_is_running(context):
    assert not context.sha_extractor.poll(), \
        "sha extractor service was not started"


@then('SHA extractor service should be registered to topic "{topic}"')
def topic_registered(context, topic):
    topic_name = context.__dict__["_stack"][0][topic]
    expected_msg = f"Consuming topic '{topic_name}' " + \
        f"from brokers ['{context.hostname}'] " + \
        "as group 'insights_sha_extractor_app'"
    assert message_in_buffer(
        expected_msg,
        context.sha_extractor.stdout
    ), "consumer topic not registered"

    # kill the process so we have one consumer at a time
    context.sha_extractor.terminate()


@then('this message should contain following attributes')
def check_message(context):
    expected_msg = 'JSON schema validated'

    assert message_in_buffer(
        expected_msg,
        context.sha_extractor.stdout
    ), "can't parse message"


def message_in_buffer(message, buffer):
    found = False
    while True:
        # readline can be blocking, run this
        # test with a timeout
        line = buffer.readline()
        if message in line:
            found = True
            break
        if not line:
            break
    return found
