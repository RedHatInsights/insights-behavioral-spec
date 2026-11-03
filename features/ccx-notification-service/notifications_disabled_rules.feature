@notification_service
Feature: Ability to take disabled rules from the aggregator database into account when sending notifications

"""
This feature is not testing the basic behavior of notifications.
It's only testing the behavior regarding disabled rules.
"""

  Background:
    Given the aggregator database is named aggregator
      And aggregator database user is set to postgres
      And aggregator database password is set to postgres
      And aggregator database is in initial state
     When aggregator database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number from aggregator database
     Then I should see that migration #32 is returned
    Given the notification database is named test
      And notification database user is set to postgres
      And notification database password is set to postgres
      And notification database connection is established
      And CCX Notification database is set up
      And Kafka broker is available
      And Kafka topic "platform.notifications.ingress" is empty

  @message-producer
  Scenario: Check that a rule disabled for a single cluster affects the cluster
     When I insert following row into table reported
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | important  | 1             |
      And I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |

  @message-producer
  Scenario: Check that a rule ack affects all clusters in an organization
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
          | 1      | 1              | 7e6903e5-3h96-5ddf-13ch-659efd8878bb |
      And I confirm that the reports contain the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |
          | 7e6903e5-3h96-5ddf-13ch-659efd8878bb | 1             | same  | none  |

  @message-producer
  Scenario: Check that a rule ack for an organization does not affect other organizations
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
          | 2      | 2              | 7e6903e5-3h96-5ddf-13ch-659efd8878bb |
      And I confirm that the reports contain the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 2      | 7e6903e5-3h96-5ddf-13ch-659efd8878bb | 4           |
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none                      |
          | 7e6903e5-3h96-5ddf-13ch-659efd8878bb | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario: Check that enabling a single cluster disable rule works in the next run
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 1 row
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @message-producer
  Scenario: Check that enabling a rule ack works in the next run
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 1 row
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id                                | error_key                 |
          | 1      | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 2 rows

  @message-producer
  Scenario: Check that re-enabling a rule within cooldown does not notify
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 1 row
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |
    Given Kafka topic "platform.notifications.ingress" is empty
     When I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 3 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario: Check that re-enabling a rule outside cooldown does notify
    Given I insert 1 previously reported report with critical total risk
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | critical   | 1             |
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @message-producer
  Scenario: Check that re-enabling a rule ack within cooldown does not notify
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 1 row
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |
    Given Kafka topic "platform.notifications.ingress" is empty
     When I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id                                | error_key                 |
          | 1      | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 3 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario: Check that re-enabling a rule ack outside cooldown does notify
    Given I insert 1 previously reported report with critical total risk
          | org id | account number | cluster name                         | notification type | state | updated at | notified at | total risk | event type id |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1                 | 1     | 1990-01-01 | 1990-01-01  | critical   | 1             |
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rule
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id                                | error_key                 |
          | 1      | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the process should exit with status code set to 0
      And the reported table should have 3 rows

  @message-producer
  Scenario: Check that only the re-enabled rule is notified when other rules are in cooldown
     When I insert 1 report with critical and important total risk rules for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rules
          | rule_id                               |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT  |
          | test_rule\|TEST_RULE_IMPORTANT_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3          |
      And the notification event should contain only the following rules
          | rule_id                               |
          | test_rule\|TEST_RULE_IMPORTANT_IMPACT |
      And the process should exit with status code set to 0
      And the reported table should have 1 row
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                      |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_IMPORTANT_IMPACT |
    Given Kafka topic "platform.notifications.ingress" is empty
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent the following 1 notification events to Kafka
          | org id | cluster name                         | total risk |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          |
      And the notification event should contain only the following rules
          | rule_id                              |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT |
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                                                 |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT, TEST_RULE_IMPORTANT_IMPACT |

  @message-producer
  Scenario: Check that a rule disabled for a single cluster does not affect other clusters in the organization
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
          | 1      | 1              | 7e6903e5-3h96-5ddf-13ch-659efd8878bb |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 7e6903e5-3h96-5ddf-13ch-659efd8878bb | 4           |
      And the process should exit with status code set to 0
      And the reported table should have 2 rows
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none                      |
          | 7e6903e5-3h96-5ddf-13ch-659efd8878bb | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario: Check that a rule disabled for a cluster by its previous organization does not affect the cluster
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 2      | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario Outline: Check that a rule disabled for a cluster is ignored when stored in a form the Advisor UI does not use
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id   | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | <rule_id> | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0

    Examples:
          | rule_id                                |
          | test_rule                              |
          | ccx_rules_ocp.external.rules.test_rule |

  @message-producer
  Scenario Outline: Check that a rule ack is ignored when stored in a form the Advisor UI does not use
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id   | error_key                 |
          | 1      | user1   | <rule_id> | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0

    Examples:
          | rule_id                                       |
          | test_rule                                     |
          | ccx_rules_ocp.external.rules.test_rule.report |

  @message-producer
  Scenario: Check that a rule ack affects only the acknowledged error key
     When I insert 1 report with critical and important total risk rules for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                      |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_IMPORTANT_IMPACT |

  @message-producer
  Scenario: Check that a rule disabled for a cluster and acknowledged stays disabled until both are re-enabled
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |
     When I delete the following rule ack from the rule_disable table
          | org id | rule_id                                | error_key                 |
          | 1      | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | same  | none  |
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |

  @message-producer
  Scenario: Check that only the re-enabled rule is notified when the report is shaped like production ones
     When I insert 1 production-shaped report with critical and important total risk rules for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I confirm that the report contains the following rules
          | rule_id                               |
          | test_rule\|TEST_RULE_CRITICAL_IMPACT  |
          | test_rule\|TEST_RULE_IMPORTANT_IMPACT |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 3           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                      |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_IMPORTANT_IMPACT |
    Given Kafka topic "platform.notifications.ingress" is empty
     When I update the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 0        |
      And I start the CCX Notification Service with the --instant-reports command line flag
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                                                 |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT, TEST_RULE_IMPORTANT_IMPACT |

  @message-producer
  Scenario Outline: Check that the service notifies nothing when the aggregator database cannot be read
    Given the service is expected to exit with code 12
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                      | var     |
          | CCX_NOTIFICATION_SERVICE__AGGREGATOR_STORAGE__<variable> | <value> |
     Then it should have sent 0 notification events to Kafka
      And the process should exit with status code set to 12
      And the reported table should have 0 rows

    Examples:
          | problem                     | variable    | value    |
          | wrong password              | PG_PASSWORD | wrong    |
          | database does not exist     | PG_DB_NAME  | missing  |
          | database without the tables | PG_DB_NAME  | postgres |

  @message-producer
  Scenario Outline: Check that disabled rules are not taken into account when the service is told to ignore them
     When I insert 1 report with critical total risk for the following clusters
          | org id | account number | cluster name                         |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa |
      And I insert the following rule in the cluster_rule_toggle table for the following cluster
          | org id | account number | cluster name                         | rule_id                                       | error_key                 | disabled |
          | 1      | 1              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | ccx_rules_ocp.external.rules.test_rule.report | TEST_RULE_CRITICAL_IMPACT | 1        |
      And I insert the following rule ack in the rule_disable table
          | org id | user id | rule_id                                | error_key                 |
          | 1      | user1   | ccx_rules_ocp.external.rules.test_rule | TEST_RULE_CRITICAL_IMPACT |
      And ignore-disabled-rules command line flag is specified
      And I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                      | var        |
          | CCX_NOTIFICATION_SERVICE__AGGREGATOR_STORAGE__PG_DB_NAME | <database> |
     Then the notification topic should contain exactly the following events
          | org id | cluster name                         | total risks |
          | 1      | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4           |
      And the process should exit with status code set to 0
      And the latest reported row for each cluster should be
          | cluster name                         | event type id | state | rules                     |
          | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1             | sent  | TEST_RULE_CRITICAL_IMPACT |

    Examples:
          | aggregator database | database   |
          | usable              | aggregator |
          | not usable          | missing    |
