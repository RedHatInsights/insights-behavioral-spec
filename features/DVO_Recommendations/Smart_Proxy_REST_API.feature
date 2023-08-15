Feature: Behaviour specification for new REST API endpoints that will be implemented in Smart Proxy:

        GET /namespaces/dvo
        Returns the list of all DVO namespaces (i.e. array of objects) to which this
        particular account has access.  Each object contains the namespace ID, the
        namespace display name if available, the cluster ID under which this namespace
        is created, and the number of affecting recommendations for this namespace as
        well.

        GET /cluster/{cluster_name}/namespaces/dvo
        GET /namespaces/dvo/cluster/{cluster_name}
        Returns the list of all namespaces (i.e. array of objects) to which this
        particular account has access filtered by {cluster_name}.  Each object contains
        the namespace ID, the namespace display name if available, the cluster ID under
        which this namespace is created (repeated input), and the number of affecting
        recommendations for this namespace as well.
        Both GETers have the same meaning, just the order of selectors is different.

        GET /namespaces/dvo/{namespace_id}/info
        Returns information about the requested namespace. Contains the display name,
        associated cluster ID. Probably, some other metadata like last seen (but not
        needed according to current UX pre-design).

        GET /namespaces/dvo/{namespace_id}/rules
        Returns the list of all recommendations affecting this namespace. It is
        basically an array with objects meeting the
        https://github.com/RedHatInsights/insights-results-smart-proxy/blob/master/server/api/v2/openapi.json#L1537
        "interface"


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo using their access token
     Then The status of the response is 200
      And The body of the response is the following
          """
          {
              "status": "ok",
              "workloads": [
                  {
                      "cluster": {
                          "uuid": "{cluster UUID}",
                          "display_name": "{cluster UUID or displayable name}",
                      },
                      "namespace": {
                          "uuid": "{namespace UUID}",
                          "name": "{namespace real name}", // optional, might be null
                      },
                      "reports": [
                          {
                              "check": "{for example no_anti_affinity}", // taken from the original full name deploment_validation_operator_no_anti_affinity
                              "kind": "{kind attribute}",
                              "description": {description}",
                          },
                      ]
              ]
          }
          """


  Scenario: Returning just active clusters in Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following clusters
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000002-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000003-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000004-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000005-0000-0000-0000-000000000000 |
      And AMS registers the following live clusters
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000003-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000004-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000005-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000006-0000-0000-0000-000000000000 |
          | TEST_ORG        | 00000007-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo using their access token
     Then The status of the response is 200
      And The workloads list should contain information just for following list of clusters
          | Cluster name                         |
          | 00000003-0000-0000-0000-000000000000 |
          | 00000004-0000-0000-0000-000000000000 |
          | 00000005-0000-0000-0000-000000000000 |


  Scenario: Checking organization in Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is NOT registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo using their access token
     Then The status of the response is 403
      And The body of the response is the following
          """
          {
              "status": "forbidden"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for selected existing cluster
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following cluster
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster/00000001-0000-0000-0000-000000000000 using their access token
     Then The status of the response is 200
      And The body of the response is the following
          """
          {
              "status": "ok",
              "reports": [
                  {
                      "check": "{for example no_anti_affinity}", // taken from the original full name deploment_validation_operator_no_anti_affinity
                      "kind": "{kind attribute}",
                      "description": {description}",
                  },
              ]
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for not known cluster
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following cluster
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster/ffffffff-ffff-ffff-ffff-000000000000 using their access token
     Then The status of the response is 404
      And The body of the response is the following
          """
          {
              "status": "cluster not found"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for known cluster without DVO namespaces
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster/00000001-0000-0000-0000-000000000000 using their access token
     Then The status of the response is 404
      And The body of the response is the following
          """
          {
              "status": "namespace not found"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper cluster UUID
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following cluster
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster/foo-bar-baz using their access token
     Then The status of the response is 400
      And The body of the response is the following
          """
          {
              "status": "improper cluster name"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is NOT registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster/ffffffff-ffff-ffff-ffff-000000000000 using their access token
     Then The status of the response is 403
      And The body of the response is the following
          """
          {
              "status": "forbidden"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces when cluster is not specified
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/cluster using their access token
     Then The status of the response is 400
      And The body of the response is the following
          """
          {
              "status": "cluster UUID is not provided"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for not known cluster
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following cluster
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint cluster/ffffffff-ffff-ffff-ffff-000000000000/namespaces/dvo using their access token
     Then The status of the response is 404
      And The body of the response is the following
          """
          {
              "status": "cluster not found"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for known cluster without DVO namespaces
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint cluster/00000001-0000-0000-0000-000000000000/namespaces/dvo/ using their access token
     Then The status of the response is 404
      And The body of the response is the following
          """
          {
              "status": "namespace not found"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper cluster UUID
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And CCX data pipeline has DVO results stored in its database for following cluster
          | Organization ID | Cluster name                         |
          | TEST_ORG        | 00000001-0000-0000-0000-000000000000 |
     When TEST_USER make HTTP GET request to REST API endpoint cluster/foo-bar-baz/namespaces/dvo/ using their access token
     Then The status of the response is 400
      And The body of the response is the following
          """
          {
              "status": "improper cluster name"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is NOT registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
     When TEST_USER make HTTP GET request to REST API endpoint cluster/ffffffff-ffff-ffff-ffff-000000000000/namespaces/dvo/ using their access token
     Then The status of the response is 403
      And The body of the response is the following
          """
          {
              "status": "forbidden"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And DVO namespace NAMESPACE_ID exists in the storage
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/{NAMESPACE_ID}/info
     Then The status of the response is 200
      And The body of the response is the following
          """
          {
              "status": "ok"
              "namespace": {
                  "uuid": "{namespace UUID}",
                  "name": "{namespace real name}", // optional, might be null
              },
              "cluster": {
                  "uuid": "{cluster UUID}",
                  "display_name": "{cluster UUID or displayable name}",
              },
              "metadata": {
                  "last_seen": "{timestamp}", // optional ATM
              },
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace when no such namespace exists
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And DVO namespace NAMESPACE_ID does not exist in the storage
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/{NAMESPACE_ID}/info
     Then The status of the response is 404
      And The body of the response is the following
          """
          {
              "status": "namespace not found"
          }
          """


  Scenario: Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace for improper organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is NOT registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      And DVO namespace NAMESPACE_ID does not exist in the storage
     When TEST_USER make HTTP GET request to REST API endpoint namespaces/dvo/{NAMESPACE_ID}/info
     Then The status of the response is 403
      And The body of the response is the following
          """
          {
              "status": "forbidden"
          }
          """


