@sha_extractor


Feature: SHA Extractor


  Background:
    Given Kafka broker is started on host and port specified in configuration
      And Kafka topic specified in configuration variable "incoming_topic" is created
      And Kafka topic specified in configuration variable "dead_letter_queue_topic" is created
      And Kafka topic specified in configuration variable "outgoing_topic" is created


  Scenario: Check that SHA extractor service has all the information and interfaces it needs to work properly
    Given SHA extractor service is not started
     When SHA extractor service is started in group "check_info"
     Then SHA extractor service does not exit with an error code
      And SHA extractor service should be registered to topic "incoming_topic"


  Scenario: Check if SHA extractor is able to consume messages from Kafka
     When an archive without workload info is announced in "incoming_topic" topic
      And SHA extractor service is started in group "check"
     Then SHA extractor should consume message about this event
      And this message should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
      And SHA extractor decode the b64_identity attribute


  Scenario: Check if SHA extractor is able to consume messages from Kafka and then download tarball
    Given SHA extractor service is started
     When an archive without workload info is announced in "incoming_topic" topic
     Then SHA extractor should consume message about this event
      And this message should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
      And SHA extractor retrieve the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute


  Scenario: Check if SHA extractor is able to consume messages from Kafka, download tarball, and take SHA images
    Given SHA extractor service is started
     When an archive without workload info is announced in "incoming_topic" topic
     Then SHA extractor should consume message about this event
      And this message should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
     Then SHA extractor retrieve the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute
     When the file "config/workload_info.json" is not found
     Then the tarball is not further processed


  Scenario: Check if SHA extractor is able to finish the processing of SHA images
    Given SHA extractor service is started
     When an archive with workload info is announced in "incoming_topic" topic
     Then SHA extractor should consume message about this event
      And this message should contain following attributes
          | Attribute    | Description                | Type         |
          | account      | account ID                 | unsigned int |
          | principal    | principal ID               | unsigned int |
          | size         | tarball size               | unsigned int |
          | url          | URL to S3                  | string       |
          | b64_identity | identity encoded by BASE64 | string       |
          | timestamp    | timestamp of event         | string       |
     Then SHA extractor retrieve the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute
     When the file "config/workload_info.json" is found
     Then the content of this file needs to be sent into topic "archive_results"
