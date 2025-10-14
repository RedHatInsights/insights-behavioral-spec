@aggregator
Feature: Consuming and processing results from Kafka broker


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And aggregator database is in initial state
      And Kafka broker is available
      And Kafka topic "ccx.ocp.results" is empty
     When database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number from database
     Then I should see that migration #31 is returned
    Given Insights Results Aggregator service is started in background
     When I wait 5 seconds


  @managed
  Scenario: Check if Insights Results Aggregator is able to consume messages and store results into database
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check if Insights Results Aggregator is able to consume messages and store results into database for multiple results
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
      And I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check if Insights Results Aggregator is able to consume messages and store results into database for multiple clusters
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
      And I send rules results '05_rules_hits_different_cluster.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
        | ffffffff-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes messages and stores results into database
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 1 rule hit for cluster 01234567-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster 01234567-89ab-cdef-0123-456789abcdef
          | Type | Rule ID       | Error key      |
          | rule | tutorial_rule | TUTORIAL_ERROR |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes message and stores results into database for multiple results
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 5 rule hits for cluster 01234567-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster 01234567-89ab-cdef-0123-456789abcdef
          | Type | Rule ID                              | Error key                          |
          | rule | nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET |
          | rule | bug_1766907                          | BUGZILLA_BUG_1766907               |
          | rule | nodes_kubelet_version_check          | NODE_KUBELET_VERSION               |
          | rule | samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    |
          | rule | cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes two messages when the second is older then the first one
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 1 rule hit for cluster 01234567-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster 01234567-89ab-cdef-0123-456789abcdef
          | Type | Rule ID       | Error key      |
          | rule | tutorial_rule | TUTORIAL_ERROR |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes two messages when the second is newer then the first one
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 1 rule hit for cluster 01234567-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster 01234567-89ab-cdef-0123-456789abcdef
          | Type | Rule ID       | Error key      |
          | rule | tutorial_rule | TUTORIAL_ERROR |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes message and stores results into database for multiple clusters
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results '05_rules_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I send rules results '05_rules_hits_different_cluster.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
        | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 5 rule hits for cluster 01234567-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster 01234567-89ab-cdef-0123-456789abcdef
          | Type | Rule ID                              | Error key                          |
          | rule | nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET |
          | rule | bug_1766907                          | BUGZILLA_BUG_1766907               |
          | rule | nodes_kubelet_version_check          | NODE_KUBELET_VERSION               |
          | rule | samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    |
          | rule | cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          |
     When I access endpoint /organizations/123/clusters/ffffffff-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 5 rule hits for cluster ffffffff-89ab-cdef-0123-456789abcdef
      And I should find following rule hits in returned cluster report for cluster ffffffff-89ab-cdef-0123-456789abcdef
          | Type | Rule ID                              | Error key                          |
          | rule | nodes_requirements_check             | NODES_MINIMUM_REQUIREMENTS_NOT_MET |
          | rule | bug_1766907                          | BUGZILLA_BUG_1766907               |
          | rule | nodes_kubelet_version_check          | NODE_KUBELET_VERSION               |
          | rule | samples_op_failed_image_import_check | SAMPLES_FAILED_IMAGE_IMPORT_ERR    |
          | rule | cluster_wide_proxy_auth_check        | AUTH_OPERATOR_PROXY_ERROR          |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: Check rule hits after Insights Results Aggregator consumes message with no results
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'no_hits.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 0 rule hits for cluster 01234567-89ab-cdef-0123-456789abcdef
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate

   @managed
   Scenario: Check additions into the database when a message with empty fields is received
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'no_values.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should contain 0 rule hits for cluster 01234567-89ab-cdef-0123-456789abcdef
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate

   @managed
   Scenario: Check no additions into the database when an incomplete message is received
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I send rules results 'rule_message_some_empty_fields.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I access endpoint /organizations/123/clusters/01234567-89ab-cdef-0123-456789abcdef/reports using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And The returned report should not contain report for cluster 01234567-89ab-cdef-0123-456789abcdef
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @managed
  Scenario: DB Writer automatically updates OrgID when receiving message with different OrgID for existing cluster
     When I send rules results 'tutorial_only.json' into topic 'ccx.ocp.results'
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I send the following message into Kafka topic "ccx.ocp.results"
          """
          {
            "OrgID": 456,
            "ClusterName": "01234567-89ab-cdef-0123-456789abcdef",
            "Report": {
              "system": {
                "metadata": {},
                "hostname": null
              },
              "fingerprints": [],
              "version": 1,
              "analysis_metadata": {},
              "reports": [
                {
                  "rule_id": "tutorial_rule|TUTORIAL_ERROR",
                  "component": "tutorial_rule",
                  "type": "rule",
                  "key": "TUTORIAL_ERROR",
                  "details": {},
                  "tags": [],
                  "links": {}
                }
              ]
            },
            "LastChecked": "2024-01-15T11:00:00Z"
          }
          """
      And I wait 5 seconds
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty list of clusters
     When I access endpoint /organizations/456/clusters using HTTP GET method using token for organization 456 account number 789, and user 123
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve following list of clusters
        | Cluster name                         |
        | 01234567-89ab-cdef-0123-456789abcdef |
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
