Feature: Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console without any recommendations
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this test |
          | Application and Data Services | no                     |
          | OpenShift                     | yes                    |
          | Red Hat Enterprise Linux      | no                     |
          | Ansible Automation Platform   | no                     |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Clusters                 | no                     |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Developer Sandbox        | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Vulnerability            | no                     |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Support Cases            | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And widget with filter settings should be displayed
      And table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table might contains only rows saying Clusters: 0


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 1 issue is detected for this cluster
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this test |
          | Application and Data Services | no                     |
          | OpenShift                     | yes                    |
          | Red Hat Enterprise Linux      | no                     |
          | Ansible Automation Platform   | no                     |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Clusters                 | no                     |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Developer Sandbox        | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Vulnerability            | no                     |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Support Cases            | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And widget with filter settings should be displayed
      And table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain at least one row
          | Column name    | Value                |
          | Name           | Bug12345              |
          | Modified       | 10 days ago          |
          | Category       | Service Availability |
          | Total risk     | Critical             |
          | Risk of change | High                 |
          | Clusters       | 1                    |


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this test |
          | Application and Data Services | no                     |
          | OpenShift                     | yes                    |
          | Red Hat Enterprise Linux      | no                     |
          | Ansible Automation Platform   | no                     |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Clusters                 | no                     |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Developer Sandbox        | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Vulnerability            | no                     |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Support Cases            | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And widget with filter settings should be displayed
      And table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain at least one row
          | Column name    | Value                |
          | Name           | Bug12345              |
          | Modified       | 10 days ago          |
          | Category       | Service Availability |
          | Total risk     | Critical             |
          | Risk of change | High                 |
          | Clusters       | 1                    |
