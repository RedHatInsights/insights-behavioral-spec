@aggregator_cleaner
Feature: Ability to vacuum database


  Background:
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established


  @database @database-write
  Scenario: Vacuum the database
    Given the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 1990-01-01  |  1990-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2200-01-01  |  2200-01-01     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2200-01-01  |  2200-01-01     |
      And I instruct the cleaner to vacuum database
     Then I should see information about vacuuming process
