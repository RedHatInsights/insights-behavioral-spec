@aggregator
Feature: Checking responses from Insights Results Aggregator service: "organizations" endpoint


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


  @rest-api @json-check
  Scenario: Check if empty list of organizations is returned in case 'report' table is empty
    Given the system is in default state
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of organizations
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if list with one organization is returned in case 'report' table contains one report only
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 123          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if list with one organization is returned in case 'report' table contains reports for one organization only
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 123          | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 123          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if list with two organizations is returned in case 'report' table contains reports for two organizations
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 456          | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 123          |
         | 456          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if list with two organizations is returned in case 'report' table contains multiple reports for two organizations
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 456          | ffffffff-89ab-cdef-0123-456789abcdef |
        | 123          | aaaaaaaa-89ab-cdef-0123-456789abcdef |
        | 456          | cccccccc-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 123          |
         | 456          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
