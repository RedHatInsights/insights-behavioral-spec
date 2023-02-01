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


@given("The CCX Data Engineering Service is running in port {port:d}")
def start_ccx_inference_service(context, port):
    """Run ccx-inference-service for a test and prepare its stop."""
    params = ["uvicorn", "ccx_upgrades_data_eng.main:app", "--port", str(port)]
    env = os.environ.copy()

    popen = subprocess.Popen(
        params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=env
    )
    assert popen is not None
    time.sleep(0.5)
    context.add_cleanup(popen.terminate)
