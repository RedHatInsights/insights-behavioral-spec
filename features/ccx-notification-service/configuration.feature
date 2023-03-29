@notification_service
Feature: Customer Notifications configuration and exit codes


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


  Scenario: Check that notification service exits with exit code 1 if no destination is configured
    Given the service is expected to exit with code 1
     When I start the CCX Notification Service with the --instant-reports command line flag
          | val                                                   | var         |
          | CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED       | false       |
          | CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED        | false        |
     Then it should have sent 0 notification events to Kafka
      And it should have sent 0 notification events to Service Log
      And the process should exit with status code set to 1
      And the logs should match
          | log                                              | contains   |
          | No known event destination configured. Aborting. | yes        |
