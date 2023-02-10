Feature: Checking all responses from Insights Results Aggregator Mock service


  Scenario: Check if Insights Results Aggregator Mock service return correct list of organizations
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of organizations
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of organizations
         | Organization |
         | 11789772     |
         | 11940171     |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of groups
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of groups
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of groups
         | Title                | Description                                                                                                                                               | Tags                 |
         | Fault Tolerance      | Load balancer issues, machine api and autoscaler issues, failover issues, nodes down, cluster api/cluster provider issues.                                | fault_tolerance      |
         | Performance          | High utilization, proposed tuned profiles, storage issues                                                                                                 | performance          |
         | Service Availability | Operator degraded, missing functionality due to misconfiguration or resource constraints.                                                                 | service_availability |
         | Security             | Issues related to certificates, user management, security groups, specific port usage, storage permissions, usage of kubeadmin account, exposed keys etc. | security             |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 1
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of clusters for organization 1
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000001-624a-49a5-bab8-4fdc5e51a266 |
         | 00000001-624a-49a5-bab8-4fdc5e51a267 |
         | 00000001-624a-49a5-bab8-4fdc5e51a268 |
         | 00000001-624a-49a5-bab8-4fdc5e51a269 |
         | 00000001-624a-49a5-bab8-4fdc5e51a26a |
         | 00000001-624a-49a5-bab8-4fdc5e51a26b |
         | 00000001-624a-49a5-bab8-4fdc5e51a26c |
         | 00000001-624a-49a5-bab8-4fdc5e51a26d |
         | 00000001-624a-49a5-bab8-4fdc5e51a26e |
         | 00000001-624a-49a5-bab8-4fdc5e51a26f |
         | 00000001-6577-4e80-85e7-697cb646ff37 |
         | 00000001-8933-4a3a-8634-3328fe806e08 |
         | 00000001-8d6a-43cc-b82c-7007664bdf69 |
         | 00000001-eeee-eeee-eeee-000000000001 |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 2
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of clusters for organization 2
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000002-624a-49a5-bab8-4fdc5e51a266 |
         | 00000002-6577-4e80-85e7-697cb646ff37 |
         | 00000002-8933-4a3a-8634-3328fe806e08 |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization 3
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of clusters for organization 3
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 00000003-8933-4a3a-8634-3328fe806e08 |
         | 00000003-8d6a-43cc-b82c-7007664bdf69 |
         | 00000003-eeee-eeee-eeee-000000000001 |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization with many clusters
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of clusters for organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
         | Cluster name                         |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a266 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a267 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a268 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a269 |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26a |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26b |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26c |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26d |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26e |
         | 34c3ecc5-624a-49a5-bab8-4fdc5e51a26f |
         | 74ae54aa-6577-4e80-85e7-697cb646ff37 |
         | a7467445-8d6a-43cc-b82c-7007664bdf69 |
         | ee7d2bf4-8933-4a3a-8634-3328fe806e08 |
         | eeeeeeee-eeee-eeee-eeee-000000000001 |


  Scenario: Check if Insights Results Aggregator Mock service return correct list of clusters for organization w/o access rights
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request list of clusters for organization 11940171
     Then The status code of the response is 403
      And The status message of the response is "You have no permissions to get or change info about this organization"


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits
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


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits
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


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with one rule hit
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


  Scenario: Check if Insights Results Aggregator Mock service return correct cluster report with no rule hits
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I request report for cluster eeeeeeee-eeee-eeee-eeee-000000000001 from organization 11789772
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The report should not contain any rule hit
