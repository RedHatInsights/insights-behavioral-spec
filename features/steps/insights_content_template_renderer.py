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

from behave import given


@given("The Template Renderer is running")
def start_template_renderer(context):
    """Run insights_content_template_renderer for a test and prepare its stop."""
    params = [
        "uvicorn",
        "insights_content_template_renderer.endpoints:app",
        "--log-config",
        "logging.yml",
    ]

    curpath = os.path.abspath(os.curdir)
    scenario = str(context.scenario).replace("/", "")
    log_filename = f"{scenario.translate({ord(i): None for i in '<>/'})}.log"

    f = open(
        os.path.join(
            curpath, "logs", "insights-content-template-renderer", log_filename
        ),
        "w",
    )

    template_renderer_path = os.getenv("PATH_TO_LOCAL_TEMPLATE_RENDERER")

    popen = subprocess.Popen(params, stdout=f, stderr=f, cwd=template_renderer_path)
    assert popen is not None
    time.sleep(1)
    context.add_cleanup(popen.terminate)
