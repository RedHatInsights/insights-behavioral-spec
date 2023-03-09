Feature: Checking Aggregator behaviour during starting the service


  @cli
  Scenario: Check how Insights Results Aggregator reacts to non existent configuration file
    Given the system is in default state
     When I run the Insights Results Aggregator with the start-service command line flag and config file name set to ./it-does-not-exis.toml
     Then The process should finish with exit code 2
      And I should see following message in service output: "panic: fatal error config file: Config File "it-does-not-exis" Not Found in"
