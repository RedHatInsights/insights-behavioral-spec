Feature: Reading acked rules, acking new rule and acking existing rule


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v2


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


  @rest-api @database-write
  Scenario: Check if it is possible to ack new rule
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
     When I ack rule with ID "foo" and error key "bar" with justification "this is justification message"
     Then The status code of the response is 201
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | this is justification message | onlineTester |


  @rest-api @database-write
  Scenario: Check if it is possible to delete acknowledgement
    Given the system is in default state
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification  | Created by |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3 | tester3    |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4 | tester4    |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5 | tester5    |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1 | tester1    |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2 | tester2    |
         | foo                                                               | bar                                | this is justification message | onlineTester |
     When I delete ack for rule with ID "foo" and error key "bar"
     Then The status code of the response is 204
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 5               |
      And I should retrieve list of 5 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |


  @rest-api @database-write
  Scenario: Check if it is possible to ack already acked rule w/o changing the internal state of the service
    Given the system is in default state
     When I ack rule with ID "foo" and error key "bar" with justification "this is justification message"
     Then The status code of the response is 201
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification  | Created by |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3 | tester3    |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4 | tester4    |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5 | tester5    |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1 | tester1    |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2 | tester2    |
         | foo                                                               | bar                                | this is justification message | onlineTester |
     When I ack rule with ID "foo" and error key "bar" with justification "this is justification message"
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | this is justification message | onlineTester |
     When I delete ack for rule with ID "foo" and error key "bar"
     Then The status code of the response is 204


  @rest-api @database-write
  Scenario: Check the behaviour when ACK for non existing rule is to be deleted
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
     When I delete ack for rule with ID "this" and error key "doesnotexist"
     Then The status code of the response is 404


  @rest-api @database-write
  Scenario: Check if it is possible to ack new rule without providing justification
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
     When I ack rule with ID "foo" and error key "bar" without justification
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | ?                             | onlineTester |
     When I delete ack for rule with ID "foo" and error key "bar"
     Then The status code of the response is 204


  @rest-api @database-write
  Scenario: Check if it is possible to ack already acked rule without providing justification
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
     When I ack rule with ID "foo" and error key "bar" without justification
     Then The status code of the response is 200
     When I ack rule with ID "foo" and error key "bar" without justification
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | ?                             | onlineTester |
     When I delete ack for rule with ID "foo" and error key "bar"
     Then The status code of the response is 204


  @rest-api @database-write
  Scenario: Check if it is possible to change justification text of already acked rule
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
     When I ack rule with ID "foo" and error key "bar" without justification
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | ?                             | onlineTester |
     When I change justification text for rule with ID "foo" and error key "bar" to "new justification"
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | foo                                                               | bar                                | new justification             | onlineTester |
     When I delete ack for rule with ID "foo" and error key "bar"
     Then The status code of the response is 204


  @rest-api @database-write
  Scenario: Check the behaviour when acked rule to be changed does not exist
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
     When I ack rule with ID "this" and error key "doesnotexist" without justification
     Then The status code of the response is 200
     When I ask for list of all acked rules
     Then The status code of the response is 200
      And The metadata should contain following attributes
         | Attribute name | Attribute value |
         | count          | 6               |
      And I should retrieve list of 6 acked rules
      And I should retrieve following list of acked rules
         | Rule ID                                                           | Error key                          | Justification                 | Created by   |
         | ccx_rules_ocp.external.rules.nodes_kubelet_version_check          | NODE_KUBELET_VERSION               | Justification3                | tester3      |
         | ccx_rules_ocp.external.rules.samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    | Justification4                | tester4      |
         | ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          | Justification5                | tester5      |
         | ccx_rules_ocp.external.rules.nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET | Justification1                | tester1      |
         | ccx_rules_ocp.external.bug_rules.bug_1766907                      | BUGZILLA_BUG_1766907               | Justification2                | tester2      |
         | this                                                              | doesnotexist                       | ?                             | onlineTester |
     When I delete ack for rule with ID "this" and error key "doesnotexist"
     Then The status code of the response is 204
