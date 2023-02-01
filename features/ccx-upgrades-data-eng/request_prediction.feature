Feature: Upgrade Risks Prediction Data Engineering - test well known values

  Scenario: Check Data Engineering Service response with no cluster id in the request
    Given The CCX Data Engineering Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000
     Then The status code of the response is 422

  Scenario: Check Data Engineering Service response with an invalid parameter in the request
    Given The CCX Data Engineering Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with following parameters
          | param  | value                                |
          | XXXXX  | f93c5b78-0d38-40c0-9d12-37918752f80d |
     Then The status code of the response is 422

  Scenario: Check Data Engineering Service response with a valid parameter, but with an invalid value
    Given The CCX Data Engineering Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with following parameters
          | param       | value                    |
          | cluster_id  | this-is-not-a-cluster-id |
     Then The status code of the response is 422

  Scenario: Check Data Engineering Service response with a valid parameter with a valid value
    Given The CCX Data Engineering Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with following parameters
          | param       | value                                |
          | cluster_id  | f93c5b78-0d38-40c0-9d12-37918752f80d |
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

  # Skip: the data engineering service is still returning a fixed response
  # The Inference service mock will return the appropriate response to generate
  # the same result expected above, but currently it's not happening
  @skip
  Scenario: Check Data Engineering Service response with a valid parameter with a valid value
    Given The CCX Data Engineering Service is running on port 8000
      And CCX Inference Service mock is running on port 8001
     When I request the upgrade-risks-prediction endpoint in localhost:8000 with following parameters
          | param       | value                                |
          | cluster_id  | f93c5b78-0d38-40c0-9d12-37918752f80d |
     Then The status code of the response is 200
      And The body of the response is the following
          """
          {
            "upgrade_recommended": false,
            "upgrade_risks_predictors": {
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
                  "condition": "Failing",
                  "reason": "AsExpected2"
                }
              ]
            }
          }
          """