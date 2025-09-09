Feature: Upgrade Risks Prediction Data Engineering - test well known values

  # You have to add 127.0.0.1   localhost mock-oauth2-server
  # to your /etc/hosts. This is needed to run these tests in Gitlab CI.

  Background: Data eng service is running and well configured to work
    Given The mock CCX Inference Service is running on port 9090
      And The mock RHOBS Service is running on port 9091
      And The CCX Data Engineering Service is running on port 8000 with envs
          | variable                    | value                                  |
          | CLIENT_ID                   | test-client-id                         |
          | CLIENT_SECRET               | test-client-secret                     |
          | INFERENCE_URL               | http://localhost:9090                  |
          | SSO_ISSUER                  | http://mock-oauth2-server:8081/default |
          | ALLOW_INSECURE              | 1                                      |
          | RHOBS_URL                   | http://localhost:9091                  |
          | OAUTHLIB_INSECURE_TRANSPORT | 1                                      |

  Scenario: Check Data Engineering Service response with an invalid cluster ID in the request
     When I request the cluster endpoint in localhost:8000 with path not-an-uuid/upgrade-risks-prediction
     Then The status code of the response is 422

  Scenario: Check Data Engineering Service response with a valid cluster ID
     When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/upgrade-risks-prediction
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "required": [
              "upgrade_recommended",
              "upgrade_risks_predictors",
              "last_checked_at"
            ],
            "type": "object",
            "properties": {
              "upgrade_recommended": {
                "title": "Upgrade Recommended",
                "type": "boolean"
              },
              "upgrade_risks_predictors": {
                "title": "Upgrade Risks Predictors",
                "type": "object",
                "properties": {
                  "alerts": {
                    "type": "array",
                    "items": {
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
                        }
                      }
                    }
                  },
                  "operator_conditions": {
                    "type": "array",
                    "items": {
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
                      }
                    }
                  }
                }
              },
              "last_checked_at": {
                "title": "Last checked at",
                "type": "string"
              }
            }
          }
          """
      And The body of the response, ignoring the "last_checked_at" field, is the following
          """
          {
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
              }
          }
          """

  Scenario: Check Data Engineering Service removes duplicates from the response
     # This cluster contains the same alert repeated 3 times
     When I request the cluster endpoint in localhost:8000 with path 44444444-3333-2222-1111-111111111111/upgrade-risks-prediction
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "required": [
              "upgrade_recommended",
              "upgrade_risks_predictors",
              "last_checked_at"
            ],
            "type": "object",
            "properties": {
              "upgrade_recommended": {
                "title": "Upgrade Recommended",
                "type": "boolean"
              },
              "upgrade_risks_predictors": {
                "title": "Upgrade Risks Predictors",
                "type": "object",
                "properties": {
                  "alerts": {
                    "type": "array",
                    "items": {
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
                        }
                      }
                    }
                  },
                  "operator_conditions": {
                    "type": "array",
                    "items": {
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
                      }
                    }
                  }
                }
              },
              "last_checked_at": {
                "title": "Last checked at",
                "type": "string"
              }
            }
          }
          """
      And The body of the response, ignoring the "last_checked_at" field, is the following
          """
          {
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
              }
          }
          """

  Scenario: Check Data Engineering Service maps the FOC condition correctly
     # This cluster contains the same alert repeated 3 times
     When I request the cluster endpoint in localhost:8000 with path aaaaaaaa-bbbb-cccc-dddd-000000000000/upgrade-risks-prediction
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "required": [
              "upgrade_recommended",
              "upgrade_risks_predictors",
              "last_checked_at"
            ],
            "type": "object",
            "properties": {
              "upgrade_recommended": {
                "title": "Upgrade Recommended",
                "type": "boolean"
              },
              "upgrade_risks_predictors": {
                "title": "Upgrade Risks Predictors",
                "type": "object",
                "properties": {
                  "alerts": {
                    "type": "array",
                    "items": {
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
                        }
                      }
                    }
                  },
                  "operator_conditions": {
                    "type": "array",
                    "items": {
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
                      }
                    }
                  }
                }
              },
              "last_checked_at": {
                "title": "Last checked at",
                "type": "string"
              }
            }
          }
          """
      And The body of the response, ignoring the "last_checked_at" field, is the following
          """
          {
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
                        "condition": "Not Available",
                        "reason": "AsExpected",
                        "url": "https://some_url.com/k8s/cluster/config.openshift.io~v1~ClusterOperator/authentication"
                    }
                ]
              }
          }
          """

  Scenario: Check Data Engineering Service response with a valid cluster ID but no cluster version
     When I request the cluster endpoint in localhost:8000 with path 00000000-1111-2222-3333-444444444444/upgrade-risks-prediction
     Then The status code of the response is 404
