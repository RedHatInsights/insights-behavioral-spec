Feature: Basic REST API endpoints provided by Insights Results Aggregator Mock


  Scenario: Check if the main endpoint is reachable
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I access endpoint / using HTTP GET method
     Then The status code of the response is 200
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
          {"status":"ok"}
          """
