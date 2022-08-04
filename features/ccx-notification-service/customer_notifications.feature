Feature: Customer Notifications


  Scenario: Check that notification service does not need kafka if database has no new report
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
     When I start the CCX Notification Service with the --instant-reports command line flag
     Then the process should exit with status code set to 0


  Scenario: Check that notification service produces instant notifications with the expected content if all dependencies are available
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
      And Kafka broker is available on localhost:29092
      And prometheus push gateway is available on localhost:9091
      And CCX Notification database is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the process should exit with status code set to 0


  Scenario: Check that notification service produces instant notifications multiple events same cluster
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
      And Kafka broker is available on localhost:29092
      And prometheus push gateway is available on localhost:9091
      And CCX Notification database is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with critical total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 2 notification events
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0


  Scenario: Check that instant notification does not include the same reports as in previous notification
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
      And Kafka broker is available on localhost:29092
      And prometheus push gateway is available on localhost:9091
      And CCX Notification database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with critical total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0



  Scenario: Check that notification service does not flood customer with unnecessary instant emails
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
      And Kafka broker is available on localhost:29092
      And prometheus push gateway is available on localhost:9091
      And CCX Notification database is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the process should exit with status code set to 0

  Scenario: Check that notification service resends notification after cooldown has passed
    Given Postgres is running
      And CCX Notification database is created for user postgres with password postgres
      And insights-content service is available on localhost:8082
      And Kafka broker is available on localhost:29092
      And prometheus push gateway is available on localhost:9091
      And CCX Notification database is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk after cooldown has passed for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk after cooldown has passed for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 2 notification events
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the process should exit with status code set to 0
