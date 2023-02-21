Feature: Reading acked rules, acking new rule and acking existing rule


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns list of acked rules
    Given the system is in default state
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 5               |
      And I should retrieve list of 5 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification  | Created by |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3 | tester3    |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4 | tester4    |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5 | tester5    |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1 | tester1    |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2 | tester2    |
