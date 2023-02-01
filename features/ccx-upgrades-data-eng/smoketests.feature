Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Scenario: Check if CCX Upgrade Risk Data Engineering Service application is available
    Given the system is in default state
     When I look for executable file uvicorn
     Then I should find that file on PATH

  Scenario: Check if CCX Upgrade Risk Data Engineering Service can be run
    Given The CCX Data Engineering Service is running on port 8000
     When I request the openapi.json endpoint in localhost:8000
     Then The status code of the response is 200
