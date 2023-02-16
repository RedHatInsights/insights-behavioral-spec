@aggregator_cleaner
Feature: Ability to display old records


  @database
  Scenario: Read old records from empty database
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the cleaner to display all records older than 90 days
     Then I should see empty list of records
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Read old records from empty database giving different time period
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the cleaner to display all records older than 10 days
     Then I should see empty list of records
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Read old records from prepared non-empty database with new records only
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 2930-01-01  |  2923-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 2923-01-01  |  2923-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2923-01-01  |  2923-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see empty list of records
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Read old records from prepared non-empty database with old records only
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 1990-01-01  |  1990-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Read old records from prepared non-empty database with mixed records
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2900-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2900-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I delete all tables from database
     Then I should find that the database is empty