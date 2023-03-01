@notification_service
Feature: Customer Notifications


  Background: Dependencies are prepared
    Given Kafka broker is available
      And Kafka topic "platform.notifications.ingress" is empty
      And the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is set up
      And insights-content service is available on localhost:8082
      And prometheus push gateway is available on localhost:9091


  Scenario: Check that notification service does not need kafka if database has no new report
     When I start the CCX Notification Service with the --instant-reports command line flag
     Then the process should exit with status code set to 0


  @message-producer
  Scenario: Check that notification service does not send messages to kafka if broker is disabled and service log enabled
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                   | var         |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED       | false       |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED        | true        |
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the logs should match
          | log                              | contains   |
          | Report with high impact detected | yes        |
          | No new issues to notify          | no         |
     When I select all rows from table reported
     Then I should get 1 rows


  @message-producer
  Scenario: Check that notification service produces instant notifications with the expected content if all dependencies are available
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the process should exit with status code set to 0
      And it should have sent the following 1 notification events to Kafka
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
     When I select all rows from table reported
     Then I should get 1 rows


  @message-producer
  Scenario: Check that notification service produces a single notification event for cluster with multiple new reports
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with critical total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0


  @message-producer
  Scenario: Check that instant notification does not include the same reports as in previous notification
     When I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  | 1             |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with critical total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0


  @message-producer
  Scenario: Check that notification service does not flood customer with unnecessary instant emails
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
     Then it should have sent the following 1 notification events to Kafka
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the process should exit with status code set to 0

  @message-producer
  Scenario: Check that notification service resends notification after cooldown has passed
     When I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | total risk | event type id |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | important  | 1             |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          |  account number | cluster name                         | total risk |
          |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the process should exit with status code set to 0
