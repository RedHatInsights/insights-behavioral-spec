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
import subprocess
import time

from behave import given, when
from common_http import check_service_started


@given("The CCX Inference Service is running on port {port:d}")
def start_ccx_inference_service(context, port):
    """Run ccx-inference-service for a test and prepare its stop."""
    params = ["uvicorn", "ccx_upgrades_inference.main:app", "--port", str(port)]
    env = os.environ.copy()

    f = open(f"logs/ccx-upgrades-inference/{context.scenario}.log", "w")
    popen = subprocess.Popen(params, stdout=f, stderr=f, env=env)
    assert popen is not None
    check_service_started(context, "localhost", port, seconds_between_attempts=1)
    context.add_cleanup(popen.terminate)
    context.add_cleanup(f.close)


@given("The mock CCX Inference Service is running on port {port:d}")
def start_ccx_inference_mock_service(context, port):
    """Run ccx-inference-service for a test and prepare its stop."""
    params = ["uvicorn", "mocks.inference-service.inference_service:app", "--port", str(port)]
    f = open(f"logs/ccx-upgrades-data-eng/{context.scenario}-rhobs-mock.log", "w")
    popen = subprocess.Popen(params, stdout=f, stderr=f)
    assert popen is not None
    check_service_started(context, "localhost", port, attempts=10, seconds_between_attempts=1)

    context.add_cleanup(popen.terminate)
    context.add_cleanup(f.close)
    context.mock_inference = popen


@when("I stop the mock CCX Inference Service")
def stop_ccx_inference_mock_service(context):
    """Stop mocked inference service."""
    context.mock_inference.terminate()
    while context.mock_inference.poll() is None:
        # subprocess is still alive
        time.sleep(0.1)
