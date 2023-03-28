@aggregator
Feature: Consuming and processing results from Kafka broker


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
     When I retrieve a list of all applications running under JVM
     Then I should find the following application kafka.Kafka
    Given Insights Results Aggregator service is started in background


  @managed @local
  Scenario: Check if Insights Results Aggregator is able to consume messages and store results into database
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results' to local broker
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
