@insights_content_template_renderer

Feature: Basic set of smoke tests

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8000
      And REST API service prefix is /
      And The Template Renderer is running

  Scenario: Check if /v1/rendered_reports endpoint is working
    When I access endpoint v1/rendered_reports using HTTP GET method
     Then The status code of the response is 405

  Scenario: Check if /docs endpoint is working
    When I access endpoint docs using HTTP GET method
    Then The status code of the response is 200
     And The body of the response contains swagger

  Scenario: Check if /metrics endpoint is working
    When I access endpoint metrics using HTTP GET method
    Then The status code of the response is 200
     And The body of the response contains http_request_duration