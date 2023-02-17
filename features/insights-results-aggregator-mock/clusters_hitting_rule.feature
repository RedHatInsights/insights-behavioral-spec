Feature: Checking REST API endpoint that returns list of clusters hitting specified rule



  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check
    Given the system is in default state
     When I request list of clusters hitting rule with name ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check and error key AUTH_OPERATOR_PROXY_ERROR
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value                                                   |
         | count          | 2                                                                 |
         | component      | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check.report |
         | error_key      | AUTH_OPERATOR_PROXY_ERROR                                         |
      And I should retrieve following list of clusters stored in attribute data
         | Cluster name                         |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-3333-3333-3333-000000000000 |



  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns correct list of clusters for rule minimum requirements
    Given the system is in default state
     When I request list of clusters hitting rule with name ccx_rules_ocp.external.rules.nodes_requirements_check and error key NODES_MINIMUM_REQUIREMENTS_NOT_MET
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value                                              |
         | count          | 24                                                           |
         | component      | ccx_rules_ocp.external.rules.nodes_requirements_check.report |
         | error_key      | NODES_MINIMUM_REQUIREMENTS_NOT_MET                           |
      And I should retrieve following list of clusters stored in attribute data
         | Cluster name                         |
         | 00000001-624a-49a5-bab8-4fdc5e51a266 |
         | 00000001-6577-4e80-85e7-697cb646ff37 |
         | 00000001-8933-4a3a-8634-3328fe806e08 |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-0000-0000-0000-000000000000 |
         | 00000001-1111-1111-1111-000000000000 |
         | 00000001-2222-2222-2222-000000000000 |
         | 00000001-3333-3333-3333-000000000000 |
         | 00000001-4444-4444-4444-000000000000 |
         | 00000001-5555-5555-5555-000000000000 |
         | 00000001-6666-6666-6666-000000000000 |
         | 00000001-7777-7777-7777-000000000000 |
         | 00000001-8888-8888-8888-000000000000 |
         | 00000001-9999-9999-9999-000000000000 |
         | 00000001-aaaa-aaaa-aaaa-000000000000 |
         | 00000001-bbbb-bbbb-bbbb-000000000000 |
         | 00000001-cccc-cccc-cccc-000000000000 |
         | 00000001-dddd-dddd-dddd-000000000000 |
         | 00000001-ffff-ffff-ffff-000000000000 |
         | 00000001-ffff-ffff-ffff-000000000000 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |



  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.bug_rules.bug_1766907
    Given the system is in default state
     When I request list of clusters hitting rule with name ccx_rules_ocp.external.bug_rules.bug_1766907 and error key BUGZILLA_BUG_1766907
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value                                     |
         | count          | 12                                                  |
         | component      | ccx_rules_ocp.external.bug_rules.bug_1766907.report |
         | error_key      | BUGZILLA_BUG_1766907                                |
      And I should retrieve following list of clusters stored in attribute data
         | Cluster name                         |
         | 00000001-6577-4e80-85e7-697cb646ff37 |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-1111-1111-1111-000000000000 |
         | 00000001-3333-3333-3333-000000000000 |
         | 00000001-5555-5555-5555-000000000000 |
         | 00000001-7777-7777-7777-000000000000 |
         | 00000001-9999-9999-9999-000000000000 |
         | 00000001-bbbb-bbbb-bbbb-000000000000 |
         | 00000001-dddd-dddd-dddd-000000000000 |
         | 00000001-ffff-ffff-ffff-000000000000 |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |



  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.nodes_kubelet_version_check
    Given the system is in default state
     When I request list of clusters hitting rule with name ccx_rules_ocp.external.rules.nodes_kubelet_version_check and error key NODE_KUBELET_VERSION
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value                                                 |
         | count          | 6                                                               |
         | component      | ccx_rules_ocp.external.rules.nodes_kubelet_version_check.report |
         | error_key      | NODE_KUBELET_VERSION                                            |
      And I should retrieve following list of clusters stored in attribute data
         | Cluster name                         |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-3333-3333-3333-000000000000 |
         | 00000001-7777-7777-7777-000000000000 |
         | 00000001-bbbb-bbbb-bbbb-000000000000 |
         | 00000001-ffff-ffff-ffff-000000000000 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |



  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.samples_op_failed_image_import_check
    Given the system is in default state
     When I request list of clusters hitting rule with name ccx_rules_ocp.external.rules.samples_op_failed_image_import_check and error key SAMPLES_FAILED_IMAGE_IMPORT_ERR
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value                                                          |
         | count          | 3                                                                        |
         | component      | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check.report |
         | error_key      | SAMPLES_FAILED_IMAGE_IMPORT_ERR                                          |
      And I should retrieve following list of clusters stored in attribute data
         | Cluster name                         |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-3333-3333-3333-000000000000 |
         | 00000001-7777-7777-7777-000000000000 |
