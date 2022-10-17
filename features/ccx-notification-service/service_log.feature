Feature: Service Log

  Background: Kafka is empty
    Given CCX Notification database is created for user postgres with password postgres
      And CCX Notification database is empty 
      And insights-content service is available on localhost:8082
      And service-log service is available on localhost:8000
      And token refreshment server is available on localhost:8001

  Scenario: Check that notification service does not send messages to service log if it is disabled
    Given Postgres is running
      And service-log service is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | false |
     Then it should have sent 0 notification events to Service Log
      And the process should exit with status code set to 0
      And the logs should match
          | log                              | contains   |
          | Report with high impact detected | yes        |
          | No new issues to notify          | no         |

  Scenario: Check that notification service sends messages to service log if it is enabled
    Given Postgres is running
      And service-log service is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log
      And the process should exit with status code set to 0

  Scenario: Check that notification service doesn't send message to service log if it is not important
    Given Postgres is running
      And service-log service is empty
     When I insert 1 report with low total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log
      And the process should exit with status code set to 0

  Scenario: Check that notification service doesn't send message that has been sent within cooldown
    Given Postgres is running
      And service-log service is empty
      And I insert 1 previously reported report with important total risk notified within cooldown
          | org id |  account number | cluster name                         | notification type | state | updated at  | total risk | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | important  | 2             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log
      And the process should exit with status code set to 0

  Scenario: Check that notification service resends message after cooldown has passed
    Given Postgres is running
      And service-log service is empty
      And I insert 1 previously reported report with important total risk
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | 2             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log
      And the process should exit with status code set to 0

  Scenario: Check that notification service produces a single notification event for cluster with multiple new reports
    Given Postgres is running
      And service-log service is empty
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767   |
    When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767   |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log
      And the process should exit with status code set to 0

  Scenario: Check that Kafka related rows in reported table do not affect notifications sent to service log
    Given Postgres is running
      And service-log service is empty
      And I insert 1 previously reported report with important total risk notified within cooldown
          | org id |  account number | cluster name                         | notification type | state | updated at  | total risk | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | important  | 1             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log
      And the process should exit with status code set to 0
