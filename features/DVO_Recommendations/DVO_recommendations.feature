Feature: Current way of presenting workload related recommendations is not good
    enough. As a customer using OCP Advisor I'd like to be able to consume
    Workload related recommendations grouped by namespaces. This means that new
    UX controls need to be added into Insights Advisor: it would split results
    of DVO recommendations per namespace and display it to end users.
    Notifications should also be sent per namespace (which would enable
    developers to gain access to results per namespace they own).



  Scenario: Existence of new tab named "Workloads" in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this scenario |
          | Application and Data Services | no                         |
          | OpenShift                     | yes                        |
          | Red Hat Enterprise Linux      | no                         |
          | Ansible Automation Platform   | no                         |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items
          | Left menu item           | Required for this scenario |
          | Clusters                 | no                         |
          | Learning resources       | no                         |
          | Overview                 | no                         |
          | Releases                 | no                         |
          | Developer Sandbox        | no                         |
          | Downloads                | no                         |
          | Advisor                  | yes                        |
          | Vulnerability Dashboard  | no                         |
          | Subscriptions            | no                         |
          | Cost Management          | no                         |
          | Support Cases            | no                         |
          | Cluster Manager Feedback | no                         |
          | Red Hat Marketplace      | no                         |
          | Documentation            | no                         |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then an "Workloads" page should be displayed right of the left menu bar


  Scenario: Content displyed on a new tab named "Workloads" in Insights Advisor if no DVO recommendations has been found
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
      And no DVO recommendations has been found for that cluster
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this scenario |
          | Application and Data Services | no                         |
          | OpenShift                     | yes                        |
          | Red Hat Enterprise Linux      | no                         |
          | Ansible Automation Platform   | no                         |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items
          | Left menu item           | Required for this scenario |
          | Clusters                 | no                         |
          | Learning resources       | no                         |
          | Overview                 | no                         |
          | Releases                 | no                         |
          | Developer Sandbox        | no                         |
          | Downloads                | no                         |
          | Advisor                  | yes                        |
          | Vulnerability Dashboard  | no                         |
          | Subscriptions            | no                         |
          | Cost Management          | no                         |
          | Support Cases            | no                         |
          | Cluster Manager Feedback | no                         |
          | Red Hat Marketplace      | no                         |
          | Documentation            | no                         |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then an "Workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget  | Content                                    |
          | Recommendations | Section containing list of recommendations |
     When user look at "Recommendations" section
     Then following sections should be presented
          | Section          | State                 | Comment                            |
          | Filter list box  | Description           | first selected item                |
          | Filter input box | Filter by description | popup help text                    |
          | Counter          | 0 recommendations     | recommendation counter             |
          | Recommendations  | empty table           | table with list of recommendations |
          | 
     When user look at "Recommendations table"
     Then that table should contain following five columns in that order
          | Column         |
          | Expand button  |
          | Description    |
          | Modified       |
          | First impacted |
          | Total risk     |
      And the table content should be empty
