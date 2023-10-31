@parquet_service

Feature: Ability to handle the S3 connection correctly

    Background: Initial state is ready
      Given the system is in default state
        And Kafka broker is available
        And Kafka topic "incoming_features_topic" is empty and has 2 partitions
        And Kafka topic "incoming_rules_topic" is empty and has 2 partitions
        And S3 endpoint is set
        And S3 port is set
        And S3 access key is set
        And S3 secret access key is set
        And S3 bucket name is set to test
        And S3 connection is established
        And The S3 bucket is empty

    Scenario: Parquet Factory should fail if it cannot connect with S3. When I rerun it, it should re-process the messages from the beginning
     When I set the environment variable "PARQUET_FACTORY__S3__ENDPOINT" to "non-existent-url"
      And I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
      And I run Parquet Factory with a timeout of "20" seconds
      # Then  Parquet Factory shouldn't have finish
      # I removed this step because in CI PF takes 0 seconds to discover that the URL doesn't exist whether in local it takes more than 20
     Then The S3 bucket is empty
      And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 1         | 1      | FINISH            |
      And The logs should contain "Unable to retrieve the indexes from S3 bucket"
      # Check that it reprocess the same messages
     When I run Parquet Factory with a timeout of "20" seconds
     Then The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 1         | 1      | FINISH            |

    Scenario: Parquet Factory should fail if it cannot find the bucket
     When I set the environment variable "PARQUET_FACTORY__S3__BUCKET" to "non_existent_bucket"
      And I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
      And I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
     Then The S3 bucket is empty
      And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 1         | 1      | FINISH            |
      And The logs should contain "NoSuchBucket"
      # Check that it reprocess the same messages
     When I run Parquet Factory with a timeout of "10" seconds
     # FIXME: PF doesn't start from the beginning in case of the bucket not existing
     Then The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 1         | 1      | FINISH            |
      And The logs should contain "NoSuchBucket"

    Scenario: Parquet Factory shouldn't fail if it cannot find the folder/prefix where the files are stored
     When I set the environment variable "PARQUET_FACTORY__S3__PREFIX" to "non_existing_folder"
      And I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
      And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
      And I run Parquet Factory with a timeout of "10" seconds
     Then Parquet Factory should have finish
      And The S3 bucket is not empty
      And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 1         | 1      | FINISH            |
      And The logs should contain "File will be stored in non_existing_folder/"
