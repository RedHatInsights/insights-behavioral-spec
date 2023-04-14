Feature: Checking responses from Insights Results Aggregator Mock service: "organizations" endpoint


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v2


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of organizations
    Given the system is in default state
     When I request list of organizations
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 11789772     |
         | 11940171     |
