@aggregator_cleaner
Feature: Ability to delete selected records from database


  @database
  Scenario: Clean up one old cluster should be visible
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
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Clean up of existing old clusters
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
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-548dfc9767ab
      And I run the cleaner to display all records older than 90 days
     Then I should see empty list of records
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Clean up of existing new clusters
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
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-548dfc9767ac
      And I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-548dfc9767ad
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Clean up non-existing clusters
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
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-000000000000
      And I run the cleaner with command to delete cluster 5d5892d4-1f74-4ccf-91af-ffffffffffff
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I delete all tables from database
     Then I should find that the database is empty


  @database
  Scenario: Clean up clusters with wrong names
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
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I run the cleaner with command to delete cluster foo
      And I run the cleaner with command to delete cluster bar
      And I run the cleaner to display all records older than 90 days
     Then I should see the following clusters
          | cluster                              |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
     When I delete all tables from database
     Then I should find that the database is empty
