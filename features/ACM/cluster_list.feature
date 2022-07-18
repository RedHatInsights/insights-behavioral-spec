Feature: List of clusters on ACM


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by AWS infrastructure
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
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
      And button "Create cluster" should be displayed
      And button "Import cluster" should be displayed
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


  Scenario: Displaying "Clusters" page on ACM for one managed clusters in Hibernating state managed by AWS infrastructure
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Hibernating state
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
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
      And button "Create cluster" should be displayed
      And button "Import cluster" should be displayed
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
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Google Cloud Platform
      And that managed cluster should be in Ready state
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
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
      And button "Create cluster" should be displayed
      And button "Import cluster" should be displayed
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
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Microsoft Azure
      And that managed cluster should be in Ready state
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
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
      And button "Create cluster" should be displayed
      And button "Import cluster" should be displayed
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


  Scenario: Displaying "Clusters" page on ACM for two managed clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 managed clusters
      And the infrastructure for the first managed cluster is provided by Microsoft Azure
      And the infrastructure for second managed cluster is provided by Google Cloud Platform
      And both managed clusters should be in Ready state
      And 0 issues are detected for the first cluster
      And 0 issues are detected for second cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
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
      And button "Create cluster" should be displayed
      And button "Import cluster" should be displayed
      And the tab should contain a table with exactly 2 managed clusters
      And that table should contain following columns
          | Table column header                       |
          | Name                                      |
          | Status                                    |
          | Infrastructure provider                   |
          | Distribution version                      |
          | Labels                                    |
          | Nodes                                     |
          | (unnamed column with context menu button) |
      And Infrastructure provider for one cluster should say "Microsoft Azure"
      And Infrastructure provider for one cluster should say "Google Cloud Provider"
      And Status for the both clusters should say "Ready"
