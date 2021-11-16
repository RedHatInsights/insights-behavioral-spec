Feature: Sorting on Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
          | Uvw12345 | 10 days ago | Low        |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
      And 1 another issue without cluster hit exists
          | Title    | Added       | Total risk |
          | Nohit    | 10 days ago | Critical   |
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
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↕    | no          |
          | Added       | ↕    | no          |
          | Total risk  | ↓    | yes         |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Uvw12345    | 10 days ago | Low        | 1        |


  Scenario: Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
          | Uvw12345 | 10 days ago | Low        |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
      And 1 another issue without cluster hit exists
          | Title    | Added       | Total risk |
          | Nohit    | 10 days ago | Critical   |
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
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↕    | no          |
          | Added       | ↕    | no          |
          | Total risk  | ↓    | yes         |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on ↕ symbol in "Name" column title
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↓    | yes         |
          | Added       | ↕    | no          |
          | Total risk  | ↕    | no          |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Uvw12345    | 10 days ago | Low        | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
     When user clicks on ↓ symbol in "Name" column title
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↑    | yes         |
          | Added       | ↕    | no          |
          | Total risk  | ↕    | no          |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Uvw12345    | 10 days ago | Low        | 1        |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Abc12345    | 10 days ago | Important  | 3        |


  Scenario: Sorting by total risk on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
          | Uvw12345 | 10 days ago | Low        |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Critical   |
      And 1 another issue without cluster hit exists
          | Title    | Added       | Total risk |
          | Nohit    | 10 days ago | Critical   |
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
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↕    | no          |
          | Added       | ↕    | no          |
          | Total risk  | ↓    | yes         |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on ↓ symbol in "Total risk" column title
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↕    | yes         |
          | Added       | ↕    | no          |
          | Total risk  | ↑    | no          |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Uvw12345    | 10 days ago | Low        | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Bug12345    | 10 days ago | Critical   | 4        |
     When user clicks on ↑ symbol in "Total risk" column title
      And table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Name        | ↕    | no          |
          | Added       | ↕    | no          |
          | Total risk  | ↓    | yes         |
          | Clusters    | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 4        |
          | Abc12345    | 10 days ago | Important  | 3        |
          | Xyz12345    | 10 days ago | Moderate   | 2        |
          | Uvw12345    | 10 days ago | Low        | 1        |
