Feature: Checking responses from Insights Results Aggregator Mock service: endpoint to return cluster report



  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits without org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster 34c3ecc5-624a-49a5-bab8-4fdc5e51a266
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain 7 rule hits
      And I should find following rule hits in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocp.external.rules.node_installer_degraded              | NODE_INSTALLER_DEGRADED            | 3          | 0              |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |
          | rule | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1821905                      | BUGZILLA_BUG_1821905               | 3          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits without org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster 74ae54aa-6577-4e80-85e7-697cb646ff37
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain 7 rule hits
      And I should find following rule hits in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocp.external.rules.node_installer_degraded              | NODE_INSTALLER_DEGRADED            | 3          | 0              |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |
          | rule | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1821905                      | BUGZILLA_BUG_1821905               | 3          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with one rule hit without org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster ee7d2bf4-8933-4a3a-8634-3328fe806e08
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain one rule hit
      And I should find following rule hit in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with no rule hits without org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster eeeeeeee-eeee-eeee-eeee-000000000001
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should not contain any rule hit


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits with org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 from organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain 7 rule hits
      And I should find following rule hits in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocp.external.rules.node_installer_degraded              | NODE_INSTALLER_DEGRADED            | 3          | 0              |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |
          | rule | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1821905                      | BUGZILLA_BUG_1821905               | 3          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits with org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster 74ae54aa-6577-4e80-85e7-697cb646ff37 from organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain 7 rule hits
      And I should find following rule hits in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocp.external.rules.node_installer_degraded              | NODE_INSTALLER_DEGRADED            | 3          | 0              |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |
          | rule | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | 2          | 0              |
          | rule | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | 2          | 0              |
          | rule | ccx_rules_ocp.external.bug_rules.bug_1821905                      | BUGZILLA_BUG_1821905               | 3          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with one rule hit with org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster ee7d2bf4-8933-4a3a-8634-3328fe806e08 from organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should contain one rule hit
      And I should find following rule hit in cluster report
          | Type | Rule ID                                                           | Error key                          | Total risk | Risk of change |
          | rule | ccx_rules_ocm.tutorial_rule                                       | TUTORIAL_ERROR                     | 1          | 0              |


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with no rule hits with org. selector
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster eeeeeeee-eeee-eeee-eeee-000000000001 from organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should not contain any rule hit
