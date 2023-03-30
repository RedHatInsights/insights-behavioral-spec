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

r"""
Mock server that can be used instead of fully functional ServiceLog service.

You can try this mock with:

curl -X POST -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d '{
        "severity": "Info",
        "service_name": "Insights",
        "cluster_uuid": "d484b150-3106-4d6a-96b4-e03c327a2f66",
        "summary": "Subscription created",
        "description": "Following issues have been found…",
        "internal_only": false
        }' \
    -H "Content-Type: application/json" \
    localhost:8000/api/service_logs/v1/cluster_logs | jq

Which returns:

{
  "cluster_uuid": "d484b150-3106-4d6a-96b4-e03c327a2f66",
  "summary": "Subscription created",
  "description": "Following issues have been found…",
  "internal_only": false,
  "service_name": "Insights",
  "severity": "Info",
  "timestamp": "2022-08-08 19:40:59",
  "event_stream_id": "26a680f531c5262d5875edcfe82d2278ad0e8f47",
  "id": "1UMNOXNswZQXvmyGW0swVXquUlS",
  "kind": "ClusterLog",
  "href": "/api/service_logs/v1/cluster_logs/1UMNOXNswZQXvmyGW0swVXquUlS",
  "created_by": "ccx@redhat.com",
  "created_at": "2022-08-08 19:40:59",
  "email": "ccx@redhat.com"
}

With status code 200. If there is no authorization header, it will return:

{
  "kind": "Error",
  "id": "401",
  "href": "/api/service_logs/v1/errors/401",
  "code": "SERVICE-LOGS-401",
  "reason": "Request doesn't contain the 'Authorization' header or the 'cs_jwt' cookie"
}

With a 401 status code. If there is some missing field, you will receive this error:
{
  "id": "1",
  "kind": "Error",
  "href": "/api/service_logs/v1/errors/8",
  "reason": "missing field",
  "operation_id": "k8rdeR2Sv3oNIAnmXRrC4lIEwgA"
}

With status code 400. The reason field in the ocm API is more sophisticated,
telling you the field that you are missing.

However, I don't consider it necessary for this use case.

You can also query using:
- GET: return the logs sent to this service
- DELETE: delete the logs stored given an ID
"""

import random
import string

from datetime import datetime
from typing import Union

from fastapi import FastAPI, Request, Response, status
from fastapi.exceptions import RequestValidationError
from starlette.responses import JSONResponse
from pydantic import BaseModel


KSUID_LENGTH = 40
ID_LENGTH = 27
CCX = "ccx@redhat.com"

LETTERS = "abcdef"
NUMBERS = "0123456789"


def random_ksuid(length: int) -> str:
    """Generate random KSUID with given length."""
    return "".join(random.choice(LETTERS + NUMBERS) for _ in range(length))


def random_id(length: int) -> str:
    """Generate random ID with given length."""
    return "".join(random.choice(string.ascii_letters + NUMBERS) for _ in range(length))


app = FastAPI()


class Log(BaseModel):
    """Model for log structure received by Service Log."""

    cluster_uuid: str
    cluster_id: Union[str, None] = None
    subscription_id: Union[str, None] = None
    summary: str
    description: Union[str, None] = None
    internal_only: Union[bool, None] = None
    service_name: str
    severity: Union[str, None] = "Info"
    timestamp: Union[str, None] = None  # default will be current time
    username: Union[str, None] = None
    event_stream_id: Union[str, None] = None  # default will be a random ksuid


class ReturnLog(Log):
    """Log structure enriched by some fields added by Service Log."""

    id: str
    kind: str
    href: str
    created_by: str
    created_at: str
    email: str


class ReturnError(BaseModel):
    """Structure returned by service when error occurs."""

    id: str
    kind: str
    href: str
    reason: str
    operation_id: str


noAuthResponse = JSONResponse(
    {
        "kind": "Error",
        "id": "401",
        "href": "/api/service_logs/v1/errors/401",
        "code": "SERVICE-LOGS-401",
        "reason": "Request doesn't contain the 'Authorization' header or the 'cs_jwt' cookie",
    },
    status_code=401,
)

# use a list as storage
log_storage = []


@app.exception_handler(RequestValidationError)
async def validation_handler():
    """Check that no mandatory field is missing in the request."""
    return JSONResponse(
        ReturnError(
            id=random.randint(0, 10),
            kind="Error",
            href="/api/service_logs/v1/errors/8",
            code="OCM-CA-8",
            reason="missing field",
            operation_id=random_id(ID_LENGTH),
        ).dict(),
        status_code=400,
    )


@app.post("/api/service_logs/v1/cluster_logs")
def publish_log(log: Log, request: Request):
    """Store received log in mock storage (list)."""
    if request.headers.get("Authorization", None) is None:
        return noAuthResponse
    log = fill_default_fields(log)
    log = add_additional_fields(log)
    log_storage.append(log)
    return JSONResponse(log.dict(exclude_none=True), status_code=201)


@app.get("/api/service_logs/v1/cluster_logs")
def get_logs(request: Request):
    """Retrieve stored logs and return them in JSON format."""
    if request.headers.get("Authorization", None) is None:
        return noAuthResponse
    return JSONResponse(
        {
            "kind": "ClusterLogList",
            "page": 1,
            "size": len(log_storage),
            "total": len(log_storage),
            "items": [log.dict(exclude_none=True) for log in log_storage],
        },
        status_code=200,
    )


@app.get("/api/service_logs/v1/clusters/{cluster}/cluster_logs")
def get_logs_for_cluster(cluster: str, request: Request):
    """Return all logs for given cluster."""
    if request.headers.get("Authorization", None) is None:
        return noAuthResponse
    res = []
    for log in log_storage:
        if log.cluster_uuid == cluster:
            res.append(log)
    return JSONResponse(
        {
            "kind": "ClusterLogList",
            "page": 1,
            "size": len(res),
            "total": len(res),
            "items": [log.dict(exclude_none=True) for log in res],
        },
        status_code=200,
    )


# This one has not been properly tested against the real ocm
@app.delete("/api/service_logs/v1/cluster_logs/{id}")
def delete_logs(id: str, request: Request):
    """Delete log based on given id."""
    if request.headers.get("Authorization", None) is None:
        return noAuthResponse
    for i, log in enumerate(log_storage):
        if log.id == id:
            log_storage.pop(i)
            return Response(status_code=status.HTTP_204_NO_CONTENT)
    return ReturnError(
        id=id,
        kind="Error",
        href="/api/service_logs/v1/errors/7",
        code="OCM-CA-7",
        reason=f"The requested resource '{id}' doesn't exist",
        operation_id=random_id(ID_LENGTH),
    )


def fill_default_fields(log: Log) -> Log:
    """Add timestamp and event ID fields to the received log."""
    if log.timestamp is None:
        log.timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    if log.event_stream_id is None:
        log.event_stream_id = random_ksuid(KSUID_LENGTH)
    return log


def add_additional_fields(log: Log) -> ReturnLog:
    """Create an enriched log with additional fields."""
    rnd_id = random_id(ID_LENGTH)
    return ReturnLog(
        **log.dict(),
        id=rnd_id,
        kind="ClusterLog",
        href=f"/api/service_logs/v1/cluster_logs/{rnd_id}",
        created_by=CCX,
        created_at=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        email=CCX,
    )
