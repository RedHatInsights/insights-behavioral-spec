Feature: Tests for cluster list endpoint


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1


  @rest-api @json-schema-check
  Scenario: Check if is is possible to get list of clusters for given organization #1
    Given the system is in default state
     When I access endpoint /organizations/1/clusters using HTTP GET method
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "type": "object",
            "properties": {
              "clusters": {
                "type": "array",
                "items": [
                  {
                    "type": "string"
                  }
                ]
              },
              "status": {
                "type": "string"
              }
            },
            "required": [
              "status"
            ]
          }
          """
      And The body of the response is the following
          """
          {
            "clusters": [
                 "00000001-624a-49a5-bab8-4fdc5e51a266",
                 "00000001-624a-49a5-bab8-4fdc5e51a267",
                 "00000001-624a-49a5-bab8-4fdc5e51a268",
                 "00000001-624a-49a5-bab8-4fdc5e51a269",
                 "00000001-624a-49a5-bab8-4fdc5e51a26a",
                 "00000001-624a-49a5-bab8-4fdc5e51a26b",
                 "00000001-624a-49a5-bab8-4fdc5e51a26c",
                 "00000001-624a-49a5-bab8-4fdc5e51a26d",
                 "00000001-624a-49a5-bab8-4fdc5e51a26e",
                 "00000001-624a-49a5-bab8-4fdc5e51a26f",
                 "00000001-6577-4e80-85e7-697cb646ff37",
                 "00000001-8933-4a3a-8634-3328fe806e08",
                 "00000001-8d6a-43cc-b82c-7007664bdf69",
                 "00000001-eeee-eeee-eeee-000000000001"
            ],
            "status": "ok"
          }
          """


  @rest-api @json-schema-check
  Scenario: Check if is is possible to get list of clusters for given organization #2
    Given the system is in default state
     When I access endpoint /organizations/2/clusters using HTTP GET method
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "type": "object",
            "properties": {
              "clusters": {
                "type": "array",
                "items": [
                  {
                    "type": "string"
                  }
                ]
              },
              "status": {
                "type": "string"
              }
            },
            "required": [
              "status"
            ]
          }
          """
      And The body of the response is the following
          """
          {
            "clusters": [
                 "00000002-624a-49a5-bab8-4fdc5e51a266",
                 "00000002-6577-4e80-85e7-697cb646ff37",
                 "00000002-8933-4a3a-8634-3328fe806e08"
            ],
            "status": "ok"
          }
          """


  @rest-api @json-schema-check
  Scenario: Check if is is possible to get list of clusters for organization w/o access rights
    Given the system is in default state
     When I access endpoint /organizations/11940171/clusters using HTTP GET method
     Then The status code of the response is 403
      And The body of the response has the following schema
          """
          {
            "type": "object",
            "properties": {
              "clusters": {
                "type": "array",
                "items": [
                  {
                    "type": "string"
                  }
                ]
              },
              "status": {
                "type": "string"
              }
            },
            "required": [
              "status"
            ]
          }
          """
      And The body of the response is the following
          """
          {
            "status": "You have no permissions to get or change info about this organization"
          }
          """


