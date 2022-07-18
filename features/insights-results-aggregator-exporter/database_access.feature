Feature: Ability to access database

  Background: System is in default state and database exist
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres

  @database
  Scenario: Check access to empty database
     When database connection is established
     Then I should find that the database is empty

  @database
  Scenario: Check table creation on deletion
    Given database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I delete all tables from database
     Then I should find that the database is empty
