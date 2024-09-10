@dvo_writer

Feature: DVO writer


  Background:
    Given Kafka broker is started on host and port specified in DVO writer configuration
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And aggregator database is in initial state
     When database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number for DVO from database
     Then I should see that migration #2 is returned
    Given DVO writer service is started in background


  Scenario: DVO writer does not process invalid message
    Given there are 0 rows in DVO table
     When I send the following message into Kafka topic "ccx.dvo.results"
          """
          {}
          """
      And I wait 3 seconds
     Then there are 0 rows in DVO table
     When I terminate DVO writer
     Then DVO writer process should terminate


  Scenario: DVO writer processes incoming data correctly
    Given there are 0 rows in DVO table
     When I send the following message into Kafka topic "ccx.dvo.results"
          """
          {
            "OrgID": 1,
            "AccountNumber": 1,
            "ClusterName": "ac91137f-fa4c-455a-b801-e2b3c1a0d82f",
            "Metrics": {
              "system": {
                "metadata": {},
                "hostname": null
              },
              "fingerprints": [],
              "version": 1,
              "analysis_metadata": {},
              "workload_recommendations": [
                {
                  "response_id": "recommendation|RECOMMENDATION_KEY",
                  "component": "rules.recommendation",
                  "key": "RECOMMENDATION_KEY",
                  "details": {},
                  "tags": [],
                  "links": {
                    "jira": [
                      "https://issues.redhat.com/browse/ISSUE-1111"
                    ],
                    "product_documentation": [
                      "https://docs.com/policy.html"
                    ]
                  },
                  "workloads": [
                    {
                      "namespace": "namespace-name-A",
                      "namespace_uid": "NAMESPACE-UID-A",
                      "kind": "DaemonSet",
                      "name": "test-name-0099",
                      "uid": "UID-0099"
                    },
                    {
                      "namespace": "namespace-name-B",
                      "namespace_uid": "NAMESPACE-UID-B",
                      "kind": "Deployment",
                      "name": "test-name-0007",
                      "uid": "UID-0007"
                    }
                  ]
                }
              ]
            },
            "LastChecked": "2024-02-06T12:25:07.418761+00:00",
            "RequestId": "b0daf40cdf29/U3XGuBBKy9-000003"
          }
          """
      And I wait 3 seconds
     Then there are 2 rows in DVO table
      And DVO table contains the following data
        | Organization | Cluster ID                           | Namespace ID    | Namespace        | Last checked               |
        | 1            | ac91137f-fa4c-455a-b801-e2b3c1a0d82f | NAMESPACE-UID-A | namespace-name-A | 2024-02-06T12:25:07.418761 |
        | 1            | ac91137f-fa4c-455a-b801-e2b3c1a0d82f | NAMESPACE-UID-B | namespace-name-B | 2024-02-06T12:25:07.418761 |
     When I terminate DVO writer
     Then DVO writer process should terminate


  Scenario: DVO writer deletes namespaces not present in the report for given cluster
    Given there are 0 rows in DVO table
     When I send the following message into Kafka topic "ccx.dvo.results"
          """
          {
            "OrgID": 1,
            "AccountNumber": 1,
            "ClusterName": "ac91137f-fa4c-455a-b801-e2b3c1a0d82f",
            "Metrics": {
              "system": {
                "metadata": {},
                "hostname": null
              },
              "fingerprints": [],
              "version": 1,
              "analysis_metadata": {},
              "workload_recommendations": [
                {
                  "response_id": "recommendation|RECOMMENDATION_KEY",
                  "component": "rules.recommendation",
                  "key": "RECOMMENDATION_KEY",
                  "details": {},
                  "tags": [],
                  "links": {
                    "jira": [
                      "https://issues.redhat.com/browse/ISSUE-1111"
                    ],
                    "product_documentation": [
                      "https://docs.com/policy.html"
                    ]
                  },
                  "workloads": [
                    {
                      "namespace": "namespace-name-A",
                      "namespace_uid": "NAMESPACE-UID-A",
                      "kind": "DaemonSet",
                      "name": "test-name-0099",
                      "uid": "UID-0099"
                    },
                    {
                      "namespace": "namespace-name-B",
                      "namespace_uid": "NAMESPACE-UID-B",
                      "kind": "Deployment",
                      "name": "test-name-0007",
                      "uid": "UID-0007"
                    }
                  ]
                }
              ]
            },
            "LastChecked": "2024-02-06T12:25:07.418761+00:00",
            "RequestId": "b0daf40cdf29/U3XGuBBKy9-000003"
          }
          """
      And I wait 3 seconds
     Then there are 2 rows in DVO table
      And DVO table contains the following data
        | Organization | Cluster ID                           | Namespace ID    | Namespace        | Last checked               |
        | 1            | ac91137f-fa4c-455a-b801-e2b3c1a0d82f | NAMESPACE-UID-A | namespace-name-A | 2024-02-06T12:25:07.418761 |
        | 1            | ac91137f-fa4c-455a-b801-e2b3c1a0d82f | NAMESPACE-UID-B | namespace-name-B | 2024-02-06T12:25:07.418761 |
     When I send the following message into Kafka topic "ccx.dvo.results"
          """
          {
            "OrgID": 1,
            "AccountNumber": 1,
            "ClusterName": "ac91137f-fa4c-455a-b801-e2b3c1a0d82f",
            "Metrics": {
              "system": {
                "metadata": {},
                "hostname": null
              },
              "fingerprints": [],
              "version": 1,
              "analysis_metadata": {},
              "workload_recommendations": [
                {
                  "response_id": "recommendation|RECOMMENDATION_KEY",
                  "component": "rules.recommendation",
                  "key": "RECOMMENDATION_KEY",
                  "details": {},
                  "tags": [],
                  "links": {
                    "jira": [
                      "https://issues.redhat.com/browse/ISSUE-1111"
                    ],
                    "product_documentation": [
                      "https://docs.com/policy.html"
                    ]
                  },
                  "workloads": [
                    {
                      "namespace": "namespace-name-A",
                      "namespace_uid": "NAMESPACE-UID-A",
                      "kind": "DaemonSet",
                      "name": "test-name-0099",
                      "uid": "UID-0099"
                    }
                  ]
                }
              ]
            },
            "LastChecked": "2024-02-06T12:35:07.418761+00:00",
            "RequestId": "b0daf40cdf29/U3XGuBBKy9-000004"
          }
          """
      And I wait 3 seconds
     Then there is 1 row in DVO table
      And DVO table contains the following data
        | Organization | Cluster ID                           | Namespace ID    | Namespace        | Last checked               |
        | 1            | ac91137f-fa4c-455a-b801-e2b3c1a0d82f | NAMESPACE-UID-A | namespace-name-A | 2024-02-06T12:35:07.418761 |
     When I terminate DVO writer
     Then DVO writer process should terminate
