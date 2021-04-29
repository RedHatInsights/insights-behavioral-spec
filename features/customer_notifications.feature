Feature: Customer Notifications


  Scenario: Check that notification service has all the information it needs to work properly
    Given notification service is not started
      And insights-content service is available at the URL provided via config
      And notification database is started and accessible from notification service
    When notification service is started
    Then notification service does not exit with an error code



  Scenario: Check that notification service produces instant notifications with the expected content
    Given notification service is started
      And notification service is configured to produce instant notifications
      And notification rules are available
      And content has been retrieved from insights-content service
    When notification database's new_reports table has 5 new reports
      And 1 report is considered important and affects cluster C1
      And 1 report is considered critical and affects cluster C2
      And notification database's reported table has no rows
    Then the notification service should obtain the 5 new reports
      And it should filter out the 3 reports that are not considered important or critical
      And it should create 1 new notification message for U1
      And it should create 1 new notification message for U2
      And all the notification messages have the corresponding event type for instant notifications
      And each notification's events list has 1 event
      And each event's payload is an escaped JSON string
      And each notification's event's metadata is empty
      And each notification's event's payload contains the fields expected by the instant email template
      And each notification's context contains the fields expected by the instant email template
      And it should produce the 2 notification messages into the notification service's Kafka topic



  Scenario: Check that notification service produces instant notifications with the expected content
     Given notification service is started
       And notification service is configured to produce instant notifications
       And notification rules are available
       And content has been retrieved from insights-content service
     When Notification database's new_reports table has 10 reports
       And 5 reports have been created in the last 7 days
       And 2 clusters are affected by the retrieved reports
       And notification database's reported table has no rows
     Then the notification service should read the 5 reports of the last 7 days with current day included
       And it should select all the reports independently of severity
       And it should create 2 new notification messages
       And all the notification messages have the corresponding event type for weekly notifications
       And each notification's events list is not empty
       And each event's payload is an escaped JSON string
       And each event's metadata is empty
       And each event's payload contains the fields expected by the weekly email template
       And the notification's context contains the fields expected by the weekly email template
       And it should produce the 2 notification messages into the notification service's Kafka topic



  Scenario: Check that notification are sent to user when events are sent to the notification service's kafka topic
    Given notification service has prepared 1 notification for cluster C1
      And cluster C1 is associated with user U1
      And user U1 has a webhook configured in his notification preferences
    When notification is sent to the notification service's Kafka topic
    Then the Insights-Notification backend must process it correctly
      And the webhook associated to the user U1 should receive the notification



  Scenario: Check that instant notification does not include the same reports as in previous notification
    Given notification service is started
      And notification service is configured to produce instant notifications
      And notification service has produced a notification for test_report
      And notification database's reported table has 1 row for test_report
      When Notification database has 5 new reports
        And 1 report is considered important and affects cluster C1
	And 1 report is considered critical and affects cluster C2
	And test_report is present and is considered critical 
      Then the notification service should read 5 reports from the new_reports table
      And it should filter out the 2 reports that are not considered important or critical
      And it should filter out test_report
      And it should create 1 notification message for U1
      And it should create 1 notification message for U2
      And it should produce the 2 notification messages into the notification service's Kafka topic



  Scenario: Check that notification service does not flood custer with unnecessary instant emails
    Given notification service is started
      And notification service is configured to produce instant notifications
    When Notification database has reports
      And all reports are marked as notified
    Then the notification service should not read any reports 
      And it should not produce any notifications into the notification service's Kafka topic



  Scenario: Check that notification service does not flood cluster with unnecessary weekly emails
    Given notification service is started
      And Notification database is started and accessible
      And notification service is configured to produce weekly notifications
    When weekly digest has been sent for the current week
    Then the notification service should not read any reports
      And it should not produce any notifications into the notification service's Kafka topic

