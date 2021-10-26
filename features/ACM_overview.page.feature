Feature: Overview page behaviour


  Scenario: Displaying "Overview" page on ACM for one managed clusters in Ready state managed by AWS infrastruture
    Given user U1 is part of account (organization) owning one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 0 issues are detected for this cluster
      And the user is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contian these top level items
          | Left menu item      | Required for this test |
          | Home                | yes                    |
          | Infrastructure      | no                     |
          | Applications        | no                     |
          | Governance          | no                     |
          | Credential          | no                     |
          | Visual Web Terminal | no                     |
     When user expand "Home" top level item
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
      And several sections needs to be placed on the page
          | Section             | Required for this test |
          | AWS Amazon          | yes                    |
          | Summary             | yes                    |
          | Cluster compliance  | no                     |
          | Pods                | no                     |
          | Cluster status      | no                     |
          | Cluster issues      | yes                    |
      And "AWS Amazon" section should say "1 cluster"
      And "Cluster issues" section should contain information about no issues
