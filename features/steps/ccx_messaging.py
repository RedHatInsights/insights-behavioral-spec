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

from behave import given, when, then
import os
import subprocess


def service_is_running(context):
    """Check if service has been started."""
    return not context.service.poll()


def topic_registered(context, topic):
    """Check if service registered itself to consume given topic."""
    topic_name = context.__dict__["_stack"][0][topic]
    expected_msg = (
        f"Consuming topic '{topic_name}' " + f"from brokers {context.hostname}"
    )
    
    return message_in_buffer(expected_msg, context.service.stdout)


@then("this message should contain following attributes")
def check_message(context):
    """Check if consumed message is represented in JSON."""
    expected_msg = "JSON schema validated"

    assert message_in_buffer(
        expected_msg, context.service.stdout,
    ), "can't parse message"


def check_b64_decode(context):
    """Check if service was able to decode b64_identity attribute from a message."""
    expected_msg = "'identity': {'identity':"

    return message_in_buffer(expected_msg, context.service.stdout)


def message_in_buffer(message, buffer):
    """Check if service prints given message on its output."""
    found = False
    while True:
        # readline can be blocking, run this
        # test with a timeout
        line = buffer.readline()
        if message in line:
            found = True
            break

    return found
