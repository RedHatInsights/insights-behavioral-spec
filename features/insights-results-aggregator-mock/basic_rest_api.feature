Feature: Basic REST API endpoints provided by Insights Results Aggregator Mock


  Scenario: Check if the main endpoint is reachable
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I access endpoint / using HTTP GET method
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


  Scenario: Check the groups endpoint
    Given the system is in default state
      And REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1
     When I access endpoint /groups using HTTP GET method
     Then The status code of the response is 200
      And The body of the response has the following schema
          """
          {
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
      And The body of the response is the following
          """
          {
            "groups":[
               {
                 "title": "Performance",
                 "description": "High utilization, proposed tuned profiles, storage issues",
                 "tags": [
                   "performance"
                 ]
               },
               {
                 "title": "Service Availability",
                 "description": "Operator degraded, missing functionality due to misconfiguration or resource constraints.",
                 "tags": [
                   "service_availability"
                 ]
               },
               {
                 "title": "Security",
                 "description": "Issues related to certificates, user management, security groups, specific port usage, storage permissions, usage of kubeadmin account, exposed keys etc.",
                 "tags": [
                   "security"
                 ]
               },
               {
                 "title": "Fault Tolerance",
                 "description": "Load balancer issues, machine api and autoscaler issues, failover issues, nodes down, cluster api/cluster provider issues.",
                 "tags": [
                   "fault_tolerance"
                 ]
               }
            ],
            "status": "ok"
          }
          """
