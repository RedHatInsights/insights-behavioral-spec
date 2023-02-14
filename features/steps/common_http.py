# Copyright © 2023, José Luis Segura Lucas, Pavel Tisnovsky, Red Hat, Inc.
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

"""Common steps for HTTP related operations."""

import json

import jsonschema
import requests
from behave import given, then, when


@when("I request the {endpoint} endpoint in {hostname:w}:{port:d} with {body} in the body")
def request_endpoint_with_body(context, endpoint, hostname, port, body):
    """Perform a request to the local server with a given body in the request."""
    context.response = requests.get(
        f"http://{hostname}:{port}/{endpoint}",
        data=body,
    )


@when(
    "I request the {endpoint} endpoint in {hostname:w}:{port:d} using the following data as {key}"
)
def request_endpoint_with_formatted_body(context, endpoint, hostname, port, key):
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
        f"http://{hostname}:{port}/{endpoint}",
        data=json.dumps(data),
    )


@when("I request the {endpoint} endpoint in {hostname:w}:{port:d} with following parameters")
def request_endpoint_with_url_params(context, endpoint, hostname, port):
    """Perform a request to the server defined by URL to a given endpoint."""

    params = dict()

    for row in context.table:
        name = row["param"]
        value = row["value"]
        params[name] = value

    context.response = requests.get(
        f"http://{hostname}:{port}/{endpoint}",
        params=params,
    )


@when("I request the {endpoint} endpoint in {hostname:w}:{port:d}")
def request_endpoint(context, endpoint, hostname, port):
    """Perform a request to the local server to the given endpoint."""
    context.response = requests.get(f"http://{hostname}:{port}/{endpoint}")


@then("The status code of the response is {status:d}")
def check_status_code(context, status):
    assert context.response.status_code == status


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

    # compare both JSONs and print actual result in case of any difference
    assert result == expected_body, f"Result:\n{result}"


@given("REST API service hostname is {hostname:w}")
@when("REST API service hostname is {hostname:w}")
def set_service_hostname(context, hostname):
    context.hostname = hostname


@given("REST API service port is {port:d}")
@when("REST API service port is {port:d}")
def set_service_port(context, port):
    context.port = port


@given("REST API service prefix is {prefix}")
@when("REST API service prefix is {prefix}")
def set_rest_api_prefix(context, prefix):
    context.api_prefix = prefix


@when("I access endpoint {endpoint} using HTTP GET method")
def access_rest_api_endpoint_get(context, endpoint):
    url = f"http://{context.hostname}:{context.port}/{context.api_prefix}/{endpoint}"
    context.response = requests.get(url)


@then("The status message of the response is \"{expected_message}\"")
def check_status_of_response(context, expected_message):
    assert context.response is not None, "Send request to service first"

    # try to parse response body as JSON
    body = context.response.json()
    assert body is not None, "Improper format of response body"

    assert "status" in body, "Response does not contain status message"
    actual_message = body["status"]

    assert actual_message == expected_message, f"Improper status message {actual_message}"


@then("I should see attribute named {attribute} in response")
def check_attribute_presence(context, attribute):
    """Check if given attribute is returned in HTTP response."""
    json = context.response.json()
    assert json is not None

    assert attribute in json, f"Attribute {attribute} is not returned by the service"


@then("Attribute {attribute:w} should be null")
def check_for_null_attribute(context, attribute):
    """Check if given attribute returned in HTTP response is null."""
    json = context.response.json()
    assert json is not None

    assert attribute in json, f"Attribute {attribute} is not returned by the service"
    assert json[attribute] is None, f"Attribute {attribute} should be null"
