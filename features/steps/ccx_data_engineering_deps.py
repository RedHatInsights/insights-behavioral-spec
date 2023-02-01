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

"""Test steps relative to Data Engineering external dependencies."""

import os
import os.path
import subprocess
import time

from behave import given


@given("CCX Inference Service mock is running in port {port:d}")
def start_inference_service_mock(context, port):
    """Execute the inference service mock in the given port."""
    params = ["uvicorn", "inference_service:app", "--port", str(port)]
    env = os.environ.copy()

    popen = subprocess.Popen(
        params,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        env=env,
        cwd=os.path.join(os.getcwd(), "mocks", "inference-service"),
    )

    assert popen is not None
    time.sleep(0.5)
    context.add_cleanup(popen.terminate)
