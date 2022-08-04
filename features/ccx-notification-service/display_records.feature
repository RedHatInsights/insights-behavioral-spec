Feature: Ability to display old records stored in database


  Scenario: Check the ability to display old records from `new_reports` if the table is empty.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
     When I select all rows from table new_reports
     Then I should get 0 rows
     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
     Then I should see info about not notified reports older than 90 days displayed on standard output
      And the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `reported` table if the table is empty.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
     When I select all rows from table reported
     Then I should get 0 rows
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
    Then the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `new_reports` if the table contains one old report.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
     When I select all rows from table new_reports
     Then I should get 1 rows
     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
    Then I should see info about not notified reports older than 90 days displayed on standard output
     And I should see old reports from new_reports for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
     And the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `new_reports` if the table contains only new reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
         Then I should see info about not notified reports older than 90 days displayed on standard output
     And I should not see any old reports from new_reports
     And the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `new_reports` if the table contains new and old reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 2990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
     Then I should see info about not notified reports older than 90 days displayed on standard output
      And I should see old reports from new_reports for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
     Then the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `reported` if the table contains one old report.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 1 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
      And I should see old reports from reported for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
     Then the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `reported` if the table contains only new reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important  |
          | 2      |  20             | 5d5892d4-1f74-4ccf-91af-548dfc9767bb | 1                 | 1     | 2990-01-01  | 2990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should not see any old reports from reported
      And the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `reported` if the table contains multiple old reports.
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
      And I should see old reports from reported for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa |
      And the process should exit with status code set to 0


  Scenario: Check the ability to display old records from `reported` if the table contains old and new reports
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2990-01-01  | 2990-01-01   | important  |
     When I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
      And I should see old reports from reported for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And the process should exit with status code set to 0
