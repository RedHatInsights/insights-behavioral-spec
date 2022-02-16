Feature: SHA Extractor


  Scenario: Check that SHA exctractor service has all the information and interfaces it needs to work properly
    Given SHA extractor service is not started
      And Kafka broker is started on host and port specified in configuration
      And Kafka topic specified in configuration variable "incoming_topic" is created
      And Kafka topic specified in configuration variable "dead_letter_queue_topic" is created
      And Kafka topic specified in configuration variable "archive_results" is created
     When SHA extractor service is started
     Then SHA extractor service does not exit with an error code
      And SHA extractor service should be registered to topic "incoming_topic"
