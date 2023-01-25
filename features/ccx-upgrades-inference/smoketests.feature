Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Scenario: Check if CCX Upgrade Risk Inference Service application is available
    Given the system is in default state
     When I look for executable file uvicorn
     Then I should find that file on PATH

  Scenario: Check if CCX Upgrade Risk Inference Service can be run
    Given The CCX Inference Service is running
     When I request the openapi.json endpoint
     Then The status code of the response is 200
