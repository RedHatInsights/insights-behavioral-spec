Feature: Basic REST API endpoints provided by Insights Results Aggregator


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/v1
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And aggregator database is in initial state
     When database connection is established
      And I migrate aggregator database to latest version
      And I read current migration number from database
     Then I should see that migration #31 is returned
    Given Insights Results Aggregator service is started in background


  @rest-api @json-check
  Scenario: Check if the main endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint / using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the main endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint / using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the info endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint /info using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the info endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /info using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
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
                   "OCP_DB_version": {
                     "type": "string"
                   },
                   "DVO_DB_version": {
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
                   "DB_version",
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
      And BuildTime is a proper datetime stamp
      #And BuildVersion is in the proper format
      And DBVersion is in the proper format
      And UtilsVersion is in the proper format
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the organizations endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint /organizations using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the organizations endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "organizations": {
                  "type": "array",
                  "prefixItems": [
                    {
                      "type": "integer"
                    }
                  ]
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "organizations",
                "status"
              ]
          }
          """


  @rest-api @json-check
  Scenario: Check if the organizations endpoint is reachable (with proper auth. token and filled-in database with report for one org)
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "organizations": {
                  "type": "array",
                  "prefixItems": [
                    {
                      "type": "integer"
                    }
                  ]
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "organizations",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"organizations":[123],"status":"ok"}
          """


  @rest-api @json-check
  Scenario: Check if the organizations endpoint is reachable (with proper auth. token and filled-in database with reports for two orgs)
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 456          | f1234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "organizations": {
                  "type": "array",
                  "prefixItems": [
                    {
                      "type": "integer"
                    }
                  ]
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "organizations",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"organizations":[123,456],"status":"ok"}
          """


  @rest-api @json-check
  Scenario: Check if the list of clusters for organization endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of clusters for known organization endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "array",
                  "items": {}
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": [], "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of clusters for unknown organization endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /organizations/999/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 403
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
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
          {"status": "you have no permissions to get or change info about the organization with ID 999; you can access info about organization with ID 123"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of clusters for known organization endpoint is reachable (with proper auth. token and one report)
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "array",
                  "items": {}
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": ["01234567-89ab-cdef-0123-456789abcdef"], "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of clusters for known organization endpoint is reachable (with proper auth. token and two reports)
    Given the system is in default state
      And empty reports are stored for following clusters
        | organization | cluster ID                           |
        | 123          | 01234567-89ab-cdef-0123-456789abcdef |
        | 123          | ffffffff-89ab-cdef-0123-456789abcdef |
     When I access endpoint /organizations/123/clusters using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "clusters": {
                  "type": "array",
                  "items": {}
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "clusters",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"clusters": ["01234567-89ab-cdef-0123-456789abcdef","ffffffff-89ab-cdef-0123-456789abcdef"], "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate

  @rest-api @json-check
  Scenario: Check if the list of disabled rules for organization endpoint is reachable (w/o using auth. token)
    Given the system is in default state
     When I access endpoint /rules/organizations/123/disabled using HTTP GET method
     Then The status code of the response is 401
      And The body of the response has the following schema
          """
          {
            "status": {
              "type": "string"
            }
          }
          """
      And The body of the response is the following
          """
          {"status":"Missing auth token"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of disabled rules for known organization endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /rules/organizations/123/disabled using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
                "rules": {
                  "type": "array",
                  "items": {}
                },
                "status": {
                  "type": "string"
                }
              },
              "required": [
                "rules",
                "status"
              ]
          }
          """
      And The body of the response is the following
          """
          {"rules": [], "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate


  @rest-api @json-check
  Scenario: Check if the list of disabled rules for unknown organization endpoint is reachable (with proper auth. token)
    Given the system is in default state
     When I access endpoint /rules/organizations/999/disabled using HTTP GET method using token for organization 123 account number 456, and user 789
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
              "type": "object",
              "properties": {
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
          {"rules": [], "status": "ok"}
          """
     When I terminate Insights Results Aggregator
     Then Insights Results Aggregator process should terminate
