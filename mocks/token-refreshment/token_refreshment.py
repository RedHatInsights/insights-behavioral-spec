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

"""Mock service that can be used to simulate access token gathering."""

from fastapi import FastAPI, Form
from pydantic import BaseModel
from starlette.responses import JSONResponse

app = FastAPI()


class ReturnError(BaseModel):

    """Class describing error message returned by token refreshment API."""

    error: str
    error_description: str


@app.post("/auth/realms/redhat-external/protocol/openid-connect/token")
def get_access_token(grant_type: str = Form(), client_id: str = Form(), scope: str = Form()):
    """Request handler for REST API call to gather access token."""
    if grant_type != "client_credentials":
        return JSONResponse(
            ReturnError(
                error="expected client credentials",
                error_description="This mock cannot handle other types of token refreshment",
            ).dict(),
            status_code=501,
        )
    if client_id != "CLIENT_ID":
        return JSONResponse(
            ReturnError(
                error="invalid grant", error_description="Invalid refresh token",
            ).dict(),
            status_code=401,
        )
    if scope != "openid":
        return JSONResponse(
            ReturnError(
                error="expected openid scope",
                error_description="This mock does not support other scopes",
            ).dict(),
            status_code=501,
        )

    # mock JWT token with this content is returned (no secret is leaked):
    # {
    #    "Issuer": "Mock Token Refreshment",
    #    "Issued At": "2022-10-10T10:52:46.462Z",
    #    "Username": "CCX Notification Service",
    #    "Role": "Service"
    # }
    return {
        "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiU2VydmljZSIsIklzc3VlciI6Ik1vY2sgVG9r"
        "ZW4gUmVmcmVzaG1lbnQiLCJVc2VybmFtZSI6IkNDWCBOb3RpZmljYXRpb24gU2VydmljZ"
        "SIsImlhdCI6MTY2NTM5OTY0OH0.LcHHN1KSA0W4FllEZT3X5t0i0AjOU6aFWc00vjV-8g"
        "w",
    }
