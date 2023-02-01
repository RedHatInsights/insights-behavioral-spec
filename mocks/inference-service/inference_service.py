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

"""Mock server that can be used instead of fully functional Inference Service."""

import json
from typing import List

from fastapi import FastAPI, Response
from pydantic import BaseModel


app = FastAPI()


class Risks(BaseModel):
    """Simple model used to mock the requests that data-engineering service will perform."""

    risks: List[str]


@app.get("/upgrade-risks-prediction")
def upgrade_risk_prediction_mock(risks: Risks):
    """Request handler for REST API endpoint to return upgrade prediction prediction."""

    result = len(risks.risks) == 0
    return {
        "upgrade_recommended": result,
        "upgrade_risks_predictors": risks.risks,
    }
