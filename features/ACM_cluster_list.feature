Feature: List of clusters on ACM

  Scenario: Displaying list of clusters on ACM for one managed clusters with AWS infrastruture
    Given user U1 is part of account (organization) owning one managed cluster
      And the infrastrucure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And the user is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contian these top level items
          | Left menu item      | Required for this test |
          | Home                | no                     |
          | Infrastructure      | yes                    |
          | Applications        | no                     |
          | Governance          | no                     |
          | Credential          | no                     |
          | Visual Web Terminal | no                     |
     When user expand "Infrastructure" top level item
     Then the menu should be expanded
      And following items should be displayed on the left side
          | Expanded menu item | Required for this test |
          | Clusters           | yes                    |
          | Bare metal assets  | no                     |
          | Automation         | no                     |
     When user select "Clusters" menu item
     Then a cluster view page named "Clusters" should be displayed right of menu
      And four tabs should be available on that page
          | Tab name            |
          | Managed clusters    |
          | Cluster sets        |
          | Cluster pods        |
          | Discovered clusters |
      And the tab named "Managed clusters" needs to be displayed
      And the tab should contain a list with one managed cluster
      And Infrastructure provider for that clusters should say "Amazon Web Services"
      And Status for that cluster should say "Ready"


