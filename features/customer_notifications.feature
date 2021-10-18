Feature: Customer Notifications


  Scenario: Check that notification service has all the information it needs to work properly
    Given notification service is not started
      And insights-content service is available at the URL provided via config
      And notification database is started and accessible from notification service
     When notification service is started
     Then notification service does not exit with an error code



  Scenario: Check that notification service produces instant notifications with the expected content
    Given notification service is started
      And notification service is configured to produce instant notifications on test_topic
      And notification rules are available
      And content has been retrieved from insights-content service
     When notification database has new reports 
          | account number | cluster name                         | likelihood | impact |
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 4          | 3      |
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          | 4      |
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2          | 3      |
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 2          | 1      |
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1          | 3      |
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1          | 4      |
      And notification database's reported table has no rows
     Then the notification service should retrieve 6 new reports
      And it should filter out 4 reports
      And it should create 1 new notification message for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa of account 1 with total_risk=important
      And it should create 1 new notification message for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa of account 2 with total_risk=critical
      And all the notification messages have the instant notification event type
      And each notification's events list has 1 event
      And each event's payload is an escaped JSON string
      And each notification's event's metadata is empty
      And each notification's event's payload contains the fields expected by the instant email template
      And each notification's context contains the fields expected by the instant email template
      And it should produce 2 notification messages into the configured notification service's Kafka topic



  Scenario: Check that notification service produces instant notifications with the expected content
    Given notification service is started
      And notification service is configured to produce instant notifications on test_topic
      And notification rules are available
      And content has been retrieved from insights-content service
     When notification database has new reports
          | account number | cluster name                         | likelihood | impact | age
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 4          | 3      | 1 
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          | 4      | 1 
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 2          | 3      | 1
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 2          | 1      | 1
          | 1              | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1          | 3      | 1
          | 2              | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1          | 4      | 8
      And notification database's reported table has no rows  
     Then the notification service should read 5 reports younger than 7 days with current day included
      And it should filter out 3 reports 
      And it should create 1 new notification message for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa of account 1 with total_risk=important
      And it should create 1 new notification message for cluster 5d5892d4-2g85-4ccf-02bg-548dfc9767aa of account 2 with total_risk=critical
      And all the notification messages have the instant notification event type
      And each notification's events list has 1 event
      And each event's payload is an escaped JSON string
      And each notification's event's metadata is empty
      And each notification's event's payload contains the fields expected by the instant email template
      And each notification's context contains the fields expected by the instant email template
      And it should produce 2 notification messages into the configured notification service's Kafka topic



  Scenario: Check that notification are sent to user when events are sent to the notification service's kafka topic
    Given notification service is started
      And notification service is configured to produce instant notifications on test_topic
     When it has prepared 1 notification for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa and account 1
      And account 1 has a webhook configured in his notification preferences
     When notification is sent into the configured notification service's Kafka topic
     Then the webhook associated to account 1 should receive one new event



  Scenario: Check that instant notification does not include the same reports as in previous notification
    Given notification service is started
      And notification service is configured to produce instant notifications on test_topic
      And notification service has produced a notification for test_report
      And notification database's reported table has 1 row for test_report
      And notification database has new reports
          | account number | cluster name                         | likelihood | impact | age
          | 10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 4          | 3      | 1
          | 20             | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          | 4      | 1
      And notification database's reported table has the following rows
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2021-01-01  | 2021-01-01   |           |
     When it processes new reports
     Then it should filter out 1 reports
      And it should create 1 new notification message for cluster 5d5892d4-1f74-4ccf-91af-548dfc9767aa of account 1 with total_risk=important
      And all the notification messages have the instant notification event type
      And each notification's events list has 1 event
      And each event's payload is an escaped JSON string
      And each notification's event's metadata is empty
      And each notification's event's payload contains the fields expected by the instant email template
      And each notification's context contains the fields expected by the instant email template
      And it should produce 1 notification messages into the configured notification service's Kafka topic



  Scenario: Check that notification service does not flood custer with unnecessary instant emails
    Given notification service is started
      And notification service is configured to produce instant notifications on test_topic
     When Notification database has new reports
          | account number | cluster name                         | likelihood | impact | age
          | 10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 4          | 3      | 1
          | 20             | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 4          | 4      | 1
      And notification database's reported table has the following rows
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 2021-01-01  | 2021-01-01   |           |
          | 2      |  10             | 5d5892d4-2g85-4ccf-02bg-548dfc9767aa | 1                 | 1     | 2021-01-01  | 2021-01-01   |           |
     Then it should not produce any notifications into the notification service's Kafka topic

