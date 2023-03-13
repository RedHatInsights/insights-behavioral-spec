Feature: Upgrade Risks Prediction Data Engineering - test well known values

  Background: Data eng service is running and well configured to work
    Given The CCX Data Engineering Service is running on port 8000 with envs
          | variable                    | value                         |
          | CLIENT_ID                   | test-client-id                |
          | CLIENT_SECRET               | test-client-secret            |
          | INFERENCE_URL               | http://localhost:8001         |
          | SSO_ISSUER                  | http://localhost:8081/default |
          | ALLOW_INSECURE              | 1                             |
          | RHOBS_URL                   | http://localhost:8002         |
          | OAUTHLIB_INSECURE_TRANSPORT | 1                             |

  Scenario: Check Data Engineering Service response with an invalid cluster ID in the request
     When I request the cluster endpoint in localhost:8000 with path not-an-uuid/upgrade-risks-prediction
     Then The status code of the response is 422

  Scenario: Check Data Engineering Service response with a valid cluster ID
     When I request the cluster endpoint in localhost:8000 with path f93c5b78-0d38-40c0-9d12-37918752f80d/upgrade-risks-prediction
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "required": [
              "upgrade_recommended",
              "upgrade_risks_predictors"
            ],
            "type": "object",
            "properties": {
              "upgrade_recommended": {
                "title": "Upgrade Recommended",
                "type": "boolean"
              },
              "upgrade_risks_predictors": {
                "title": "Upgrade Risks Predictors",
                "type": "object",
                "properties": {
                  "alerts": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "namespace": {
                          "type": "string"
                        },
                        "severity": {
                          "type": "string"
                        }
                      }
                    }
                  },
                  "operator_conditions": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "condition": {
                          "type": "string"
                        },
                        "reason": {
                          "type": "string"
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          """
      And The body of the response is the following
          """
            {
              "upgrade_recommended": false,
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