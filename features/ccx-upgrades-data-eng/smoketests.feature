Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Scenario: Check if CCX Upgrade Risk Data Engineering Service application is available
    Given the system is in default state
     When I look for executable file uvicorn
     Then I should find that file on PATH

  Scenario: Check if CCX Upgrade Risk Data Engineering Service can be run
    Given The CCX Data Engineering Service is running on port 8000 with envs
          | variable                    | value                         |
          | CLIENT_ID                   | test-client-id                |
          | CLIENT_SECRET               | test-client-secret            |
          | INFERENCE_URL               | http://localhost:8001         |
          | SSO_ISSUER                  | http://localhost:8081/default |
          | ALLOW_INSECURE              | 1                             |
          | RHOBS_URL                   | http://localhost:8002         |
          | OAUTHLIB_INSECURE_TRANSPORT | 1                             |
     When I request the openapi.json endpoint in localhost:8000
     Then The status code of the response is 200
