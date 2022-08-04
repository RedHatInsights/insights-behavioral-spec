Feature: Ability to clean up records stored in database


  Scenario: Check the ability to clean up old records from `new_reports` table if the table is empty.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
     When I select all rows from table new_reports
     Then I should get 0 rows
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected


  Scenario: Check the ability to clean up old records from `reported` if the table is empty.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
     When I select all rows from table reported
     Then I should get 0 rows
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 0 rows


  Scenario: Check the ability to clean up old records from `new_reports` if the table contains one old report.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
     When I select all rows from table new_reports
     Then I should get 1 row
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table new_reports
     Then I should get 0 rows


  Scenario: Check the ability to clean up old records from `new_reports` table if the table contains multiple old reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table new_reports
     Then I should get 0 rows


  Scenario: Check the ability to clean up old records from `reported` table if the table contains one old report.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 1 row
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 0 rows


  Scenario: Check the ability to clean up old records from `reported` table if the table contains two old reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 2 rows
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 0 rows


  Scenario: Check that newest records in `new_reports` table are not deleted by cleanup - one new record only.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 1            |
     When I select all rows from table new_reports
     Then I should get 1 row
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table new_reports
     Then I should get 1 row


  Scenario: Check that newest records in `new_reports` table are not deleted by cleanup - multiple new records only.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
      When I select all rows from table new_reports
     Then I should get 2 rows


  Scenario: Check that newest records in `new_reports` table are not deleted by cleanup - old and new records.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I start the CCX Notification Service with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table new_reports
     Then I should get 1 row


  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty - contains one new report.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 1 row
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 1 row


  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty and contains only new reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important  |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important |
     When I select all rows from table reported
     Then I should get 2 rows
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 2 rows


  Scenario: Check the ability to clean up old records from `reported` table if the table is not empty and contains old and new reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important |
     When I select all rows from table reported
     Then I should get 2 rows
     When I start the CCX Notification Service with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When I select all rows from table reported
     Then I should get 1 row
