Feature: Checks for cluster reports provided by Insights Results Aggregator


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is api/v1
      And Insights Results Aggregator service is started in background


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters/123e4567-e89b-12d3-a456-426614174000/reports using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable (w/o using auth. token) for different organization
    Given the system is in default state
     When I access endpoint /organizations/999/clusters/123e4567-e89b-12d3-a456-426614174000/reports using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable for correct cluster ID (with using auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters/123e4567-e89b-12d3-a456-426614174000/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "null"
                },
                "errors": {
                  "type": "array",
                  "items": [
                    {
                      "type": "string"
                    }
                  ]
                },
                "reports": {
                  "type": "object"
                },
                "generated_at": {
                  "type": "string"
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "errors",
                "reports",
                "generated_at",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": null, "errors": ["123e4567-e89b-12d3-a456-426614174000"], "reports": {}, "generated_at": "", "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable for correct cluster ID (with using auth. token) and different organization
    Given the system is in default state
     When I access endpoint /organizations/999/clusters/123e4567-e89b-12d3-a456-426614174000/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "null"
                },
                "errors": {
                  "type": "array",
                  "items": [
                    {
                      "type": "string"
                    }
                  ]
                },
                "reports": {
                  "type": "object"
                },
                "generated_at": {
                  "type": "string"
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "errors",
                "reports",
                "generated_at",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": null, "errors": ["123e4567-e89b-12d3-a456-426614174000"], "reports": {}, "generated_at": "", "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable for incorrect cluster ID (with using auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters/ffff/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 400
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "status"
              ]
          }
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the cluster report endpoint is reachable for two correct cluster IDs (with using auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters/123e4567-e89b-12d3-a456-426614174000,ffffffff-e89b-12d3-a456-426614174000/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "null"
                },
                "errors": {
                  "type": "array",
                  "items": [
                    {
                      "type": "string"
                    }
                  ]
                },
                "reports": {
                  "type": "object"
                },
                "generated_at": {
                  "type": "string"
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "errors",
                "reports",
                "generated_at",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": null, "errors": ["123e4567-e89b-12d3-a456-426614174000", "ffffffff-e89b-12d3-a456-426614174000"], "reports": {}, "generated_at": "", "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


