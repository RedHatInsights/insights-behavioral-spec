@insights_content_template_renderer

Feature: Test the service endpoints

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8000
      And REST API service prefix is /v1/
      And The Template Renderer is running

    @rest-api @json-schema-check
    Scenario: check /v1/rendered_reports endpoint response
        When I access endpoint rendered_reports using HTTP POST method
        """
        {
          "content": [
            {
              "plugin": {
                "name": "",
                "node_id": "",
                "product_code": "",
                "python_module": "ccx_rules_ocp.external.rules.1"
              },
              "error_keys": {
                "RULE_1": {
                  "metadata": {
                    "description": "{{?pydata.options == 1\n}}Option 1{{?? pydata.options == 2\n}}Option 2{{??\n}}Other option{{?}}:\n\n More text",
                    "impact": 2,
                    "likelihood": 3,
                    "publish_date": "2019-10-29 15:00:00",
                    "status": "active",
                    "tags": [
                      "openshift",
                      "configuration",
                      "performance"
                    ]
                  },
                  "total_risk": 2,
                  "generic": "",
                  "summary": "",
                  "resolution": "This is a test resolution",
                  "more_info": "",
                  "reason": "This is a test",
                  "HasReason": true
                }
              },
              "generic": "",
              "summary": "",
              "resolution": "Red Hat recommends you to fix the issue with {{~ pydata.options :option }}",
              "more_info": "For more information about this, refer to the [Documentation](https://docs.openshift.com)",
              "reason": "Option{{?pydata.options.length>1}}s{{?}} not working",
              "HasReason": true
            }
          ],
          "report_data": {
            "clusters": [
              "5d5892d3-1f74-4ccf-91af-548dfc9767aa"
            ],
            "errors": null,
            "reports": {
              "5d5892d3-1f74-4ccf-91af-548dfc9767aa": {
                "fingerprints": [],
                "info": [],
                "pass": [],
                "reports": [
                  {
                    "rule_id": "1|RULE_1",
                    "component": "ccx_rules_ocp.external.rules.1.report",
                    "type": "rule",
                    "key": "RULE_1",
                    "details": {
                      "options": [
                        {
                          "name": "foo"
                        }
                      ],
                      "link": "https://docs.openshift.com/",
                      "type": "rule",
                      "error_key": "RULE_1"
                    },
                    "tags": [],
                    "links": {
                      "docs": [
                        "https://docs.openshift.com"
                      ]
                    }
                  }
                ],
                "skips": [],
                "system": {
                  "metadata": {},
                  "hostname": null
                }
              }
            },
            "generated_at": "",
            "status": "ok"
          }
        }
        """
        Then The status code of the response is 200
        And The body of the response contains "Other option:\n\n More text"