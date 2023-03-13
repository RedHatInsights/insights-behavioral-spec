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

from behave import given, when, then
from kafka.admin import KafkaAdminClient, NewTopic
from kafka.cluster import ClusterMetadata
from kafka.errors import TopicAlreadyExistsError


@given('SHA extractor service is not started')
def sha_extractor_not_started(context):
    assert not hasattr(context, 'sha_extractor_process')


@given('Kafka broker is started on host and port specified in configuration')
def kafka_broker_running(context):
    config = None
    with open('config/insights_sha_extractor.yaml', 'r') as file:
        config = yaml.safe_load(file)
        context.sha_config = config
    hostname = \
        config['service']['consumer']['kwargs']['bootstrap_servers']
    context.hostname = hostname

    metadata = ClusterMetadata(bootstrap_servers=hostname)
    context.metadata = metadata
    assert len(metadata.brokers()) > 0


@given('Kafka topic specified in configuration variable "{topic_var}" is created')
def check_topic_created(context, topic_var):
    visit = []
    visit.append(context.sha_config)
    while visit:
        conf_branch = visit.pop()
        for k, v in conf_branch.items():
            if isinstance(v, dict):
                visit.append(v)
            else:
                if k == topic_var:
                    _create_topic(context.hostname, v)
                    setattr(context, k, v)


@when('SHA extractor service is started')
def start_sha_extractor(context):
    sha_extractor = subprocess.Popen(
        ['insights-sha-extractor', 'config/insights_sha_extractor.yaml'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding='utf-8',
    )
    context.sha_extractor = sha_extractor


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

    found = False
    while True:
        # readline can be blocking, run this
        # test with a timeout
        message = context.sha_extractor.stdout.readline()
        if expected_msg in message:
            found = True
            break

    assert found, "consumer topic not registered"


def _create_topic(hostname, topic_name):
    topic = NewTopic(topic_name, 1, 1)
    admin_client = KafkaAdminClient(bootstrap_servers=hostname)
    try:
        outcome = admin_client.create_topics([topic])
        assert outcome.topic_errors[0][1] == 0, "Topic creation failure: {outcome}"
    except TopicAlreadyExistsError:
        pass
