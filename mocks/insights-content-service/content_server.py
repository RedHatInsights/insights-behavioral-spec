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

import json
from fastapi import FastAPI, Response
import pygob


app = FastAPI()

"""
This is the data and format returned

{
    Config: {
        Impact: map [
            Data Loss:4
            Hung Task:3
            Application Failure:2
            Hardening:1
        ]
    }
    Rules: map[
        test_rule: {
            Plugin: {
                Name:Rule for testing purposes
                NodeID: 
                ProductCode: OCP4 
                PythonModule: ccx_rules_ocm.test_rule
            }
            ErrorKeys: map[
                TEST_RULE_CRITICAL_IMPACT: {
                    Metadata: {
                        Description:A test rule for E2E tests that depend on this service 
                        Impact:{Name:Data Loss Impact:4}
                        Likelihood:4 
                        PublishDate:2020-04-08 00:42:00 
                        Status:active 
                        Tags:[openshift service_availability]
                    } 
                    TotalRisk:0 
                    Generic:Generic description of the critical impact test rule.\n 
                    Summary:This is an example recommendation used for testing purposes. IT SHOULD NOT BE SERVED IN ANY ENVIRONMENT THAT IS NOT FOR TESTING.\n 
                    Resolution:some resolution\n 
                    MoreInfo:For more info about the Remote Health Monitoring, refer to [documentation](https://docs.openshift.com/container-platform/4.3/support/remote_health_monitoring/about-remote-health-monitoring.html)\n 
                    Reason:some reason\n 
                    HasReason:true
                }
                TEST_RULE_IMPORTANT_IMPACT: {Metadata:{Description:A test rule for E2E tests that depend on this service Impact:{Name:Hung Task Impact:3} Likelihood:3 PublishDate:2020-04-08 00:42:00 Status:active Tags:[openshift service_availability]} TotalRisk:0 Generic:Generic description of the important impact test rule.\n Summary:This is an example recommendation used for testing purposes. IT SHOULD NOT BE SERVED IN ANY ENVIRONMENT THAT IS NOT FOR TESTING.\n Resolution:some resolution\n MoreInfo:For more info about the Remote Health Monitoring, refer to [documentation](https://docs.openshift.com/container-platform/4.3/support/remote_health_monitoring/about-remote-health-monitoring.html)\n Reason:some reason\n HasReason:true}
                TEST_RULE_LOW_IMPACT:{Metadata:{Description:A test rule for E2E tests that depend on this service Impact:{Name:Hardening Impact:1} Likelihood:1 PublishDate:2020-04-08 00:42:00 Status:active Tags:[openshift service_availability]} TotalRisk:0 Generic:Generic description of the low impact test rule.\n Summary:This is an example recommendation used for testing purposes. IT SHOULD NOT BE SERVED IN ANY ENVIRONMENT THAT IS NOT FOR TESTING.\n Resolution:some resolution\n MoreInfo:For more info about the Remote Health Monitoring, refer to [documentation](https://docs.openshift.com/container-platform/4.3/support/remote_health_monitoring/about-remote-health-monitoring.html)\n Reason:some reason\n HasReason:true}
                TEST_RULE_MODERATE_IMPACT:{Metadata:{Description:A test rule for E2E tests that depend on this service Impact:{Name:Application Failure Impact:2} Likelihood:2 PublishDate:2020-04-08 00:42:00 Status:active Tags:[openshift service_availability]} TotalRisk:0 Generic:Generic description of the moderate impact test rule.\n Summary:This is an example recommendation used for testing purposes. IT SHOULD NOT BE SERVED IN ANY ENVIRONMENT THAT IS NOT FOR TESTING.\n Resolution:some resolution\n MoreInfo:For more info about the Remote Health Monitoring, refer to [documentation](https://docs.openshift.com/container-platform/4.3/support/remote_health_monitoring/about-remote-health-monitoring.html)\n Reason:some reason\n HasReason:true}
            ]
            Generic: Summary:This is an example recommendation used for testing purposes. IT SHOULD NOT BE SERVED IN ANY ENVIRONMENT THAT IS NOT FOR TESTING.\n 
            Resolution:some resolution\n 
            MoreInfo:For more info about the Remote Health Monitoring, refer to [documentation](https://docs.openshift.com/container-platform/4.3/support/remote_health_monitoring/about-remote-health-monitoring.html)\n 
            Reason:some reason\n 
            HasReason:true
        }
    ]
}
"""

@app.get("/api/v1/openapi.json")
def read_test_content():
    return {"openapi.json": "ok"}


@app.get("/api/v1/content")
def read_test_content():
    with open('test_content_gob', 'rb') as test_content_gob:
        return Response(test_content_gob.read())
