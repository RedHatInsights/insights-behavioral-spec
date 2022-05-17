Feature: Basic set of smoke tests


  Scenario: Check if exporter application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator-exporter
     Then I should find that file on PATH
