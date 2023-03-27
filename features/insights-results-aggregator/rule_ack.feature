Feature: Reading acked rules, acking new rule and acking existing rule


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
  Scenario: Check if Insights Results Aggregator service returns list of acked rules
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
