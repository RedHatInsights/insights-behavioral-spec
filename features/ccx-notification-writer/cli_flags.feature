@notification_writer
Feature: Check command line options provided by CCX Notification Writer


  Scenario: Check if CCX Notification Writer displays help message
    Given the system is in default state
     When I start the CCX Notification Writer with the --help command line flag
     Then I should see help messages displayed by ccx-notification-writer on standard output


  Scenario: Check if CCX Notification Writer displays version info
    Given the system is in default state
     When I start the CCX Notification Writer with the --version command line flag
     Then I should see version info displayed by ccx-notification-writer on standard output


  Scenario: Check if CCX Notification Writer displays authors
    Given the system is in default state
     When I start the CCX Notification Writer with the --authors command line flag
     Then I should see info about authors displayed by ccx-notification-writer on standard output


  Scenario: Check the ability to initialize migration info table
    Given the system is in default state
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is not set up
     When I start the CCX Notification Writer with the --db-init-migration command line flag
     Then the process should exit with status code set to 0
      And CCX Notification database is migrated


  Scenario: Check the ability to initialize all database tables
    Given the system is in default state
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is not set up
     When I start the CCX Notification Writer with the --db-init command line flag
     Then the process should exit with status code set to 0
      And CCX Notification database is set up


  Scenario: Check the ability to perform database cleanup
    Given the system is in default state
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is empty
     When I start the CCX Notification Writer with the --db-cleanup command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to drop all database tables
    Given the system is in default state
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is empty
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0
      And the database is empty
