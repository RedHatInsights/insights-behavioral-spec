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


  @cli
  Scenario: Check if Insights Results Aggregator displays help message
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-help command line flag
     Then I should see help messages displayed by Insights Results Aggregator on standard output


  @cli
  Scenario: Check if Insights Results Aggregator displays version info
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-version-info command line flag
     Then I should see version info displayed by Insights Results Aggregator on standard output


  @cli
  Scenario: Check if Insights Results Aggregator displays actual configuration
    Given the system is in default state
     When I run the Insights Results Aggregator with the print-config command line flag
     Then I should see actual configuration displayed by Insights Results Aggregator on standard output

