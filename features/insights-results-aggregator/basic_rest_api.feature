Feature: Basic REST API endpoints provided by Insights Results Aggregator Mock


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1
      And Insights Results Aggregator service is started in background


  @rest-api @json-check
  Scenario: Check if the main endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint / using HTTP GET method
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
