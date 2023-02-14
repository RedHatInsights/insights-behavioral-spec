Feature: Checking REST API endpoint that returns results for provided list of clusters


  Scenario: Check if Insights Results Aggregator Mock service returns results for list of known clusters
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request results for the following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And Attribute errors should be null
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
