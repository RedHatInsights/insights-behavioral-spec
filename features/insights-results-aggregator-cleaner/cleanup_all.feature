@aggregator_cleaner
Feature: Ability to delete old records from database

  Background:
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established

  @database @database-write
  Scenario: Clean up old records
    Given the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 00000000-0000-0000-0000-000000000000 |        | 1970-01-01  |  1970-01-01     |
          | 2      | 11111111-1111-1111-1111-111111111111 |        | 2024-01-01  |  2024-01-01     |
      And I run the cleaner to display all records older than 1 day
     Then I should see the following clusters
          | cluster                              |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-1111-1111-1111-111111111111 |
     When I run the cleaner without dry-run to cleanup all records older than 50 years
      And I run the cleaner to display all records older than 1 day
     Then I should see the following clusters
          | cluster                              |
          | 11111111-1111-1111-1111-111111111111 |
     When I delete all tables from database
     Then I should find that the database is empty

  @database @database-write
  Scenario: Clean up orphan records
    Given the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RULE_HIT table
          | org_id | cluster_id                           | rule_fqdn | error_key | template_data |
          | 1      | 00000000-0000-0000-0000-000000000000 | fqdn1     | ek1       |  template1    |
          | 2      | 11111111-1111-1111-1111-111111111111 | fqdn2     | ek2       |  template2    |
     When I run the cleaner without dry-run to cleanup all records older than 5 days
     Then I should find that table RULE_HIT is empty
     When I delete all tables from database
     Then I should find that the database is empty

  @database @database-write
  Scenario: Clean up old records with dry-run
    Given the database is empty
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at | last_checked_at |
          | 1      | 00000000-0000-0000-0000-000000000000 |        | 1970-01-01  |  1970-01-01     |
          | 2      | 11111111-1111-1111-1111-111111111111 |        | 2024-01-01  |  2024-01-01     |
      And I run the cleaner to display all records older than 1 day
     Then I should see the following clusters
          | cluster                              |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-1111-1111-1111-111111111111 |
     When I run the cleaner with dry-run to cleanup all records older than 50 years
      And I run the cleaner to display all records older than 1 day
     Then I should see the following clusters
          | cluster                              |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-1111-1111-1111-111111111111 |
     When I delete all tables from database
     Then I should find that the database is empty