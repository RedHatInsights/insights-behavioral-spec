Feature: Checking REST API endpoint that returns results for provided list of clusters


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And aggregator database is in initial state
     When database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number from database
     Then I should see that migration #31 is returned
    Given Insights Results Aggregator service is started in background


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for empty list of clusters
    Given the system is in default state
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
          | Cluster name                         |
     Then The status code of the response is 200
     Then Attribute clusters should be null
      And Attribute errors should be null
      And I should see empty list of reports
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for non empty list of clusters without proper report
    Given the system is in default state
      And empty reports are stored for following clusters
         | organization | cluster ID                           |
         | 123          | 01234567-89ab-cdef-0123-456789abcdef |
         | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     Then The status code of the response is 200
      And I should retrieve following list of clusters stored in attribute errors
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see attribute named reports in response
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for non empty list of clusters with proper report
    Given the system is in default state
      And non empty reports are stored for following clusters
         | organization | cluster ID                           |
         | 123          | 01234567-89ab-cdef-0123-456789abcdef |
         | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     Then The status code of the response is 200
      And Attribute errors should be null
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for non empty list of clusters with proper report and one unknown cluster
    Given the system is in default state
      And non empty reports are stored for following clusters
         | organization | cluster ID                           |
         | 123          | 01234567-89ab-cdef-0123-456789abcdef |
         | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see following list of unknown clusters
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for non empty list of clusters with proper report and two unknown clusters
    Given the system is in default state
      And non empty reports are stored for following clusters
         | organization | cluster ID                           |
         | 123          | 01234567-89ab-cdef-0123-456789abcdef |
         | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 11111111-1111-1111-1111-111111111111 |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     Then The status code of the response is 200
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see attribute named reports in response
      And I should see report for following list of clusters
         | Cluster name                         |
         | 01234567-89ab-cdef-0123-456789abcdef |
         | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | bbbbbbbb-89ab-cdef-0123-456789abcdef |
      And I should see following list of unknown clusters
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 11111111-1111-1111-1111-111111111111 |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns results for two unknown clusters
    Given the system is in default state
      And non empty reports are stored for following clusters
         | organization | cluster ID                           |
         | 123          | 01234567-89ab-cdef-0123-456789abcdef |
         | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
         | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I request results for the following list of clusters using token for organization 123 account number 456, and user 789
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 11111111-1111-1111-1111-111111111111 |
     Then The status code of the response is 200
      And I should see attribute named reports in response
      And I should see following list of unknown clusters
         | Cluster name                         |
         | 00000000-0000-0000-0000-000000000000 |
         | 11111111-1111-1111-1111-111111111111 |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
