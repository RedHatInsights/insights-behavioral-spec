Feature: Ability to access database

  Scenario: Check access to empty database
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
     When database connection is established
      And I delete all tables from database
     Then I should find that the database is empty

  Scenario: Check table creatinon on deletion
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I delete all tables from database
     Then I should find that the database is empty
