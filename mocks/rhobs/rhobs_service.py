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

import json
import re

from fastapi import FastAPI, Response
from pydantic import BaseModel

app = FastAPI()


EXAMPLE_RESULT = [
    {
        "metric": {
            "__name__": "alerts",
            "alertname": "APIRemovedInNextEUSReleaseInUse",
            "namespace": "openshift-kube-apiserver",
            "severity": "info",
        },
    },
    {
        "metric": {
            "__name__": "cluster_operator_conditions",
            "name": "authentication",
            "condition": "Failing",
            "reason": "AsExpected",
        },
    },
]


class Query(BaseModel):
    """Simple model used to mock the requests that data-engineering service will perform."""

    query: str


@app.get("/api/metrics/v1/telemeter/api/v1/query")
def get_random_results(query: Query):
    """Request handler for REST API endpoint to return alerts and FOCs."""
    match = re.match(
        r"^alerts{{_id=(.+)}}\s+or\s+cluster_operator_conditions{{_id=(.+)}}",
        query.query,
    )

    if not match:
        return {}

    cluster_id = match.group(1)
    even = bool(int(cluster_id[-1], 16) % 2)

    result = EXAMPLE_RESULT if even else list()
    return {"data": {"result": result}}
