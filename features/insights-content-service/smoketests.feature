@insights_content_service

Feature: Basic set of smoke tests

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1/

  Scenario: Check if /groups endpoint is working
    When I access endpoint /groups using HTTP GET method
    Then The status message of the response is "ok"
     And The status code of the response is 200
     And The body of the response contains groups

  Scenario: Check if /content endpoint is working
    When I access endpoint /content using HTTP GET method
    Then The status code of the response is 200
     And The body of the response contains RuleContentDirectory

  Scenario: Check if /metrics endpoint is working
    When I access endpoint /metrics using HTTP GET method
    Then The status code of the response is 200
     And The body of the response contains go_gc_duration_seconds
     And The body of the response contains go_memstats_gc_sys_bytes
     And The body of the response contains insights_content_service_api_endpoints_requests

  Scenario: Check if /status endpoint is working
    When I access endpoint /status using HTTP GET method
    Then The status message of the response is "ok"
     And The status code of the response is 200
     And The body of the response contains rules

  Scenario: Check if /info endpoint is working
    When I access endpoint /info using HTTP GET method
    Then The status message of the response is "ok"
     And The status code of the response is 200
     And The body of the response contains BuildBranch
     And The body of the response contains BuildCommit
     And The body of the response contains OCPRulesVersion
