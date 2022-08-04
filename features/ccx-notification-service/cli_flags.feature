Feature: Check command line options provided by CCX Notification Service


  Scenario: Check if CCX Notification Service displays help message
    Given the system is in default state
     When I start the CCX Notification Service with the --help command line flag
     Then I should see help messages displayed on standard output


  Scenario: Check if CCX Notification Service displays version info
    Given the system is in default state
     When I start the CCX Notification Service with the --show-version command line flag
     Then I should see version info displayed on standard output


  Scenario: Check if CCX Notification Service displays configuration
    Given the system is in default state
     When I start the CCX Notification Service with the --show-configuration command line flag
     Then I should see the current configuration displayed on standard output


  Scenario: Check if CCX Notification Service displays authors
    Given the system is in default state
     When I start the CCX Notification Service with the --show-authors command line flag
     Then I should see info about authors displayed on standard output


  Scenario: Check the ability to display new reports for cleanup
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification Service database is set up
     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
     Then I should see info about not notified reports older than 90 days displayed on standard output
      And the process should exit with status code set to 0


  Scenario: Check the ability to display old reports for cleanup
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification Service database is set up
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
      And the process should exit with status code set to 0


  Scenario: Check the ability to display new reports for cleanup with max-age specified
   Given Postgres is running
     And CCX Notification database is created for user postgres with password postgres
     And CCX Notification Service database is set up
    When max-age 10 days command line flag is specified
     And I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
    Then I should see info about not notified reports older than 10 days displayed on standard output
     And the process should exit with status code set to 0


  Scenario: Check the ability to display old reports for cleanup with max-age specified
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification Service database is set up
     When max-age 10 days command line flag is specified
      And I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 10 days displayed on standard output
      And the process should exit with status code set to 0


  Scenario: Check the ability to perform database cleanup on startup
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And CCX Notification Service database is set up
     When cleanup-on-startup command line flag is specified
     When I start the CCX Notification Service with the --instant-reports command line flag
     Then It should clean items in new_reports table older than 90 days
      And It should clean items in reported table older than 90 days
      And the process should exit with status code set to 0