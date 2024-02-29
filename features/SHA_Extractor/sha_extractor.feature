@sha_extractor


Feature: SHA Extractor


  Background:
    Given Kafka broker is started on host and port specified in SHA extractor configuration
      And Kafka topic specified in configuration variable "incoming_topic" is created
      And Kafka topic specified in configuration variable "dead_letter_queue_topic" is created
      And Kafka topic specified in configuration variable "outgoing_topic" is created


  Scenario: Check that SHA extractor service has all the information and interfaces it needs to work properly
    Given SHA extractor service is not started
     When SHA extractor service is started in group "check_info"
     Then SHA extractor service does not exit with an error code
      And SHA extractor service should be registered to topic "incoming_topic"


  Scenario: Check if SHA extractor is able to consume messages from Kafka
     When S3 and Kafka are populated with an archive without workload_info
      And SHA extractor service is started in group "check"
     Then SHA extractor should consume message about this event
      And SHA extractor validates the message format
      And SHA extractor decode the b64_identity attribute


  Scenario: Check if SHA extractor is able to consume messages from Kafka and then download tarball
    Given SHA extractor service is started
     When S3 and Kafka are populated with an archive without workload_info
     Then SHA extractor should consume message about this event
      And SHA extractor validates the message format
      And SHA extractor retrieves the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute


  Scenario: Check if SHA extractor is able to consume messages from Kafka, download tarball, and take SHA images
    Given SHA extractor service is started
     When S3 and Kafka are populated with an archive without workload_info
     Then SHA extractor should consume message about this event
      And SHA extractor validates the message format
      And SHA extractor retrieves the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute
     When the file "config/workload_info.json" is not found by SHA extractor
     Then the tarball is not further processed


  Scenario: Check if SHA extractor is able to finish the processing of SHA images
    Given SHA extractor service is started
     When S3 and Kafka are populated with an archive with workload_info
     Then SHA extractor should consume message about this event
      And SHA extractor validates the message format
      And SHA extractor retrieves the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute
     When the file "config/workload_info.json" is found by SHA extractor
     Then message has been sent by SHA extractor into topic "archive_results"
      And published message should not be compressed