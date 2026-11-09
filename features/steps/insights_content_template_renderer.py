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

"""Implementation of test steps that run CCX Upgrade Risk Inference Service."""

import os
import socket
import subprocess
import time

from behave import given, then
from src.process_output import path_from_context


@given("The Template Renderer is running")
def start_template_renderer(context):
    """Run insights_content_template_renderer for a test and prepare its stop."""
    params = [
        "uvicorn",
        "insights_content_template_renderer.endpoints:app",
        "--log-config",
        "logging.yml",
        "--port",
        str(getattr(context, "port", 8000)),
    ]

    stdout_path = path_from_context(context, "content-template-renderer", "stdout")
    stderr_path = path_from_context(context, "content-template-renderer", "stderr")
    template_renderer_path = os.getenv("PATH_TO_LOCAL_TEMPLATE_RENDERER")

    stdout_file = stdout_path.open("w")
    stderr_file = stderr_path.open("w")

    popen = subprocess.Popen(
        params,
        stdout=stdout_file,
        stderr=stderr_file,
        cwd=template_renderer_path,
    )
    assert popen is not None
    context.add_cleanup(popen.terminate)
    context.add_cleanup(stdout_file.close)
    context.add_cleanup(stderr_file.close)

    # wait until the service starts accepting connections, as initializing
    # the JS engine worker pool may take some time
    port = getattr(context, "port", 8000)
    deadline = time.time() + 60
    while time.time() < deadline:
        assert popen.poll() is None, "The Template Renderer process exited prematurely"
        try:
            with socket.create_connection(("localhost", port), timeout=1):
                return
        except OSError:
            time.sleep(0.5)
    raise AssertionError(
        f"The Template Renderer did not start listening on port {port} in 60 seconds",
    )


def _get_item(context, index: int) -> dict:
    """Return the item with the given index from the batch render response."""
    items = context.response.json()["items"]
    assert index < len(items), (
        f"Item {index} is not present in the response containing {len(items)} item(s)"
    )
    return items[index]


@then("The response contains {number:d} items")
def check_number_of_items(context, number):
    """Check the number of items in a batch render response."""
    items = context.response.json()["items"]
    assert len(items) == number, (
        f"The response contains {len(items)} item(s), but {number} is expected"
    )


@then('The rendered field "{field}" of item {index:d} is "{value}"')
def check_rendered_field_of_item(context, field, index, value):
    """Check the rendered value of the given field of a batch render item."""
    item = _get_item(context, index)
    assert field in item["rendered"], (
        f"Field {field} is not present in the rendered fields of item {index}: {item['rendered']}"
    )
    assert item["rendered"][field] == value, (
        f"Rendered field {field} of item {index} is "
        f"'{item['rendered'][field]}', but '{value}' is expected"
    )


@then('The item {index:d} does not contain rendered field "{field}"')
def check_item_does_not_contain_rendered_field(context, index, field):
    """Check that a field is not present in the rendered fields of an item."""
    item = _get_item(context, index)
    assert field not in item["rendered"], (
        f"Field {field} should not be present in the rendered fields of item "
        f"{index}: {item['rendered']}"
    )


@then("The item {index:d} has no errors")
def check_item_has_no_errors(context, index):
    """Check that a batch render item does not contain any error."""
    item = _get_item(context, index)
    assert not item["errors"], (
        f"Item {index} should not contain any error, but contains: {item['errors']}"
    )


@then('The item {index:d} has an error for field "{field}" containing "{substring}"')
def check_item_has_error_for_field(context, index, field, substring):
    """Check the error message reported for the given field of an item."""
    item = _get_item(context, index)
    assert field in item["errors"], (
        f"Field {field} is not present in the errors of item {index}: {item['errors']}"
    )
    message = item["errors"][field]
    assert substring in message, (
        f"Error message for field {field} of item {index} is '{message}', "
        f"but it should contain '{substring}'"
    )


@then('The error message for field "{field}" of item {index:d} does not contain "{substring}"')
def check_error_message_does_not_contain(context, field, index, substring):
    """Check that the error message for a field does not leak internal details."""
    item = _get_item(context, index)
    assert field in item["errors"], (
        f"Field {field} is not present in the errors of item {index}: {item['errors']}"
    )
    message = item["errors"][field]
    assert substring not in message, (
        f"Error message for field {field} of item {index} is '{message}', "
        f"but it should not contain '{substring}'"
    )
