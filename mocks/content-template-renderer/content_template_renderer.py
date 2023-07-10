# Copyright 2022 Red Hat, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
Mock of the content-template-renderer service.

The original service is used to interpolate rule templates from content-service
with report details.

The input is in this form (some additional data are optional, but not used by this service):

{
    "content": ... output from content-service ...,
    "report_data": {
        "clusters": ["d484b150-3106-4d6a-96b4-e03c327a2f66"],
        "reports: {
            "d484b150-3106-4d6a-96b4-e03c327a2f66": [
                {
                    "rule_id": "tutorial_rule|TUTORIAL_ERROR_KEY",
                    "component": "ccx_rules_ocp.external.rules.tutorial_rule.report",
                    "type": "rule",
                    "details" {
                        "some_detail": "detail data"
                    }
                }
            ]
        }
    }
}

Output is in this form:

{
    "clusters": ["d484b150-3106-4d6a-96b4-e03c327a2f66"],
    "reports": {
        "d484b150-3106-4d6a-96b4-e03c327a2f66": [
            {
                "rule_id": "ccx_rules_ocp.external.rules.tutorial_rule",
                "error_key": "TUTORIAL_ERROR_KEY",
                "description": "detailed description",
                "reason": "detailed reason",
                "resolution": "detailed resolution"
            }
        ]
    }
}
"""
from fastapi import FastAPI, Request

app = FastAPI()


@app.post("/rendered_reports")
async def render_reports(request: Request):
    """Request handler for REST API endpoint to render reports."""
    data = await request.json()

    reports = []

    for cluster_id, cluster_data in data["report_data"]["reports"].items():
        for report in cluster_data["reports"]:
            if report["component"].endswith('.report'):
                report["component"] = report["component"][:-7]
            reports.append(
                {
                    "rule_id": report["component"],
                    "error_key": report["key"],
                    "description": "detailed description",
                    "reason": "detailed report",
                    "resolution": "detailed resolution",
                }
            )

    return {
        "clusters": data["report_data"]["clusters"],
        "reports": {data["report_data"]["clusters"][0]: reports},
    }
