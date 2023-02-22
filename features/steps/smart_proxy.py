# Copyright © 2023 Pavel Tisnovsky, Red Hat, Inc.
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

"""Implementation of test steps that run Smart Proxy and check its output."""

import requests
import subprocess

from behave import when, then
from src.process_output import process_generated_output



@when("I run the Smart Proxy with the {flag} command line flag")
def run_insights_results_aggregator_with_flag(context, flag):
    """Start the Smart Proxy with given command-line flag."""
    out = subprocess.Popen(
        ["insights-results-smart-proxy", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    assert out is not None
    process_generated_output(context, out, 2)

