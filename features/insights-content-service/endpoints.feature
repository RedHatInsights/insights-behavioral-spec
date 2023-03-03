@insights_content_service

Feature: Test the service endpoints

  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1/

    @rest-api @json-schema-check
    Scenario: check /info endpoint response
        When I access endpoint /info using HTTP GET method
        Then The status message of the response is "ok"
         And The status code of the response is 200
         And The body of the response has the following schema 
         """
          {
            "type": "object",
            "properties": {
              "info": {
                "type": "object",
                "properties": {
                  "BuildBranch": {
                    "type": "string"
                  },
                  "BuildCommit": {
                    "type": "string"
                  },
                  "BuildTime": {
                    "type": "string"
                  },
                  "BuildVersion": {
                    "type": "string"
                  },
                  "OCPRulesVersion": {
                    "type": "string"
                  },
                  "UtilsVersion": {
                    "type": "string"
                  }
                },
                "required": [
                  "BuildBranch",
                  "BuildCommit",
                  "BuildTime",
                  "BuildVersion",
                  "OCPRulesVersion",
                  "UtilsVersion"
                ]
              },
              "status": {
                "type": "string"
              }
            },
            "required": [
              "info",
              "status"
            ]
          }
          """
         And BuildCommit is a proper sha1
         And BuildTime is a proper date 
         And BuildVersion is in the proper format
         And OCPRulesVersion is in the proper format
         And UtilsVersion is in the proper format

    @rest-api @json-schema-check
    Scenario: check /groups endpoint response
        When I access endpoint /groups using HTTP GET method
        Then The status message of the response is "ok"
         And The status code of the response is 200
         And The body of the response has the following schema 
         """
          {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "object",
            "properties": {
              "groups": {
                "type": "array",
                "items": [
                  {
                    "type": "object",
                    "properties": {
                      "title": {
                        "type": "string"
                      },
                      "description": {
                        "type": "string"
                      },
                      "tags": {
                        "type": "array",
                        "items": [
                          {
                            "type": "string"
                          }
                        ]
                      }
                    },
                    "required": [
                      "title",
                      "description",
                      "tags"
                    ]
                  }
                ]
              },
              "status": {
                "type": "string"
              }
            },
            "required": [
              "groups",
              "status"
            ]
          }
         """
         And all the groups are present
         And tags and groups match

    @rest-api @json-schema-check
    Scenario: check /status endpoint response
        When I access endpoint /status using HTTP GET method
        Then The status message of the response is "ok"
         And The status code of the response is 200
         And The body of the response has the following schema 
         """
          {
            "$ref": "#/definitions/ruleName",
            "definitions": {
                "ruleName": {
                    "type": "object",
                    "additionalProperties": false,
                    "properties": {
                        "rules": {
                            "type": "object",
                            "additionalProperties": {
                                "$ref": "#/definitions/Rule"
                            }
                        },
                        "status": {
                            "type": "string"
                        }
                    },
                    "required": [
                        "rules",
                        "status"
                    ],
                    "title": "ruleName"
                },
                "Rule": {
                    "type": "object",
                    "additionalProperties": false,
                    "properties": {
                        "type": {
                            "$ref": "#/definitions/Type"
                        },
                        "loaded": {
                            "type": "boolean"
                        },
                        "error": {
                            "$ref": "#/definitions/Error"
                        }
                    },
                    "required": [
                        "error",
                        "loaded",
                        "type"
                    ],
                    "title": "Rule"
                },
                "Error": {
                    "type": "string",
                    "enum": [
                        "",
                        "some of the error keys are missing mandatory attributes"
                    ],
                    "title": "Error"
                },
                "Type": {
                    "type": "string",
                    "enum": [
                        "internal",
                        "external",
                        "ocs"
                    ],
                    "title": "Type"
                }
            }
          }
         """
         And rules are properly loaded
