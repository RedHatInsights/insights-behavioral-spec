@aggregator_exporter
Feature: Basic set of smoke tests


  @cli
  Scenario: Check if exporter application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator-exporter
     Then I should find that file on PATH


  @cli
  Scenario: Check if exporter displays help message
    Given the system is in default state
     When I run the exporter with the --help command line flag
     Then I should see help messages displayed by exporter on standard output


  @cli
  Scenario: Check if exporter displays version info
    Given the system is in default state
     When I run the exporter with the --version command line flag
     Then I should see version info displayed by exporter on standard output


  @cli
  Scenario: Check if exporter displays authors
    Given the system is in default state
     When I run the exporter with the --authors command line flag
     Then I should see info about authors displayed by exporter on standard output


  @cli
  Scenario: Check if exporter displays configuration
    Given the system is in default state
     When I run the exporter with the --show-configuration command line flag
     Then I should see info about configuration displayed by exporter on standard output
