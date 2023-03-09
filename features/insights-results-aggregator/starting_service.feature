Feature: Checking Aggregator behaviour during starting the service


  @cli
  Scenario: Check how Insights Results Aggregator reacts to non existent configuration file
    Given the system is in default state
     When I run the Insights Results Aggregator with the start-service command line flag and config file name set to ./it-does-not-exis.toml
     Then The process should finish with exit code 2
      And I should see following message in service output: "panic: fatal error config file: Config File "it-does-not-exis" Not Found in"


  @cli
  Scenario: Check how Insights Results Aggregator reacts to broken database configuration
    Given the system is in default state
     When I run the Insights Results Aggregator with the start-service command line flag and config file name set to config/insights_results_aggregator_wrong_db.toml
     Then The process should finish with exit code 2
      And I should see following message in service output: "unable to check DB migration version"
      And I should see following message in service output: "database preparation exited with error code 2"


  @cli
  Scenario: Check how Insights Results Aggregator reacts to situation when Kafka is not reachable
    Given the system is in default state
     When I run the Insights Results Aggregator with the start-service command line flag and config file name set to config/insights_results_aggregator.tom
     Then The process should finish with exit code 1
      And I should see following message in service output: "Failed to connect to broker"
      And I should see following message in service output: "kafka: client has run out of available brokers to talk to (Is your cluster reachable?)"
      And I should see following message in service output: "waiting for consumer to start"
