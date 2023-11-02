@parquet_service

Feature: Ability to send metrics correctly

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
        And Pushgateway in "pushgateway:9091" is empty of metrics

    Scenario: If the Pushgateway is not accessible, Parquet Factory should run successfully
       When I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I set the environment variable "PARQUET_FACTORY__METRICS__GATEWAY_URL" to "non-existent-url"
        And I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain "No files needed to be written"
        And The logs should contain "Cannot push metrics"

    Scenario: If the Pushgateway is accessible, Parquet Factory should run successfully and send the metrics to the Pushgateway
       When I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I set the environment variable "PARQUET_FACTORY__METRICS__GATEWAY_URL" to "pushgateway:9091"
        And I run Parquet Factory with a timeout of "10" seconds
        And I store the metrics from "pushgateway:9091"
       Then Parquet Factory should have finish
        And The logs should contain "No files needed to be written"
        And The logs should contain "Metrics pushed successfully."
        # Offset marked is 4 because the offset -2 is always marked
        And Metrics are
        | metric           | operation | value | label | label_value |
        | error_count      | equal to  | 0     |       |             |
        | state            | equal to  | 0     |       |             |
        | offset_consummed | equal to  | 0     |       |             |
        | offset_marked    | equal to  | 4     |       |             |
        | offset_processed | equal to  | 0     |       |             |
        And Metric "inserted_rows" is not registered
        And Metric "files_generated" is not registered

    Scenario: If the Pushgateway is accessible and I run Parquet Factory with messages from the previous hour, the "files_generated" and "inserted_rows" metrics should be 1 for all the tables
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I set the environment variable "PARQUET_FACTORY__METRICS__GATEWAY_URL" to "pushgateway:9091"
        And I run Parquet Factory with a timeout of "10" seconds
        And I store the metrics from "pushgateway:9091"
       Then Parquet Factory should have finish
        And The logs should contain "\"rule_hits-0\" table was generated"
        And The logs should contain "\"cluster_info-0\" table was generated"
        And The logs should contain "\"failing_operator_conditions-0\" table was generated"
        And The logs should contain "\"alerts-0\" table was generated"
        And The logs should contain "\"gatherers_info-0\" table was generated"
        And The logs should contain "Metrics pushed successfully."
        And Metrics are
        | metric           | operation    | value | label | label_value                 |
        | error_count      | equal to     | 0     |       |                             |
        | state            | equal to     | 0     |       |                             |
        | offset_consummed | equal to     | 4     |       |                             |
        | offset_marked    | equal to     | 4     |       |                             |
        | offset_processed | equal to     | 4     |       |                             |
        | inserted_rows    | greater than | 1     | table | rule_hits                   |
        | inserted_rows    | greater than | 1     | table | cluster_info                |
        | inserted_rows    | greater than | 1     | table | failing_operator_conditions |
        | inserted_rows    | greater than | 1     | table | alerts                      |
        | inserted_rows    | greater than | 1     | table | gatherers_info              |
        | inserted_rows    | greater than | 1     | table | workload_containers         |
        | inserted_rows    | greater than | 1     | table | workload_image_layers       |
        | files_generated  | equal to     | 1     | table | rule_hits                   |
        | files_generated  | equal to     | 1     | table | cluster_info                |
        | files_generated  | equal to     | 1     | table | failing_operator_conditions |
        | files_generated  | equal to     | 1     | table | alerts                      |
        | files_generated  | equal to     | 1     | table | gatherers_info              |
        | files_generated  | equal to     | 1     | table | workload_containers         |
        | files_generated  | equal to     | 1     | table | workload_image_layers       |

    Scenario: If the Pushgateway is accessible and Parquet Factory errors, the "error_count" metric should increase
       When I set the environment variable "PARQUET_FACTORY__KAFKA_FEATURES__ADDRESS" to "non-existent-url"
        And I set the environment variable "PARQUET_FACTORY__KAFKA_RULES__ADDRESS" to "non-existent-url"
        And I set the environment variable "PARQUET_FACTORY__METRICS__GATEWAY_URL" to "pushgateway:9091"
        And I run Parquet Factory with a timeout of "10" seconds
        And I store the metrics from "pushgateway:9091"
       Then Parquet Factory should have finish
        And The logs should contain "Unable to create the Kafka consumer"
        And The logs should contain "Metrics pushed successfully."
        And Metrics are
        | metric           | operation | value | label | label_value |
        | error_count      | equal to  | 1     |       |             |
        | state            | equal to  | 0     |       |             |
        | offset_consummed | equal to  | 0     |       |             |
        | offset_marked    | equal to  | 0     |       |             |
        | offset_processed | equal to  | 0     |       |             |
        And Metric "inserted_rows" is not registered
        And Metric "files_generated" is not registered
