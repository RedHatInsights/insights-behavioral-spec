Feature: Behaviour specification for new REST API endpoints that will be implemented in Smart Proxy:

        GET /namespaces/dvo
        Return the list of all DVO namespaces (i.e. array of objects) to which this
        particular account has access.  Each object contains the namespace ID, the
        namespace display name if available, the cluster ID under which this namespace
        is created, and the number of affecting recommendations for this namespace as
        well.

        GET /cluster/{cluster_name}/namespaces/dvo
        GET /namespaces/dvo/cluster/{cluster_name}
        Return the list of all namespaces (i.e. array of objects) to which this
        particular account has access filtered by {cluster_name}.  Each object contains
        the namespace ID, the namespace display name if available, the cluster ID under
        which this namespace is created (repeated input), and the number of affecting
        recommendations for this namespace as well.

        GET /namespace/dvo/{namespace_id}/info
        returns information about the requested namespace. Contains the display name,
        associated cluster ID. Probably, some other metadata like last seen (but not
        needed according to current UX pre-design).

        GET /namespaces/dvo/{namespace_id}/rules
        returns the list of all recommendations affecting this namespace. It is
        basically an array with objects meeting the
        https://github.com/RedHatInsights/insights-results-smart-proxy/blob/master/server/api/v2/openapi.json#L1537
        "interface"

  Scenario: Accessing Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
    Given REST API for Smart Proxy is available
      And REST API service prefix is /api/v2
      And organization TEST_ORG is registered
      And user TEST_USER is member of TEST_USER organization
      And access token is generated to TEST_USER
      When TEST_USER make HTTP GET request to REST API endpoint /api/v2/namespaces/dvo using his access token
      Then The status of the response is 200
       And The body of the response is the following
           """
           {
               "status": "ok",
               "workloads": [
                   {
                       "cluster_name": "{cluster UUID}",
                       "namespace": {
                           "uuid": "{namespace UUID}",
                           "name": "{namespace real name}", // optional, might be null
                       },
                       "reports": [
                           "check": {for example no_anti_affinity"}, // taken from the original full name deploment_validation_operator_no_anti_affinity
                           "kind": "{kind attribute}",
                           "description": {description}",
                       ]
               ]
           }
           """
