Feature: Checking responses from Insights Results Aggregator Mock service: endpoint to return upgrade risks predictions

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v2
      And the system is in default state


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns upgrade recommended for a cluster without risks
     When I request upgrade risk for cluster 00000001-624a-49a5-bab8-4fdc5e51a266
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
            {
                "required": [
                    "upgrade_recommendation",
                    "status",
                    "meta"
                ],
                "type": "object",
                "properties": {
                    "upgrade_recommendation": {
                        "type": "object",
                        "properties": {
                            "upgrade_risks_predictors": {
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
                            }
                        }
                    },
                    "status": {
                        "type": "string"
                    },
                    "meta": {
                        "type": "object",
                        "properties": {
                            "last_checked_at": {
                                "type": "string",
                                "format": "date"
                            }
                        }
                    }
                }
            }
          """

  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns upgrade not recommended for a cluster with risks
    Given the system is in default state
     When I request upgrade risk for cluster 00000003-eeee-eeee-eeee-000000000001
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
            {
                "required": [
                    "upgrade_recommendation",
                    "status",
                    "meta"
                ],
                "type": "object",
                "properties": {
                    "upgrade_recommendation": {
                        "type": "object",
                        "properties": {
                            "upgrade_risks_predictors": {
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
                            }
                        }
                    },
                    "status": {
                        "type": "string"
                    },
                    "meta": {
                        "type": "object",
                        "properties": {
                            "last_checked_at": {
                                "type": "string",
                                "format": "date"
                            }
                        }
                    }
                }
            }
          """

  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns 204 NoContent for a managed cluster
    Given the system is in default state
     When I request upgrade risk for cluster 6cab9726-c2be-438e-af11-db846a678abb
     Then The status code of the response is 204

  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns 503 if AMS is not available
    Given the system is in default state
     When I request upgrade risk for cluster c60ba611-6af4-4d62-9b9e-36344da5e7bc
     Then The status code of the response is 503

  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns 503 if Upgrade service is not available
    Given the system is in default state
     When I request upgrade risk for cluster 897ec1a1-4679-4122-aacb-f0ae9f9e1a5f
     Then The status code of the response is 503

  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service returns 404 if the cluster has no data in RHOBS
    Given the system is in default state
     When I request upgrade risk for cluster 234ec1a1-4679-4122-aacb-f0ae9f9e1a56
     Then The status code of the response is 404