Feature: Checking all responses from Insights Results Aggregator Mock service


  Scenario: Check if Insights Results Aggregator Mock service return correct list of organizations
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of organizations
     Then I should retrieve following list of organizations
         | Organization |
         | 11789772     |
         | 11940171     |
