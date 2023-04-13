Feature: Checking responses from Insights Results Aggregator Mock service: "{organization}/clusters" endpoint



  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v2


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 1
    Given the system is in default state
     When I request list of clusters for organization 1
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000001-624a-49a5-bab8-4fdc5e51a266 |
         | 00000001-624a-49a5-bab8-4fdc5e51a267 |
         | 00000001-624a-49a5-bab8-4fdc5e51a268 |
         | 00000001-624a-49a5-bab8-4fdc5e51a269 |
         | 00000001-624a-49a5-bab8-4fdc5e51a26a |
         | 00000001-624a-49a5-bab8-4fdc5e51a26b |
         | 00000001-624a-49a5-bab8-4fdc5e51a26c |
         | 00000001-624a-49a5-bab8-4fdc5e51a26d |
         | 00000001-624a-49a5-bab8-4fdc5e51a26e |
         | 00000001-624a-49a5-bab8-4fdc5e51a26f |
         | 00000001-6577-4e80-85e7-697cb646ff37 |
         | 00000001-8933-4a3a-8634-3328fe806e08 |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-eeee-eeee-eeee-000000000001 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 2
    Given the system is in default state
     When I request list of clusters for organization 2
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000002-624a-49a5-bab8-4fdc5e51a266 |
         | 00000002-6577-4e80-85e7-697cb646ff37 |
         | 00000002-8933-4a3a-8634-3328fe806e08 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 3
    Given the system is in default state
     When I request list of clusters for organization 3
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000003-8933-4a3a-8634-3328fe806e08 |
         | 00000003-8d6a-43cc-b82c-7007664bdf69 |
         | 00000003-eeee-eeee-eeee-000000000001 |


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization with many clusters
    Given the system is in default state
     When I request list of clusters for organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a267 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a268 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a269 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26a |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26b |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26c |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26d |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26e |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26f |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
         | eeeeeeee-eeee-eeee-eeee-000000000001 |



  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization w/o access rights
    Given the system is in default state
     When I request list of clusters for organization 11940171
     Then The status code of the response is 403
      And The status message of the response is "You have no permissions to get or change info about this organization"
