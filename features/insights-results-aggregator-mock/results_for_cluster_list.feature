Feature: Checking REST API endpoint that returns results for provided list of clusters


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v2


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for list of four known clusters
    Given the system is in default state
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


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for list of three known clusters
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And Attribute errors should be null
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for list of three known clusters
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And Attribute errors should be null
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for list of one known cluster
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And Attribute errors should be null
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for empty list of clusters
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
     Then The status code of the response is 200
     Then Attribute clusters should be null
      And Attribute errors should be null
      And I should see empty list of reports


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for one unknown cluster
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
         | 00000000-0000-0000-0000-000000000000 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And I should see report for following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And I should see following list of unknown clusters
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for two unknown clusters
    Given the system is in default state
     When I request results for the following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
         | 00000000-0000-0000-0000-000000000000 |
         | 00000000-0000-0000-0000-000000000001 |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And I should see report for following list of clusters
         | Cluster name                         |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
      And I should see following list of unknown clusters
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 00000000-0000-0000-0000-000000000001 |
