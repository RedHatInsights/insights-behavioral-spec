Feature: Filtering on Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Default filter on Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
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
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |


  Scenario: Reset filter on Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
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
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Important   |
          | Clusters    | 1           |
