@parquet_service

Feature: Ability to set the indexes in the generated tables correctly

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

    Scenario: If Parquet file already exists, the index of the new one should be 1
        When I fill the topics with messages of the previous hour
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
        When I run Parquet Factory with a timeout of "10" seconds
        Then Parquet Factory should have finish
         And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/cluster_info/hourly/date=2016-02-02/hour=05/cluster_info-0.parquet                                   |
        # Re run and check that the index is 1. It is needed to empty the topics so that PF doesn't find the previous messages from current hour
      Given Kafka topic "incoming_features_topic" is empty and has 2 partitions
        And Kafka topic "incoming_rules_topic" is empty and has 2 partitions
         When I fill the topics with messages of the previous hour
            | topic                   | partition | type             | cluster                              |
            | incoming_features_topic | 0         | features message | 99999999-9999-9999-9999-999999999999 |
            | incoming_features_topic | 1         | features message | aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa |
            | incoming_rules_topic    | 0         | rules message    | bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb |
            | incoming_rules_topic    | 1         | rules message    | cccccccc-cccc-cccc-cccc-cccccccccccc |
         And I fill the topics with messages of the current hour
            | topic                   | partition | type             | cluster                              |
            | incoming_features_topic | 0         | features message | dddddddd-dddd-dddd-dddd-dddddddddddd |
            | incoming_features_topic | 1         | features message | eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee |
            | incoming_rules_topic    | 0         | rules message    | ffffffff-ffff-ffff-ffff-ffffffffffff |
            | incoming_rules_topic    | 1         | rules message    | 00000000-0000-0000-0000-000000000000 |
        When I run Parquet Factory with a timeout of "10" seconds
        Then Parquet Factory should have finish
         And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/cluster_info/hourly/date=2016-02-02/hour=05/cluster_info-1.parquet                                   |
