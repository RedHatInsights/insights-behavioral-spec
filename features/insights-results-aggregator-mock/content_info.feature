Feature: Checking responses from Insights Results Aggregator Mock service: "content" endpoint


  Background:
    Given REST API service hostname is localhost
      And REST API service port is 8080
      And REST API service prefix is /api/insights-results-aggregator/v1


  @rest-api
  Scenario: Check if Insights Results Aggregator Mock service return correct list of groups
    Given the system is in default state
     When I request content and groups
     Then The status code of the response is 200
      And The status message of the response is "ok"
      And I should retrieve empty content
      And I should retrieve following list of groups
         | Title                | Description                                                                                                                                               | Tags                 |
         | Fault Tolerance      | Load balancer issues, machine api and autoscaler issues, failover issues, nodes down, cluster api/cluster provider issues.                                | fault_tolerance      |
         | Performance          | High utilization, proposed tuned profiles, storage issues                                                                                                 | performance          |
         | Service Availability | Operator degraded, missing functionality due to misconfiguration or resource constraints.                                                                 | service_availability |
         | Security             | Issues related to certificates, user management, security groups, specific port usage, storage permissions, usage of kubeadmin account, exposed keys etc. | security             |
