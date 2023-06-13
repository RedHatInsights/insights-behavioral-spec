Feature: Upgrade Risks Prediction Data Engineering - test correct behavior of the LRU cache mechanism

  # You have to add 127.0.0.1   localhost mock-oauth2-server
  # to your /etc/hosts. This is needed to run these tests in Gitlab CI.

  Background: Data eng service is running and well configured to work
    Given The mock CCX Inference Service is running on port 9090
    And The mock RHOBS Service is running on port 9091


  Scenario: Check that nothing is cached if CACHE_ENABLED is set to 0
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 0                                      |
      | CACHE_TTL                   | 10                                     |
      | CACHE_SIZE                  | 10                                     |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check that nothing is cached if CACHE_TTL is set to 0
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 0                                      |
      | CACHE_SIZE                  | 10                                     |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check that nothing is cached if CACHE_SIZE is set to 0
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 10                                     |
      | CACHE_SIZE                  | 0                                      |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check Data Engineering Service response with a valid cluster ID is properly cached
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 60                                     |
      | CACHE_SIZE                  | 10                                     |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    And I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check maximum size of cache
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 60                                     |
      | CACHE_SIZE                  | 3                                      |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-000000000000/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-000000000000 for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path 44444444-3333-2222-1111-111111111111/upgrade-risks-prediction
    And I store the response for 44444444-3333-2222-1111-111111111111 for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    And I store the response for 00000000-1111-2222-3333-444444444444 for comparison
    Then The status code of the response is 404
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    And I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-000000000000/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for aaaaaaaa-bbbb-cccc-dddd-000000000000
    When I request the cluster endpoint in localhost:8000 with path 44444444-3333-2222-1111-111111111111/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for 44444444-3333-2222-1111-111111111111
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    Then The status code of the response is 404
    And The response is identical to the previous response for 00000000-1111-2222-3333-444444444444
    # Item for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee is not in the cache anymore, so this fails as RHOBS / inference are not available
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check LRU eviction of items if maximum size is reached
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 60                                     |
      | CACHE_SIZE                  | 3                                      |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-000000000000/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-000000000000 for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path 44444444-3333-2222-1111-111111111111/upgrade-risks-prediction
    And I store the response for 44444444-3333-2222-1111-111111111111 for comparison
    Then The status code of the response is 200
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    And I store the response for 00000000-1111-2222-3333-444444444444 for comparison
    Then The status code of the response is 404
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    And I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-000000000000/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for aaaaaaaa-bbbb-cccc-dddd-000000000000
    When I request the cluster endpoint in localhost:8000 with path 44444444-3333-2222-1111-111111111111/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for 44444444-3333-2222-1111-111111111111
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    Then The status code of the response is 404
    And The response is identical to the previous response for 00000000-1111-2222-3333-444444444444
    # Item for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee is not in the cache anymore, so this fails as RHOBS / inference are not available
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee


  Scenario: Check that entries are evicted properly when TTL expires
    Given The CCX Data Engineering Service is running on port 8000 with envs
      | variable                    | value                                  |
      | CLIENT_ID                   | test-client-id                         |
      | CLIENT_SECRET               | test-client-secret                     |
      | INFERENCE_URL               | http://localhost:9090                  |
      | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
      | ALLOW_INSECURE              | 1                                      |
      | RHOBS_URL                   | http://localhost:9091                  |
      | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |
      | CACHE_ENABLED               | 1                                      |
      | CACHE_TTL                   | 5                                      |
      | CACHE_SIZE                  | 50                                     |
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    And I store the response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee for comparison
    When I wait 4 seconds
     And I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 200
    And The response is identical to the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    And I store the response for 00000000-1111-2222-3333-444444444444 for comparison
    Then The status code of the response is 404
    When I stop the mock CCX Inference Service
    And I stop the mock RHOBS Service
    And I wait 1 seconds
    # cached results for 00000000-1111-2222-3333-444444444444 are still in the cache
    When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
    Then The status code of the response is 404
    And The response is identical to the previous response for 00000000-1111-2222-3333-444444444444
    # cached results for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee were evicted after 5 seconds
    When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
    Then The status code of the response is 500
    And The response is different from the previous response for aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
