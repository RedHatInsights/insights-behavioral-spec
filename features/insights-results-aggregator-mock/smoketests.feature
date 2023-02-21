Feature: Basic set of smoke tests


  Scenario: Check if Insights Results Aggregator Mock application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator-mock
     Then I should find that file on PATH


  @cli
  Scenario: Check if Insights Results Aggregator Mock displays help message
    Given the system is in default state
     When I run the Insights Results Aggregator Mock with the --help command line flag
     Then I should see help messages displayed by Insights Results Aggregator Mock on standard output


  @cli
  Scenario: Check if Insights Results Aggregator Mock displays version info
    Given the system is in default state
     When I run the Insights Results Aggregator Mock with the --version command line flag
     Then I should see version info displayed by Insights Results Aggregator Mock on standard output


  @cli
  Scenario: Check if Insights Results Aggregator Mock displays authors
    Given the system is in default state
     When I run the Insights Results Aggregator Mock with the --authors command line flag
     Then I should see info about authors displayed by Insights Results Aggregator Mock on standard output


  @cli
  Scenario: Check if Insights Results Aggregator Mock displays actual configuration
    Given the system is in default state
     When I run the Insights Results Aggregator Mock with the --config command line flag
     Then I should see actual configuration displayed by Insights Results Aggregator Mock on standard output

