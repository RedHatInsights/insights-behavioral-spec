Feature: Basic set of smoke tests


  Scenario: Check if exporter application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator-exporter
     Then I should find that file on PATH


  Scenario: Check if exporter displays help message
    Given the system is in default state
     When I run the exporter with the --help command line flag
     Then I should see help messages displayed by exporter on standard output


  Scenario: Check if exporter displays version info
    Given the system is in default state
     When I run the exporter with the --version command line flag
     Then I should see version info displayed by exporter on standard output


  Scenario: Check if exporter displays authors
    Given the system is in default state
     When I run the exporter with the --authors command line flag
     Then I should see info about authors displayed by exporter on standard output
