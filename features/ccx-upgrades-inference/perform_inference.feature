Feature: Upgrade Risks Prediction inference - test well known values

  Scenario: Check Inference Service response with no body is sent in the request
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000
     Then The status code of the response is 422

  Scenario: Check Inference Service response with an invalid body is used in the request
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with junk in the body
     Then The status code of the response is 422
    
  Scenario: Check Inference Service response with a valid body with invalid data is used in the request
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with JSON
      """
        {
          "alerts": [
            {
              "not a name": "not a name",
              "not a severity": "not a severity"
            }
          ],
          "operator_conditions": [
            {"not a name": "not a name", "no condition": "no condition"}
          ]
        }
      """
     Then The status code of the response is 422

  Scenario: Check Inference Service response with a valid body with valid data is used in the request
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with JSON
          """
            {
              "alerts": [
                {
                  "name": "APIRemovedInNextEUSReleaseInUse",
                  "namespace": "openshift-kube-apiserver",
                  "severity": "info"
                }
              ],
              "operator_conditions": [
                {
                  "name": "authentication", 
                  "condition": "Degraded", 
                  "reason": "AsExpected"
                }
              ]
            }
          """
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
            {
              "required": [
                "upgrade_risks_predictors"
              ],
              "type": "object",
              "properties": {
                "upgrade_risks_predictors": {
                  "title": "Upgrade Risks Predictors",
                  "type": "object",
                  "properties": {
                    "alerts": {
                      "title": "Alerts",
                      "type": "array"
                    },
                    "operator_conditions": {
                      "title": "Degraded Operator Condition",
                      "type": "array"
                    }
                  }
                }
              }
            }
          """
      And The body of the response is the following
          """
            {
              "upgrade_risks_predictors": {
                "alerts": [],
                "operator_conditions": [
                  {
                    "name": "authentication", 
                    "condition": "Degraded", 
                    "reason": "AsExpected"
                  }
                ]
              }
            }
          """
