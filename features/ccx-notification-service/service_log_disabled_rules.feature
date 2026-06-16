@notification_service
Feature: Ability to take disabled rules from the aggregator database into account when sending Service Log entries

"""
This feature is not testing the basic behavior of Service Log events.
It's only testing the behavior regarding disabled rules.
"""

  Background:
    Given The aggregator database is named aggregator
      And aggregator database user is set to postgres
      And aggregator database password is set to postgres
      And aggregator database is in initial state
     When aggregator database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number from aggregator database
     Then I should see that migration #32 is returned
    Given the notification database is named notification
      And notification database user is set to postgres
      And notification database password is set to postgres
      And notification database connection is established
      And CCX Notification database is set up
      And insights-content service is available on localhost:8082
      And service-log service is available on localhost:8000
      And token refreshment server is available on localhost:8001
      And service-log service has no records for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And service-log service has no records for cluster 7e6903e5-3h96-5ddf-13ch-659efd8878bb

  @rest-api
  Scenario: Check that a rule disabled for a single cluster affects the cluster
     When I insert following row into table reported
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | important  | 2             |
      And I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @rest-api
  Scenario: Check that a rule ack affects all clusters in an organization
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
          | 1      | 1              | 7e6903e5-3h96-5ddf-13ch-659efd8878bb |
      And I confirm that the reports contain the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And it should have sent 0 notification events to Service Log for cluster 7e6903e5-3h96-5ddf-13ch-659efd8878bb
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @rest-api
  Scenario: Check that a rule ack for an organization does not affect other organizations
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
          | 2      | 2              | 7e6903e5-3h96-5ddf-13ch-659efd8878bb |
      And I confirm that the reports contain the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And it should have sent 1 notification events to Service Log for cluster 7e6903e5-3h96-5ddf-13ch-659efd8878bb
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @rest-api
  Scenario: Check that enabling a single cluster disable rule works in the next run
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 1 row
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @rest-api
  Scenario: Check that enabling a rule ack works in the next run
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 1 row
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id   | error_key                 |
          | 1      | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @rest-api
  Scenario: Check that re-enabling a rule within cooldown does not notify
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 1 row
    Given service-log service has no records for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
     When I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @rest-api
  Scenario: Check that re-enabling a rule outside cooldown does notify
     When I insert following row into table reported
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | important  | 2             |
      And I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @rest-api
  Scenario: Check that re-enabling a rule ack within cooldown does not notify
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 1 row
    Given service-log service has no records for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
     When I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id   | error_key                 |
          | 1      | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @rest-api
  Scenario: Check that re-enabling a rule ack outside cooldown does notify
     When I insert following row into table reported
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | important  | 2             |
      And I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                             |
          | test_rule|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 0 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id   | error_key                 |
          | 1      | test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @rest-api
  Scenario: Check that only the re-enabled rule is sent to service log when other rules are in cooldown
     When I insert 1 report with critical and important total risk rules for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rules
          | rule_id                              |
          | test_rule|TEST_RULE_CRITICAL_IMPACT  |
          | test_rule|TEST_RULE_IMPORTANT_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 1 row
    Given service-log service has no records for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | test_rule | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                             | var   |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED | false |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED  | true  |
     Then it should have sent 1 notification events to Service Log for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
