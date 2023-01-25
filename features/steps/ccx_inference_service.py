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

import json
import os
import socket
import subprocess
import time

import requests
import jsonschema


@given("The CCX Inference Service is running")
def start_ccx_inference_service(context):
    """Run ccx-inference-service for a test and prepare its stop."""
    params = ["uvicorn", "ccx_upgrades_inference.main:app"]
    env = os.environ.copy()

    popen = subprocess.Popen(
        params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=env
    )
    assert popen is not None
    time.sleep(0.5)
    context.add_cleanup(popen.terminate)


@when("I request the {endpoint} endpoint")
def request_endpoint(context, endpoint):
    """Perform a request to the local server to the given endpoint."""
    context.response = requests.get(f"http://localhost:8000/{endpoint}")


@when("I request the {endpoint} endpoint with {body} in the body")
def request_endpoint_with_body(context, endpoint, body):
    """Perform a request to the local server with a given body in the request."""
    context.response = requests.get(
        f"http://localhost:8000/{endpoint}",
        data=body,
    )


@when("I request the {endpoint} endpoint using the following data as {key}")
def request_endpoint_with_formatted_body(context, endpoint, key):
    """Perform a request to the local server with a given set of data.

    This method expects a table with the columns "kind" and "value".
    Each row of the table will be converted into an element on an array
    in the request body.
    """

    values = list()

    for row in context.table:
        kind = row["kind"]
        value = row["value"]
        values.append(f"{kind}|{value}")

    data = {key: values}
    context.response = requests.get(
        f"http://localhost:8000/{endpoint}",
        data=json.dumps(data),
    )


@then("The status code of the response is {status}")
def check_status_code(context, status):
    assert context.response.status_code == int(status)


@then("The body of the response has the following schema")
def check_response_body_schema(context):
    """Check that response body is compliant with a given schema."""

    schema = json.loads(context.text)
    body = context.response.json()

    try:
        jsonschema.validate(
            instance=body,
            schema=schema,
        )

    except jsonschema.ValidationError:
        assert False, "The response body doesn't fit the expected schema"

    except jsonschema.SchemaError:
        assert False, "The provided schema is faulty"


@then("The body of the response is the following")
def check_prediction_result(context):
    """Check the content of the response to be exactly the same."""

    expected_body = json.loads(context.text)
    result = context.response.json()
    assert result == expected_body
