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

    if not str(host).startswith("http"):
        host = "http://" + host
    x = requests.get(f'{host}:{port}/api/v1/openapi.json')
    assert x.status_code == 200
    context.content_service_available = True


@then("I should get data from insights-content-service")
def content_service_is_available(context):
    if not hasattr(context, "content_service_available"):
        raise Exception("Content service is not available")
    assert context.content_service_available


@when("I retrieve metrics from the gateway on {host:w}:{port:d}")
@given("prometheus push gateway is available on {host:w}:{port:d}")
def check_push_gateway_availability(context, host, port):
    """Check if prometheus push gateway is available at given address."""

    if not str(host).startswith("http"):
        host = "http://" + host
    x = requests.get(f'{host}:{port}/metrics')
    assert x.status_code == 200
    context.push_gateway_available = True


@then("I should get data from the gateway")
def prom_push_gateway_is_available(context):
    if not hasattr(context, "push_gateway_available"):
        raise Exception("Push gateway is not available")
    assert context.push_gateway_available
