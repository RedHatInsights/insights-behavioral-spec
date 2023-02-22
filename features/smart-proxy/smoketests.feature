Feature: Basic set of smoke tests


  Scenario: Check if Smart Proxy application is available
    Given the system is in default state
     When I look for executable file insights-results-smart-proxy
     Then I should find that file on PATH


  @cli
  Scenario: Check if Smart Proxy displays help message
    Given the system is in default state
     When I run the Smart Proxy with the -help command line flag
     Then I should see help messages displayed by Smart Proxy on standard output


  @cli
  Scenario: Check if Smart Proxy displays version info
    Given the system is in default state
     When I run the Smart Proxy with the -version command line flag
     Then I should see version info displayed by Smart Proxy on standard output
