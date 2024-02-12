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
import ccx_messaging
import os
import subprocess


@given("DVO extractor service is not started")
def dvo_extractor_not_started(context):
    """Check if DVO extractor has been started."""
    assert not hasattr(context, "service") or context.service_name != "dvo_extractor"


@when("DVO extractor service is started")
@when('DVO extractor service is started in group "{group_id}"')
@given("DVO extractor service is started")
def start_dvo_extractor(context, group_id=None):
    """Start DVO Extractor service."""
    if group_id:
        os.environ["CDP_GROUP_ID"] = group_id

    dvo_extractor = subprocess.Popen(
        ["ccx-messaging", "config/dvo_extractor.yaml"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        env=os.environ.copy(),
    )
    assert dvo_extractor is not None, "Process was not created"
    context.add_cleanup(dvo_extractor.terminate)
    context.service = dvo_extractor
    context.service_name = "dvo_extractor"


@then("DVO extractor service does not exit with an error code")
def dvo_extractor_is_running(context):
    """Check if service has been started."""
    assert ccx_messaging.service_is_running(context), "DVO extractor is not started"
    assert context.service_name == "dvo_extractor", "Different service is running"


@then('DVO extractor service should be registered to topic "{topic}"')
def dvo_extractor_topic_registered(context, topic):
    assert ccx_messaging.topic_registered(context, topic), "consumer topic not registered"


@then("DVO extractor decode the b64_identity attribute")
def dvo_extractor_check_b64_decode(context):
    assert ccx_messaging.check_b64_decode(context), "b64_identity was not extracted"


@then("DVO extractor should consume message about this event")
def dvo_extractor_check_message_consumed(context):
    """Check if message has been consumed by DVO extractor."""
    assert not context.service.returncode, "dvo extractor is not running"

    expected_msg = "Deserializing incoming message"
    assert ccx_messaging.message_in_buffer(
        expected_msg, context.service.stdout,
    ), "message was not consumed"


@then('DVO results needs to be sent into topic "archive-results"')
def dvo_results_processed(context):
    """Check that DVO extractor did process the event."""
    expected_msg = "Message has been sent successfully."

    assert ccx_messaging.message_in_buffer(
        expected_msg, context.service.stdout,
    ), "dvo extractor did not produce a result"


@then('DVO extractor retrieve the "url" attribute from the message')
def dvo_check_url(context):
    """Check that dvo extractor is able to retrieve URL from incoming message."""
    expected_msg = "Extracted URL from input message"
    assert ccx_messaging.message_in_buffer(
        expected_msg, context.service.stdout,
    ), "can't parse url from message"


@then("DVO extractor should download tarball from given URL attribute")
def dvo_check_start_download(context):
    """Check that DVO extractor is able to start download."""
    expected_msg = "Downloading"
    assert ccx_messaging.message_in_buffer(
        expected_msg, context.service.stdout,
    ), "download not started"