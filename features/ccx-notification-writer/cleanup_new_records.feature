@notification_writer
Feature: Ability to clean up old records stored in database with new records


  Background: Dependencies are prepared
  Given the system is in default state
    And the database is named notification
    And database user is set to postgres
    And database password is set to postgres
    And database connection is established
    And CCX Notification database is empty
    And CCX Notification database is migrated to version latest


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `new_reports` table if the table is empty.
     When I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `reported` table if the table is empty.
     When I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `new_reports` table if the table is not empty.
     When I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 1            |
      And I select all rows from table new_reports
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table new_reports
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `new_reports` table if the table is not empty and contains two new reports.
     When I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
      And I select all rows from table new_reports
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table new_reports
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `new_reports` table if the table is not empty and contains old and new reports.
     When I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
      And I select all rows from table new_reports
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table new_reports
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty - contains one new report.
     When I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   |           | 1             |
      And I select all rows from table reported
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table reported
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty and contains only new reports.
     When  I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   |           | 1             |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   |           | 1             |
      And I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected


  @cli @database @database-write
  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty and contains old and new reports.
     When I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   |           | 1             |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   |           | 1             |
      And I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When database connection is established
      And I select all rows from table reported
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected
