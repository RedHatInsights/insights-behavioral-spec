# Copyright 2023 Red Hat, Inc
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

"""Mock server that can be used instead of fully functional Observatorium."""

import re

from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel

app = FastAPI()

FILTERED_RESULT = [
    {
        "metric": {
            "__name__": "console_url",
            "url": "https://some_url.com/",
        },
    },
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "cluster_operator_conditions",
            "name": "authentication",
            "condition": "Degraded",
            "reason": "AsExpected",
        },
    },
]

NO_URL_RESULT = [
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "cluster_operator_conditions",
            "name": "authentication",
            "condition": "Degraded",
            "reason": "AsExpected",
        },
    },
]

DUPLICATED_METRICS_RESULT = [
    {
        "metric": {
            "__name__": "console_url",
            "url": "https://some_url.com/",
        },
    },
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "cluster_operator_conditions",
            "name": "authentication",
            "condition": "Degraded",
            "reason": "AsExpected",
        },
    },
]

# Used to check the condition is changed to 'Not Available'
AVAILABLE_FOC = [
    {
        "metric": {
            "__name__": "console_url",
            "url": "https://some_url.com/",
        },
    },
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "SomeCriticalAlert",
            "namespace": "openshift-kube-apiserver",
            "severity": "critical",
        },
    },
    {
        "metric": {
            "__name__": "cluster_operator_conditions",
            "name": "authentication",
            "condition": "Available",
            "reason": "AsExpected",
        },
    },
]

ANSWERS = {
    "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee": FILTERED_RESULT,
    "00000000-1111-2222-3333-444444444444": NO_URL_RESULT,
    "44444444-3333-2222-1111-111111111111": DUPLICATED_METRICS_RESULT,
    "aaaaaaaa-bbbb-cccc-dddd-000000000000": AVAILABLE_FOC,
}


class Query(BaseModel):

    """Simple model used to mock the requests that data-engineering service will perform."""

    query: str


UUID_REGEX = "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"


@app.get("/api/metrics/v1/telemeter/api/v1/query")
def get_random_results(query: str):
    """Request handler for REST API endpoint to return alerts and FOCs."""
    match = re.search(UUID_REGEX, query)
    if not match:
        return JSONResponse("couldn't find the cluster_id in ANSWERS", 500)
    cluster_id = match.group()
    if cluster_id not in ANSWERS:
        return {"data": {"result": []}}
    res = {"data": {"result": ANSWERS[cluster_id]}}
    for item in res["data"]["result"]:
        item["metric"]["_id"] = cluster_id
    return res
