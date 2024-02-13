@dvo_extractor

Feature: DVO extractor

  Background:
    Given Kafka broker is started on host and port specified in DVO extractor configuration
      And Kafka topic specified in configuration variable "incoming_topic" is created
      And Kafka topic specified in configuration variable "dead_letter_queue_topic" is created
      And Kafka topic specified in configuration variable "outgoing_topic" is created

  Scenario: Check that DVO extractor service has all the information and interfaces it needs to work properly
    Given DVO extractor service is not started
     When DVO extractor service is started in group "check_info"
     Then DVO extractor service does not exit with an error code
      And DVO extractor service should be registered to topic "incoming_topic"

  Scenario: Check if DVO extractor is able to consume messages from Kafka
     When S3 and Kafka are populated with an archive without workload_info
      And DVO extractor service is started in group "check"
     Then DVO extractor should consume message about this event
      And the message received by DVO extractor should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
      And DVO extractor decode the b64_identity attribute

  Scenario: Check if DVO extractor is able to consume messages from Kafka and then download tarball
    Given DVO extractor service is started
     When S3 and Kafka are populated with an archive without workload_info
     Then DVO extractor should consume message about this event
      And the message received by DVO extractor should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
      And DVO extractor retrieves the "url" attribute from the message
      And DVO extractor should download tarball from given URL attribute

  Scenario: Check if DVO extractor is able to produce workload recommendations
    Given DVO extractor service is started
     When S3 and Kafka are populated with an archive with workload_info
     Then DVO extractor should consume message about this event
      And the message received by DVO extractor should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
     Then DVO extractor retrieves the "url" attribute from the message
      And DVO extractor should download tarball from given URL attribute
      And message has been sent by DVO extractor into topic "archive-results"