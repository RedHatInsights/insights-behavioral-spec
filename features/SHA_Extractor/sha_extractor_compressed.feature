@sha_extractor


Feature: SHA Extractor


  Background:
    Given Kafka broker is started on host and port specified in SHA extractor configuration "compressed"
      And Kafka topic specified in configuration variable "incoming_topic" is created
      And Kafka topic specified in configuration variable "dead_letter_queue_topic" is created
      And Kafka topic specified in configuration variable "outgoing_topic" is created


  Scenario: Check that SHA extractor service has all the information and interfaces it needs to work properly
    Given SHA extractor service is not started
     When SHA extractor service is started in group "check_info"
     Then SHA extractor service does not exit with an error code
      And SHA extractor service should be registered to topic "incoming_topic"


  Scenario: Check if SHA extractor compression works properly
    Given SHA extractor service is started with compression
     When S3 and Kafka are populated with an archive with workload_info
     Then SHA extractor should consume message about this event
      And SHA extractor validates the message format
      And SHA extractor retrieves the "url" attribute from the message
      And SHA extractor should download tarball from given URL attribute
     When the file "config/workload_info.json" is found by SHA extractor
     Then message has been sent by SHA extractor into topic "archive-results"
      And published message has to be compressed