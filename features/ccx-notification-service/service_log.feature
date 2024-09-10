Feature: Service Log

  Background: Dependencies are prepared
    Given the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And CCX Notification database is set up
      And service-log service has no records for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And insights-content service is available on localhost:8082
      And service-log service is available on localhost:8000
      And token refreshment server is available on localhost:8001


  @rest-api
  Scenario: Check that notification service does not send messages to service log if it is disabled
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | false |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
      And the logs should match
          | log                                                          | contains |
          | Report with impact higher than configured threshold detected | yes      |
          | No new issues to notify                                      | no       |


  @rest-api
  Scenario: Check that notification service sends messages to service log if it is enabled
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
     When I retrieve the service log events for the following clusters
          | cluster name                         |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
     Then I should find the following log events for each cluster
          | cluster name                         | num logs | service name             |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1        | CCX Notification Service |


  @rest-api
  Scenario: Check that notification service includes correct service name if set
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED    | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED     | true  |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__CREATED_BY  | test  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
     When I retrieve the service log events for the following clusters
          | cluster name                         |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
     Then I should find the following log events for each cluster
          | cluster name                         | num logs | service name |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1        | test         |


  @rest-api
  Scenario: Check that notification service does not send messages to service log if it cannot be rendered
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                               | var         |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED                   | false       |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED                    | true        |
          | CCX_NOTIFICATION_SERVICE__DEPENDENCIES__TEMPLATE_RENDERER_SERVER  | unknown_url |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the logs should match
          | log                                       | contains |
          | Rendering reports failed for this cluster | yes      |
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that notification service doesn't send message to service log if it is not moderate
     When I insert 1 report with low total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
    Given service-log service has no records for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
    When I insert 1 report with moderate total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
    Given service-log service has no records for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
    When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
    Given service-log service has no records for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
    When I insert 1 report with critical total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that notification service sends log events for the configured total risk threshold
     When I insert 1 report with low total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                         | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED             | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED              | true  |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__TOTAL_RISK_THRESHOLD | 0     |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__EVENT_FILTER         | totalRisk >= totalRiskThreshold |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that notification service doesn't send message that has been sent within cooldown
    Given I insert 1 previously reported report with important total risk notified within cooldown
          | org id |  account number | cluster name                         | notification type | state | updated at  | total risk | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | important  | 2             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that notification service resends message after cooldown has passed
    Given I insert 1 previously reported report with important total risk
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   | 2             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that notification service produces a single notification event for cluster with multiple new reports
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
    When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0


  @rest-api
  Scenario: Check that Kafka related rows in reported table do not affect notifications sent to service log
    Given I insert 1 previously reported report with important total risk notified within cooldown
          | org id |  account number | cluster name                         | notification type | state | updated at  | total risk | event type id |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | important  | 1             |
     When I insert 1 report with important total risk for the following clusters
          | org id |  account number | cluster name                         |
          | 1      |  1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa
      And the process should exit with status code set to 0
