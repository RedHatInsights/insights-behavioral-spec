Feature: Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console without any recommendations
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 0 issues are detected for this cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
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
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table might contains only rows saying Clusters: 0


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 1 issue is detected for this cluster
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
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
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Important   |
          | Clusters    | 1           |


  Scenario: Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
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
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Important   |
          | Clusters    | 1           |
