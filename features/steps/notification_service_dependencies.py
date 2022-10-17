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


import requests

from behave import given, then, when


@when("I retrieve data from insights-content-service on {host:w}:{port:d}")
@given("insights-content service is available on {host:w}:{port:d}")
def check_content_service_availability(context, host, port):
    """Check if insights-content-service is available at given address."""

    url = create_url(host, port, "/api/v1/openapi.json")
    x = requests.get(url)
    assert x.status_code == 200
    context.content_service_available = True


@given("service-log service is available on {host:w}:{port:d}")
def check_service_log_availability(context, host, port):
    """Check if service-log is available at given address."""

    url = create_url(host, port, "/api/service_logs/v1/cluster_logs")
    x = requests.get(url, headers={"Authorization": "TEST_TOKEN"})
    assert x.status_code == 200, "service log is not up"


@given("token refreshment server is available on {host:w}:{port:d}")
def check_token_refreshment_availability(context, host, port):
    """Check if token refreshment server is available at given address"""

    url = create_url(host, port, "/auth/realms/redhat-external/protocol/openid-connect/token")
    body = {"grant_type": "client_credentials", "client_id": "CLIENT_ID", "scope": "openid"}
    x = requests.post(url, data=body)
    assert x.status_code == 200, "token refreshment server is not up"


@then("I should get data from insights-content-service")
def content_service_is_available(context):
    if not hasattr(context, "content_service_available"):
        raise Exception("Content service is not available")
    assert context.content_service_available


@when("I retrieve metrics from the gateway on {host:w}:{port:d}")
@given("prometheus push gateway is available on {host:w}:{port:d}")
def check_push_gateway_availability(context, host, port):
    """Check if prometheus push gateway is available at given address."""

    url = create_url(host, port, "/metrics")
    x = requests.get(url)
    assert x.status_code == 200
    context.push_gateway_available = True


@then("I should get data from the gateway")
def prom_push_gateway_is_available(context):
    if not hasattr(context, "push_gateway_available"):
        raise Exception("Push gateway is not available")
    assert context.push_gateway_available


def create_url(host, port, endpoint):
    if not str(host).startswith("http:") and not str(host).startswith("https:"):
        host = "http://" + host
    return f"{host}:{port}{endpoint}"
