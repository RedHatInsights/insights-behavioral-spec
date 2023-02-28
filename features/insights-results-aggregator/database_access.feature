@aggregator
Feature: Ability to access database


  Background: System is in default state and database exist
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres


  @database @database-read
  Scenario: Check access to empty database
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
