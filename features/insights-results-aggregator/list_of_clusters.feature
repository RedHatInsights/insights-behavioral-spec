Feature: Checking responses from Insights Results Aggregator service: "{organization}/clusters" endpoint



  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is api/v1
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
  Scenario: Check if Insights Results Aggregator service returns correct list of clusters for known organization
    Given the system is in default state
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization w/o access rights
    Given the system is in default state
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 999 account number 456, and user 789
     Then The status code of the response is 403
      And The status message of the response is "you have no permissions to get or change info about the organization with ID 123; you can access info about organization with ID 999"
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service returns correct list of clusters for known organization and one report
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service returns correct list of clusters for known organization and several reports
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
        | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service returns correct list of clusters for known organization and several reports, some from different organization
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | 123          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
        | 999          | cccccccc-89ab-cdef-0123-456789abcdef |
        | 999          | dddddddd-89ab-cdef-0123-456789abcdef |
        | 999          | eeeeeeee-89ab-cdef-0123-456789abcdef |
        | 999          | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
        | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | bbbbbbbb-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service returns correct list of clusters for known organization without any report (all reports belong to different organization)
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 999          | 01234567-89ab-cdef-0123-456789abcdef |
        | 999          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | 999          | bbbbbbbb-89ab-cdef-0123-456789abcdef |
        | 999          | cccccccc-89ab-cdef-0123-456789abcdef |
        | 999          | dddddddd-89ab-cdef-0123-456789abcdef |
        | 999          | eeeeeeee-89ab-cdef-0123-456789abcdef |
        | 999          | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
