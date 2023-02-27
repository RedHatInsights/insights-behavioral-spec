@notification_service
Feature: Check command line options provided by CCX Notification Service


  Background: Dependencies are prepared
    Given the system is in default state
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is set up


  @cli
  Scenario: Check if CCX Notification Service displays help message
     When I start the CCX Notification Service with the --help command line flag
     Then I should see help messages displayed by ccx-notification-service on standard output


  @cli
  Scenario: Check if CCX Notification Service displays version info
     When I start the CCX Notification Service with the --show-version command line flag
     Then I should see version info displayed by ccx-notification-service on standard output


  @cli
  Scenario: Check if CCX Notification Service displays configuration
     When I start the CCX Notification Service with the --show-configuration command line flag
     Then I should see the current configuration displayed on standard output


  @cli
  Scenario: Check if CCX Notification Service displays authors
     When I start the CCX Notification Service with the --show-authors command line flag
     Then I should see info about authors displayed by ccx-notification-service on standard output


  @cli
  Scenario: Check the ability to display new reports for cleanup

     When I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
     Then I should see info about not notified reports older than 90 days displayed on standard output
      And the process should exit with status code set to 0


  @cli
  Scenario: Check the ability to display old reports for cleanup
     When I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 90 days displayed on standard output
      And the process should exit with status code set to 0


  @cli
  Scenario: Check the ability to display new reports for cleanup with max-age specified
     When max-age 10 days command line flag is specified
      And I start the CCX Notification Service with the --print-new-reports-for-cleanup command line flag
     Then I should see info about not notified reports older than 10 days displayed on standard output
      And the process should exit with status code set to 0


  @cli
  Scenario: Check the ability to display old reports for cleanup with max-age specified
     When max-age 10 days command line flag is specified
      And I start the CCX Notification Service with the --print-old-reports-for-cleanup command line flag
     Then I should see info about notified reports older than 10 days displayed on standard output
      And the process should exit with status code set to 0


  @cli
  Scenario: Check the ability to perform database cleanup on startup
     When cleanup-on-startup command line flag is specified
     When I start the CCX Notification Service with the --instant-reports command line flag
     Then It should clean items in new_reports table older than 90 days
      And It should clean items in reported table older than 90 days
      And the process should exit with status code set to 0
