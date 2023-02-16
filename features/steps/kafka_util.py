# Copyright © 2021 Pavel Tisnovsky, Red Hat, Inc.
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

"""An interface to Apache Kafka done using kcat utility."""


import subprocess
import json


from behave import given, then, when


@when("I retrieve metadata from Kafka broker running on {hostname}:{port}")
@given("Kafka broker is available on {hostname}:{port}")
def retrieve_broker_metadata(context, hostname, port):
    """Use the kcat tool to retrieve metadata from Kafka broker."""
    # -J enables kcat to produce output in JSON format
    # -L flag choose mode: metadata list
    address = "{}:{}".format(hostname, port)
    out = subprocess.Popen(
        ["kcat", "-b", address, "-L", "-J"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # check if call was correct
    assert out is not None

    # interact with the process:
    # read data from stdout and stderr, until end-of-file is reached
    stdout, stderr = out.communicate()

    # try to decode output
    output = stdout.decode("utf-8")

    # JSON format is expected
    encoded = json.loads(output)

    # check encoding step
    assert encoded is not None

    assert len(encoded["brokers"]) >= 1, "At least one available broker expected"

    # store encoded JSON data returned by kcat utility
    context.broker_metadata = encoded


@then("I should find at least one available broker")
def find_available_brokers(context):
    """Find available brokers returned from Kafka metadata."""
    assert "brokers" in context.broker_metadata, "'brokers' attribute expected"

    # just number of brokers needs to be checked, nothing else
    assert (
        len(context.broker_metadata["brokers"]) >= 1
    ), "At least one available broker expected"


@given('Kafka topic "{topic}" is empty')
def make_kafka_empty(context, topic):
    """Delete all events from Kafka."""
    # TODO: Make it compatible with local kafka, not just for docker
    out = subprocess.Popen(
        [
            "docker",
            "exec",
            "-it",
            "insights-behavioral-spec_kafka_1",
            "./bin/kafka-topics.sh",
            "--bootstrap-server",
            "localhost:9092",
            "--delete",
            "--topic",
            topic,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    # check if call was correct
    assert out is not None

    # interact with the process:
    # read data from stdout and stderr, until end-of-file is reached
    stdout, stderr = out.communicate()

    # try to decode output
    output = stdout.decode("utf-8")

    if "does not exist" in output:
        return

    assert out.returncode == 0, f"got {out.returncode} want 0"
