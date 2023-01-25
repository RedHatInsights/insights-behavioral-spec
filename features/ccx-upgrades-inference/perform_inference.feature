Feature: Upgrade Risks Prediction inference - test well known values

  Scenario: Empty body is used
    Given The CCX Inference Service is running
     When I request the upgrade-risks-prediction endpoint
     Then The status code of the response is 422

  Scenario: Invalid body is used
    Given The CCX Inference Service is running
     When I request the upgrade-risks-prediction endpoint with junk in the body
     Then The status code of the response is 422
    
  Scenario: Invalid kind is used
    Given The CCX Inference Service is running
     When I request the upgrade-risks-prediction endpoint using the following data as risks
          | kind | value     |
          | foc  | some.foc  |
          | junk | some.junk |
     Then The status code of the response is 422

  Scenario: Valid input risks are used
    Given The CCX Inference Service is running
     When I request the upgrade-risks-prediction endpoint using the following data as risks
          | kind  | value       |
          | foc   | some.foc1   |
          | alert | some.alert1 |
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
                "type": "array",
                "items": {
                  "type": "string"
                }
              }
            }
          }
          """