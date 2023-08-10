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
