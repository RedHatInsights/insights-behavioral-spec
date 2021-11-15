Feature: Filtering on Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Default filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |


  Scenario: Reset filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And 2 another recommendations are available (but not detected)
          | Title    | Added       | Total risk |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Important  |
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
      And that table should contain 3 rows
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Important  | 0        |


  Scenario: Set filter "Name" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And 2 another recommendations are available (but not detected)
          | Title    | Added       | Total risk |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Important  |
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Important  | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Name" in filter names pull-down menu
      And user fill in "Abc" into filter search input field
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
      And one filter needs to be preselenced
          | Filter name | Tag     |
          | Name        | "Abc"   |
     When user clicks on "x" icon displayed on "Abc" filter tag
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain three rows
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Important  | 0        |


  Scenario: Set filter "Total risk" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And 2 another recommendations are available (but not detected)
          | Title    | Added       | Total risk |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Total risk" in filter names pull-down menu
      And user select "Moderate" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And one filter needs to be preselenced
          | Filter name | Tag        |
          | Total risk  | "Moderate" |
     When user clicks on "x" icon displayed on "Moderate" filter tag
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain three rows
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |


  Scenario: Set filter "Clusters impacted" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And 2 another recommendations are available (but not detected)
          | Title    | Added       | Total risk |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Clusters impacted" in filter names pull-down menu
      And user select "1 or more" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag       |
          | Clusters impacted | 1 or more |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain three rows
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |


  Scenario: Reset filter to default value on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk |
          | Bug12345 | 10 days ago | Important  |
      And 2 another recommendations are available (but not detected)
          | Title    | Added       | Total risk |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
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
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Total risk" in filter names pull-down menu
      And user select "Moderate" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain exactly 1 row
          | Name        | Added       | Total risk | Clusters |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And one filter needs to be preselenced
          | Filter name | Tag        |
          | Total risk  | "Moderate" |
     When user clicks on "Reset filters" link
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain 1 row
          | Name        | Added       | Total risk | Clusters |
          | Abc12345    | 10 days ago | Important  | 0        |
          | Bug12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 0        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |


  Scenario: Set filter "Category" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 3 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category        |
          | PerfBug  | 10 days ago | Important  | Performance     |
          | FaultBug | 10 days ago | Important  | Fault tolerance |
          | Security | 10 days ago | Important  | Security        |
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
      And that table should contain exactly 3 roww
          | Name     | Added       | Total risk | Clusters |
          | PerfBug  | 10 days ago | Important  | 1        |
          | FaultBug | 10 days ago | Important  | 1        |
          | Security | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name     | Added       | Total risk | Clusters |
          | PerfBug  | 10 days ago | Important  | 1        |
          | FaultBug | 10 days ago | Important  | 1        |
          | Security | 10 days ago | Important  | 1        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Category" in filter names pull-down menu
      And user select "Performance" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain exactly 1 row
          | Name     | Added       | Total risk | Clusters |
          | PerfBug  | 10 days ago | Important  | 1        |
      And one filter needs to be preselenced
          | Filter name       | Tag         |
          | Category          | Performance |
     When user selects "Category" in filter names pull-down menu
      And user select "Fault tolerance" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain 2 rows
          | Name     | Added       | Total risk | Clusters |
          | PerfBug  | 10 days ago | Important  | 1        |
          | FaultBug | 10 days ago | Important  | 1        |
      And two filters needs to be preselenced
          | Filter name       | Tag             |
          | Category          | Performance     |
          | Category          | Fault Tolerance |
     When user clicks on "x" icon displayed on "Performance" filter tag
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain one row
          | Name     | Added       | Total risk | Clusters |
          | FaultBug | 10 days ago | Important  | 1        |
     When user clicks on "x" icon displayed on "Fault tolerance" filter tag
     Then table with several columns should be displayed
          | Column name |
          | Name        |
          | Added       |
          | Total risk  |
          | Clusters    |
      And that table should contain one row
          | Name     | Added       | Total risk | Clusters |
          | PerfBug  | 10 days ago | Important  | 1        |
          | FaultBug | 10 days ago | Important  | 1        |
          | Security | 10 days ago | Important  | 1        |
