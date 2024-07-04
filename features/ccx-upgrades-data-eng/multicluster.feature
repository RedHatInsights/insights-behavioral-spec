Feature: Upgrade Risks Prediction Data Engineering - test well known values

  # You have to add 127.0.0.1   localhost mock-oauth2-server
  # to your /etc/hosts. This is needed to run these tests in Gitlab CI.

  Background: Data eng service is running and well configured to work
    Given The CCX Data Engineering Service is running on port 8000 with envs
          | variable                    | value                                  |
          | CLIENT_ID                   | test-client-id                         |
          | CLIENT_SECRET               | test-client-secret                     |
          | INFERENCE_URL               | http://localhost:8001                  |
          | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
          | ALLOW_INSECURE              | 1                                      |
          | RHOBS_URL                   | http://localhost:8002                  |
          | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |

  Scenario: Check Data Engineering Service response with a valid list of cluster ID
     When I request the upgrade-risk-prediction endpoint in localhost:8000 using POST with a list of clusters
          | cluster                              |
          | not-an-uuid                          |
          | aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee |
          | 44444444-3333-2222-1111-111111111111 |
     Then The prediction_status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "type": "object",
            "required": [
              "predictions"
            ],
            "properties": {
              "predictions": {
                "type": "array",
                "items": [
                  {
                    "type": "object",
                    "required": [
                      "cluster_id"
                    ]
                    "properties": {
                      "cluster_id": {
                        "type": "string"
                      },
                      "prediction_status": {
                        "type": "string",
                      }
                      "upgrade_recommended": {
                        "type": "boolean"
                      },
                      "upgrade_risks_predictors": {
                        "type": "object",
                        "properties": {
                          "alerts": {
                            "type": "array",
                            "items": [
                              {
                                "type": "object",
                                "properties": {
                                  "name": {
                                    "type": "string"
                                  },
                                  "namespace": {
                                    "type": "string"
                                  },
                                  "severity": {
                                    "type": "string"
                                  },
                                  "url": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "name",
                                  "namespace",
                                  "severity",
                                  "url"
                                ]
                              }
                            ]
                          },
                          "operator_conditions": {
                            "type": "array",
                            "items": [
                              {
                                "type": "object",
                                "properties": {
                                  "name": {
                                    "type": "string"
                                  },
                                  "condition": {
                                    "type": "string"
                                  },
                                  "reason": {
                                    "type": "string"
                                  },
                                  "url": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "name",
                                  "condition",
                                  "reason",
                                  "url"
                                ]
                              }
                            ]
                          }
                        },
                        "required": [
                          "alerts",
                          "operator_conditions"
                        ]
                      },
                      "last_checked_at": {
                        "type": "string"
                      }
                    }
                  }
                ]
              }
            }
          }
          """
      And The body of the response, ignoring the "last_checked_at" field, is the following
          """
          {
              "predictions": [
                  {
                      "cluster_id": "not-an-uuid",
                      "prediction_status": "invalid UUID"
                  },
                  {
                      "cluster_id": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
                      "prediction_status": "ok",
                      "upgrade_recommended": false,
                      "upgrade_risks_predictors": {
                      "alerts": [
                          {
                              "name": "SomeCriticalAlert",
                              "namespace": "openshift-kube-apiserver",
                              "severity": "critical",
                              "url": "https://some_url.com/monitoring/alerts?orderBy=asc&sortBy=Severity&alert-name=SomeCriticalAlert"
                          }
                      ],
                      "operator_conditions": [
                          {
                              "name": "authentication",
                              "condition": "Degraded",
                              "reason": "AsExpected",
                              "url": "https://some_url.com/k8s/cluster/config.openshift.io~v1~ClusterOperator/authentication"
                          }
                      ]
                      },
                      "last_checked_at": "2011-11-04T00:05:23Z"
                  },
                  {
                      "cluster_id": "44444444-3333-2222-1111-111111111111",
                      "prediction_status": "ok",
                      "upgrade_recommended": false,
                      "upgrade_risks_predictors": {
                      "alerts": [
                          {
                              "name": "SomeCriticalAlert",
                              "namespace": "openshift-kube-apiserver",
                              "severity": "critical",
                              "url": "https://some_url.com/monitoring/alerts?orderBy=asc&sortBy=Severity&alert-name=SomeCriticalAlert"
                          }
                      ],
                      "operator_conditions": [
                          {
                              "name": "authentication",
                              "condition": "Degraded",
                              "reason": "AsExpected",
                              "url": "https://some_url.com/k8s/cluster/config.openshift.io~v1~ClusterOperator/authentication"
                          }
                      ]
                      },
                      "last_checked_at": "2011-15-04T00:05:23Z"
                  }
              ]
          }
          """
