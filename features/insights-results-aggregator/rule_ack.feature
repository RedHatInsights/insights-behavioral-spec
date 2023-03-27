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
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to disable one specific rule
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to disable two specific rules
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I disable rule foo2 with error key bar2 for organization 123 account number 456, and user 789 with justification 'anything2'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get 2 disabled rules
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
          | 123    | foo2    | bar2      | anything2     |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to enable already disabled one specific rule
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
     When I enable rule foo with error key bar for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "rule enabled"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to enable one already disabled specific rule from two rules
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I disable rule foo2 with error key bar2 for organization 123 account number 456, and user 789 with justification 'anything2'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get 2 disabled rules
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
          | 123    | foo2    | bar2      | anything2     |
     When I enable rule foo with error key bar for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "rule enabled"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo2    | bar2      | anything2     |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to update one specific rule
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
     When I update rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'different justification'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification           |
          | 123    | foo     | bar       | different justification |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to update non disabled specific rule
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I update rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'different justification'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules


  @rest-api
  Scenario: Check if Insights Results Aggregator service is able to update one specific rule two times
    Given the system is in default state
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get empty list of disabled rules
     When I disable rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'anything'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification |
          | 123    | foo     | bar       | anything      |
     When I update rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'different justification'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I update rule foo with error key bar for organization 123 account number 456, and user 789 with justification 'yet another justification'
     Then The status code of the response is 200
      And The status message of the response is "ok"
     When I ask for list of all disabled rules for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should get one disabled rule
      And List of returned rules should contain following rules
          | Org ID | Rule ID | Error key | Justification             |
          | 123    | foo     | bar       | yet another justification |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
