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


@given("The CCX Data Engineering Service is running on port {port:d} with envs")
def start_ccx_upgrades_data_eng(context, port):
    """Run ccx-upgrades-data-eng for a test and prepare its stop."""
    params = [
        "uvicorn",
        "ccx_upgrades_data_eng.main:app",
        "--port",
        str(port),
        "--log-config",
        "config/ccx-upgrades-data-eng_logging.yaml",
    ]
    env = os.environ.copy()

    # Update the environment with variables configured by the test
    for row in context.table:
        var, val = row["variable"], row["value"]
        env[var] = val

    f = open(f"logs/ccx-upgrades-data-eng/{context.scenario}.log", "w")

    popen = subprocess.Popen(params, stdout=f, stderr=f, env=env)
    assert popen is not None
    check_service_started(context, "localhost", port, attempts=10)
    context.add_cleanup(popen.terminate)


@given("The mock RHOBS Service is running on port {port:d}")
def start_RHOBS_mock_service(context, port):
    """Run RHOBS service mock for a test and prepare its stop."""
    params = ["uvicorn", "mocks.rhobs.rhobs_service:app", "--port", str(port)]

    f = open(f"logs/ccx-upgrades-data-eng/{context.scenario}-rhobs-mock.log", "w")
    popen = subprocess.Popen(params, stdout=f, stderr=f)
    assert popen is not None
    # time.sleep(0.5)
    check_service_started(context, "localhost", port, attempts=10, seconds_between_attempts=1)
    context.add_cleanup(popen.terminate)
    context.mock_rhobs = popen


@when("I stop the mock RHOBS Service")
def stop_RHOBS_mock_service(context):
    """Stop mocked RHOBS service."""
    context.mock_rhobs.terminate()
    while context.mock_rhobs.poll() is None:
        # subprocess is still alive
        time.sleep(0.1)
