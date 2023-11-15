@parquet_service

Feature: Ability to process the Kafka messages correctly

    Background: Initial state is ready
      Given the system is in default state
        And Kafka broker is available
        And Kafka topic "incoming_rules_topic" is empty and has 2 partitions
        And S3 endpoint is set
        And S3 port is set
        And S3 access key is set
        And S3 secret access key is set
        And S3 bucket name is set to test
        And S3 connection is established
        And The S3 bucket is empty

    Scenario: Parquet Factory should fail if it cannot read from Kafka
       When I set the environment variable "PARQUET_FACTORY__KAFKA_RULES__ADDRESS" to "non-existent-url"
        And I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain "Unable to create the Kafka consumer"
        And The S3 bucket is empty

    Scenario: Parquet Factory shouldn't finish if only messages from the previous hour arrived
       When I fill the topics with messages of the previous hour
      | topic                   | partition | type             | cluster                              |
      | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
      | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
       When I set the environment variable "PARQUET_FACTORY__KAFKA_RULES__CONSUMER_TIMEOUT" to "20"
        And I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory shouldn't have finish
        And The logs should contain
      | topic                   | partition | offset | message           |
      | incoming_rules_topic    | 0         | 0      | message processed |
      | incoming_rules_topic    | 1         | 0      | message processed |
        And The logs shouldn't contain
      | topic                   | partition | offset | message |
      | incoming_rules_topic    | 0         | 1      | FINISH  |
      | incoming_rules_topic    | 0         | 1      | FINISH  |
        And The S3 bucket is empty

  Scenario: Parquet Factory shouldn't finish if not all the topics and partitions are filled with current hour messages
     When I fill the topics with messages of the previous hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
    | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory shouldn't have finish
      And The logs should contain
    | topic                   | partition | offset | message           |
    | incoming_rules_topic    | 0         | 0      | message processed |
    | incoming_rules_topic    | 1         | 0      | message processed |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
      And The S3 bucket is empty

  Scenario: Parquet Factory should finish if all the topics and partitions are filled with current hour messages
     When I fill the topics with messages of the previous hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
    | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The logs should contain
    | topic                   | partition | offset | message           |
    | incoming_rules_topic    | 0         | 0      | message processed |
    | incoming_rules_topic    | 1         | 0      | message processed |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
      And The S3 bucket is not empty

  Scenario: After aggregating messages from previous hour, the first messages from current hour has to be processed first
     When I fill the topics with messages of the previous hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
    | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The logs should contain
    | topic                   | partition | offset | message           |
    | incoming_rules_topic    | 0         | 0      | message processed |
    | incoming_rules_topic    | 1         | 0      | message processed |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
    | incoming_rules_topic    | 0         | 1      | FINISH            |
     Then The S3 bucket is not empty
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The logs should contain
    | topic                   | partition | offset | message |
    | incoming_rules_topic    | 0         | 1      | FINISH  |
    | incoming_rules_topic    | 1         | 1      | FINISH  |

  Scenario: Parquet Factory should finish if the limit of kafka messages is exceeded even if no messages from current hour arrived
     When I fill the topics with messages of the previous hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
    | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
    | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
    | incoming_rules_topic    | 0         | rules message    | bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb |
    | incoming_rules_topic    | 1         | rules message    | cccccccc-cccc-cccc-cccc-cccccccccccc |
      And I set the environment variable "PARQUET_FACTORY__KAFKA_RULES__MAX_CONSUMED_RECORDS" to "1"
      And I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
     Then The S3 bucket is not empty

  Scenario: Parquet Factory should not commit the messages from current hour if there are no prior messages
     When I fill the topics with messages of the current hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The logs should contain
    | topic                   | partition | offset | message |
    | incoming_rules_topic    | 0         | 0      | FINISH  |
    | incoming_rules_topic    | 0         | 0      | FINISH  |
     Then The S3 bucket is empty
     # Rerun it to check that it starts with the same messages
     When I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The logs should contain
    | topic                   | partition | offset | message |
    | incoming_rules_topic    | 0         | 0      | FINISH  |
    | incoming_rules_topic    | 0         | 0      | FINISH  |
    Then The S3 bucket is empty

Scenario: Parquet Factory shouldn't send duplicate rows
     When I fill the topics with messages of the previous hour
    | topic                   | partition | type             | cluster                              |
    | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
    | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
     When I run Parquet Factory with a timeout of "10" seconds
     Then The logs should contain "factory was about to duplicate a row, skipping"
