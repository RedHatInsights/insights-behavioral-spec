@insights_content_template_renderer

Feature: Test the batch render endpoint /v2/rendered_reports

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8010
      And REST API service prefix is /v2/
      And The Template Renderer is running

  @rest-api
  Scenario: check /v2/rendered_reports endpoint response with a valid batch request
    When I access endpoint rendered_reports using HTTP POST method
    """
    {
      "items": [
        {
          "templates": {
            "reason": "Workload {{=pydata.name}} has a finding",
            "resolution": "Apply the resolution to {{=pydata.name}}",
            "more_info": ""
          },
          "data": {"name": "test-app"}
        },
        {
          "templates": {
            "reason": "Reason for {{=pydata.missing.value()}}"
          },
          "data": {"name": "test-app"}
        }
      ]
    }
    """
    Then The status code of the response is 200
     And The response contains 2 items
     And The rendered field "reason" of item 0 is "Workload test-app has a finding"
     And The rendered field "resolution" of item 0 is "Apply the resolution to test-app"
     And The item 0 has no errors
     And The item 0 does not contain rendered field "more_info"
     And The item 1 does not contain rendered field "reason"
     And The item 1 has an error for field "reason" containing "pydata.missing"
     And The error message for field "reason" of item 1 does not contain "Traceback"
     And The error message for field "reason" of item 1 does not contain "Stack Trace"

  @rest-api
  Scenario: check /v2/rendered_reports endpoint response with an empty list of items
    When I access endpoint rendered_reports using HTTP POST method
    """
    {
      "items": []
    }
    """
    Then The status code of the response is 200
     And The body of the response is the following
    """
    {
      "items": []
    }
    """

  @rest-api
  Scenario: check /v2/rendered_reports preserves the order of items
    When I access endpoint rendered_reports using HTTP POST method
    """
    {
      "items": [
        {
          "templates": {"reason": "First {{=pydata.id}}"},
          "data": {"id": "one"}
        },
        {
          "templates": {"reason": "Second {{=pydata.id}}"},
          "data": {"id": "two"}
        },
        {
          "templates": {"reason": "Third {{=pydata.id}}"},
          "data": {"id": "three"}
        }
      ]
    }
    """
    Then The status code of the response is 200
     And The response contains 3 items
     And The rendered field "reason" of item 0 is "First one"
     And The rendered field "reason" of item 1 is "Second two"
     And The rendered field "reason" of item 2 is "Third three"

  @rest-api
  Scenario: check /v2/rendered_reports endpoint rejects HTTP GET method
    When I access endpoint rendered_reports using HTTP GET method
    Then The status code of the response is 405

  @rest-api
  Scenario: check /v2/rendered_reports endpoint rejects a request without body
    When I access endpoint rendered_reports using HTTP POST method
    """
    {}
    """
    Then The status code of the response is 422
