Feature: List of clusters on ACM


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by AWS infrastruture
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
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | yes                    |
          | Bare metal assets   | no                     |
          | Automation          | no                     |
     When user select "Clusters" menu item from this sub-menu
     Then a cluster view page named "Clusters" should be displayed right of menu
      And four tabs should be available on that page
          | Tab name            | Required for this test |
          | Managed clusters    | yes                    |
          | Cluster sets        | no                     |
          | Cluster pods        | no                     |
          | Discovered clusters | no                     |
      And the tab named "Managed clusters" needs to be displayed (selected)
      And button "Create cluster" should be diplayed
      And button "Import cluster" should be diplayed
      And the tab should contain a table with exactly 1 managed cluster
      And that table should contain following columns
          | Table column header                       |
          | Name                                      |
          | Status                                    |
          | Infrastructure provider                   |
          | Distribution version                      |
          | Labels                                    |
          | Nodes                                     |
          | (unnamed column with context menu button) |
      And Infrastructure provider for the one existing cluster should say "Amazon Web Services"
      And Status for the one existing cluster should say "Ready"


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Hibernating state managed by AWS infrastruture
    Given user U1 is part of account (organization) owning one managed cluster
      And the infrastrucure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Hibernating state
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
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | yes                    |
          | Bare metal assets   | no                     |
          | Automation          | no                     |
     When user select "Clusters" menu item from this sub-menu
     Then a cluster view page named "Clusters" should be displayed right of menu
      And four tabs should be available on that page
          | Tab name            | Required for this test |
          | Managed clusters    | yes                    |
          | Cluster sets        | no                     |
          | Cluster pods        | no                     |
          | Discovered clusters | no                     |
      And the tab named "Managed clusters" needs to be displayed (selected)
      And button "Create cluster" should be diplayed
      And button "Import cluster" should be diplayed
      And the tab should contain a table with exactly 1 managed cluster
      And that table should contain following columns
          | Table column header                       |
          | Name                                      |
          | Status                                    |
          | Infrastructure provider                   |
          | Distribution version                      |
          | Labels                                    |
          | Nodes                                     |
          | (unnamed column with context menu button) |
      And Infrastructure provider for the one existing cluster should say "Amazon Web Services"
      And Status for the one existing cluster should say "Hibernating"


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Google Cloud Platform
    Given user U1 is part of account (organization) owning one managed cluster
      And the infrastrucure for that managed cluster is provided by Google Cloud Platform
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
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | yes                    |
          | Bare metal assets   | no                     |
          | Automation          | no                     |
     When user select "Clusters" menu item from this sub-menu
     Then a cluster view page named "Clusters" should be displayed right of menu
      And four tabs should be available on that page
          | Tab name            | Required for this test |
          | Managed clusters    | yes                    |
          | Cluster sets        | no                     |
          | Cluster pods        | no                     |
          | Discovered clusters | no                     |
      And the tab named "Managed clusters" needs to be displayed (selected)
      And button "Create cluster" should be diplayed
      And button "Import cluster" should be diplayed
      And the tab should contain a table with exactly 1 managed cluster
      And that table should contain following columns
          | Table column header                       |
          | Name                                      |
          | Status                                    |
          | Infrastructure provider                   |
          | Distribution version                      |
          | Labels                                    |
          | Nodes                                     |
          | (unnamed column with context menu button) |
      And Infrastructure provider for the one existing cluster should say "Google Cloud Platform"
      And Status for the one existing cluster should say "Ready"


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Microsoft Azure
    Given user U1 is part of account (organization) owning one managed cluster
      And the infrastrucure for that managed cluster is provided by Microsoft Azure
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
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | yes                    |
          | Bare metal assets   | no                     |
          | Automation          | no                     |
     When user select "Clusters" menu item from this sub-menu
     Then a cluster view page named "Clusters" should be displayed right of menu
      And four tabs should be available on that page
          | Tab name            | Required for this test |
          | Managed clusters    | yes                    |
          | Cluster sets        | no                     |
          | Cluster pods        | no                     |
          | Discovered clusters | no                     |
      And the tab named "Managed clusters" needs to be displayed (selected)
      And button "Create cluster" should be diplayed
      And button "Import cluster" should be diplayed
      And the tab should contain a table with exactly 1 managed cluster
      And that table should contain following columns
          | Table column header                       |
          | Name                                      |
          | Status                                    |
          | Infrastructure provider                   |
          | Distribution version                      |
          | Labels                                    |
          | Nodes                                     |
          | (unnamed column with context menu button) |
      And Infrastructure provider for the one existing cluster should say "Microsoft Azure"
      And Status for the one existing cluster should say "Ready"
