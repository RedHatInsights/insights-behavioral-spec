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
     When I request the upgrade-risks-prediction endpoint in localhost:8000 using the following data as risks
          | kind | value     |
          | foc  | some.foc  |
          | junk | some.junk |
     Then The status code of the response is 422

  Scenario: Check Inference Service response with a valid body with valid data is used in the request
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint in localhost:8000 using the following data as risks
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

# Skip next scenario until inference uses a real model
@skip
Scenario: Check Inference Service response with a valid body with valid data is used in the request that returns a success prediction
    Given The CCX Inference Service is running on port 8000
     When I request the upgrade-risks-prediction endpoint using the following data as risks
          | kind  | value       |
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
      And The body of the response is the following
          """
          {
            "upgrade_recommended": true,
            "upgrade_risks_predictors": []
          }
          """
