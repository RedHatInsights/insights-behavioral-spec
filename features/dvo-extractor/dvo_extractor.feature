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
      And DVO extractor validates the message format
      And DVO extractor decode the b64_identity attribute


  Scenario: Check if DVO extractor is able to consume messages from Kafka and then download tarball
    Given DVO extractor service is started
     When S3 and Kafka are populated with an archive without workload_info
     Then DVO extractor should consume message about this event
      And DVO extractor validates the message format
      And DVO extractor retrieves the "url" attribute from the message
      And DVO extractor should download tarball from given URL attribute


  Scenario: Check if DVO extractor is able to produce workload recommendations
    Given DVO extractor service is started
     When S3 and Kafka are populated with an archive with workload_info
     Then DVO extractor should consume message about this event
      And DVO extractor validates the message format
      And DVO extractor retrieves the "url" attribute from the message
      And DVO extractor should download tarball from given URL attribute
      And message has been sent by DVO extractor into topic "archive-results"
      And produced message contains "workload_recommendations" field
      And message sent by DVO extractor has expected format