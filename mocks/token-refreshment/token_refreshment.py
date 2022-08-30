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

from fastapi import FastAPI, Request, Form
from starlette.responses import JSONResponse
from pydantic import BaseModel

app = FastAPI()


class ReturnError(BaseModel):
    error: str
    error_description: str


@app.post("/auth/realms/redhat-external/protocol/openid-connect/token")
def get_access_token(refresh_token: str = Form()):
    if refresh_token != "TEST_TOKEN":
        return JSONResponse(
            ReturnError(
                error="invalid grant", error_description="Invalid refresh token"
            ).dict(),
            status_code=401,
        )
    return {"access_token": "ACCESS_TOKEN"}
