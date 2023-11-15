@parquet_service

Feature: Ability to generate parquet files correctly

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

    Scenario: Table generation: cluster_thanos_info
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
        And I should not see following objects generated in S3
        | File name                              |
        | fleet_aggregations/cluster_thanos_info/hourly/date=2016-02-02/hour=05/cluster_thanos_info-0.parquet |
