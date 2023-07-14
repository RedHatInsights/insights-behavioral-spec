@aggregator
Feature: Basic set of smoke tests


  Scenario: Check if Insights Results Aggregator application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator
     Then I should find that file on PATH


  @cli
  Scenario: Check if Insights Results Aggregator displays help message
    Given the system is in default state
     When I run the Insights Results Aggregator with the help command line flag
     Then I should see help messages displayed by Insights Results Aggregator on standard output
      And The process should finish with exit code 0


  @cli
  Scenario: Check if Insights Results Aggregator displays help message
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-help command line flag
     Then I should see help messages displayed by Insights Results Aggregator on standard output
      And The process should finish with exit code 0


  @cli @local
  Scenario: Check if Insights Results Aggregator displays version info
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-version-info command line flag
     Then I should see version info displayed by Insights Results Aggregator on standard output
      And The process should finish with exit code 0


  @cli
  Scenario: Check if Insights Results Aggregator displays actual configuration
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-config command line flag
     Then I should see actual configuration displayed by Insights Results Aggregator on standard output
      And The process should finish with exit code 0


  @managed @local
  Scenario: Check if jps utility is available
     When I look for executable file jps
     Then I should find that file on PATH


  @managed @local
  Scenario: Check if ZooKeeper is running locally
     When I retrieve a list of all applications running under JVM
     Then I should find the following application org.apache.zookeeper.server.quorum.QuorumPeerMain


  @managed @local
  Scenario: Check if Kafka broker is running locally
     When I retrieve a list of all applications running under JVM
     Then I should find the following application kafka.Kafka


  Scenario: Check if Kafka broker is running on expected port
     When I retrieve metadata from Kafka broker
     Then I should find at least one available broker
