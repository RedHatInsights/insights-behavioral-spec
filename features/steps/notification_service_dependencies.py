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

"""Steps checking availability of notification service dependencies."""

from urllib import parse

import requests

from behave import given, then, when

from common_http import check_service_started

CONTENT_SERVICE_OPENAPI_ENDPOINT = "/api/v1/openapi.json"
SERVICE_LOG_CLUSTER_LOGS_ENDPOINT = "/api/service_logs/v1/cluster_logs"
PUSH_GATEWAY_METRICS_ENDPOINT = "/metrics"
TOKEN_REFRESHMENT_ENDPOINT = (
    "/auth/realms/redhat-external/protocol/openid-connect/token"
)
TEMPLATE_RENDERER_ENDPOINT = "/rendered_reports"


@when("I retrieve data from insights-content-service on {host}:{port:d}")
@given("insights-content service is available on {host}:{port:d}")
@then("I should get data from insights-content-service")
def check_content_service_availability(context, host=None, port=None):
    """Check if insights-content-service is available at given address."""
    if host is None and port is None:
        host = context.content_host
        port = context.content_port
    else:
        context.content_host = host
        context.content_port = port

    assert (
        host is not None and port is not None
    ), "host and port of content service has not been set"

    check_service_started(context, host, port, seconds_between_attempts=1)


@given("service-log service is available on {host}:{port:d}")
def check_service_log_availability(context, host, port):
    """Check if service-log is available at given address."""
    check_service_started(context, host, port)
    url = create_url(host, port, SERVICE_LOG_CLUSTER_LOGS_ENDPOINT)
    response = requests.get(url, headers={"Authorization": "TEST_TOKEN"})
    assert response.status_code == 200, "service log is not up"


@given("token refreshment server is available on {host}:{port:d}")
def check_token_refreshment_availability(context, host, port):
    """Check if token refreshment server is available at given address."""
    check_service_started(context, host, port, seconds_between_attempts=1)
    url = create_url(host, port, TOKEN_REFRESHMENT_ENDPOINT)
    body = {
        "grant_type": "client_credentials",
        "client_id": "CLIENT_ID",
        "scope": "openid",
    }
    response = requests.post(url, data=body)
    assert response.status_code == 200, "token refreshment server is not up"


@when("I retrieve metrics from the gateway on {host}:{port:d}")
@given("prometheus push gateway is available on {host}:{port:d}")
@then("I should get data from the gateway")
def check_push_gateway_availability(context, host=None, port=None):
    """Check if prometheus push gateway is available at given address."""
    if host is None and port is None:
        host = context.gateway_host
        port = context.gateway_port
    else:
        context.gateway_host = host
        context.gateway_port = port

    assert (
        host is not None and port is not None
    ), "host and port of gateway has not been set"

    check_service_started(context, host, port, seconds_between_attempts=1)


def create_url(host, port, endpoint):
    """Create URL based on given host, port and endpoint."""
    netloc = f"{host}:{port}"
    if netloc.startswith("http://") or netloc.startswith("https://"):
        return parse.urlunparse((None, netloc, endpoint, None, None, None))
    return parse.urlunparse(("http", netloc, endpoint, None, None, None))
