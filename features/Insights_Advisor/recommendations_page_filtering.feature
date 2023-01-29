Feature: Filtering on Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Default filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |


  Scenario: Reset filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Important  | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
      And that table should contain 3 rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Important  | Low            | 0        |


  Scenario: Set filter "Name" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Important  | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Important  | Low            | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Name" in filter names pull-down menu
      And user fill in "Abc" into filter search input field
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
      And 2 filters need to be preselected
          | Filter name | Tag     |
          | Name        | "Abc"   |
          | Status      | Enabled |
     When user clicks on "x" icon displayed on "Abc" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain three rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Important  | Low            | 0        |


  Scenario: Set filter "Total risk" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Total risk" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | Critical    |
          | Important   |
          | Moderate    |
          | Low         |
     When user select "Moderate" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And 2 filters need to be preselected
          | Filter name | Tag        |
          | Total risk  | "Moderate" |
          | Status      | Enabled    |
     When user clicks on "x" icon displayed on "Moderate" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain three rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |


  Scenario: Set filter "Clusters impacted" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Clusters impacted" in filter names pull-down menu
      And user select "1 or more" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag       |
          | Clusters impacted | 1 or more |
          | Status            | Enabled   |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain three rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |


  Scenario: Reset filter to default value on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Total risk" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | Critical    |
          | Important   |
          | Moderate    |
          | Low         |
     When user select "Moderate" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And 2 filters need to be preselected
          | Filter name | Tag        |
          | Total risk  | "Moderate" |
          | Status      | Enabled    |
     When user clicks on "Reset filters" link
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |


  Scenario: Set filter "Category" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 3 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Category        | Risk of change |
          | PerfBug  | 10 days ago | Important  | Performance     | Moderate       |
          | FaultBug | 10 days ago | Important  | Fault tolerance | Low            |
          | Security | 10 days ago | Important  | Security        | High           |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 3 roww
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | PerfBug  | 10 days ago | Performance     | Important  | Moderate       | 1        |
          | FaultBug | 10 days ago | Fault tolerance | Important  | Low            | 1        |
          | Security | 10 days ago | Security        | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | PerfBug  | 10 days ago | Performance     | Important  | Moderate       | 1        |
          | FaultBug | 10 days ago | Fault tolerance | Important  | Low            | 1        |
          | Security | 10 days ago | Security        | Important  | High           | 1        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Category" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option |
          | Service Availability |
          | Performance          |
          | Fault Tolerance      |
          | Security             |
     When user select "Performance" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | PerfBug  | 10 days ago | Performance     | Important  | Moderate       | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Category          | Performance |
          | Status            | Enabled     |
     When user selects "Category" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option |
          | Service Availability |
          | Performance          |
          | Fault Tolerance      |
          | Security             |
     When user select "Fault tolerance" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain 2 rows
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | PerfBug  | 10 days ago | Performance     | Important  | Moderate       | 1        |
          | FaultBug | 10 days ago | Fault tolerance | Important  | Low            | 1        |
      And 3 filters need to be preselected
          | Filter name       | Tag             |
          | Category          | Performance     |
          | Category          | Fault Tolerance |
          | Status            | Enabled         |
     When user clicks on "x" icon displayed on "Performance" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain one row
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | FaultBug | 10 days ago | Fault tolerance | Important  | Low            | 1        |
     When user clicks on "x" icon displayed on "Fault tolerance" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain one row
          | Name     | Modified    | Category        | Total risk | Risk of change | Clusters |
          | PerfBug  | 10 days ago | Performance     | Important  | Moderate       | 1        |
          | FaultBug | 10 days ago | Fault tolerance | Important  | Low            | 1        |
          | Security | 10 days ago | Security        | Important  | High           | 1        |


  Scenario: Set filter "Likelihood" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 3 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title  | Modified    | Category    | Total risk | Risk of change | Likelihood |
          | High   | 10 days ago | Security    | Important  | Moderate       | High       |
          | Medium | 10 days ago | Security    | Important  | Moderate       | Medium     |
          | Low    | 10 days ago | Performance | Important  | Low            | Low        |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 3 roww
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Medium | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Medium | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Likelihood" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | Critical    |
          | High        |
          | Medium      |
          | Low         |
     When user select "High" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
      And 2 filters need to be preselected
          | Filter name | Tag     |
          | Likelihood  | High    |
          | Status      | Enabled |
     When user selects "Likelihood" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | Critical    |
          | High        |
          | Medium      |
          | Low         |
     When user select "Low" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain 2 rows
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |
      And 3 filters need to be preselected
          | Filter name | Tag     |
          | Likelihood  | High    |
          | Likelihood  | Low     |
          | Status      | Enabled |
     When user clicks on "x" icon displayed on "High" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain one row
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |
     When user clicks on "x" icon displayed on "Low" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain one row
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Medium | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |


  Scenario: No-op action in filter menu on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 3 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title  | Modified    | Category    | Total risk | Risk of change | Likelihood |
          | High   | 10 days ago | Security    | Important  | Moderate       | High       |
          | Medium | 10 days ago | Security    | Important  | Moderate       | Medium     |
          | Low    | 10 days ago | Performance | Important  | Low            | Low        |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 3 roww
          | Name   | Modified    | Category    | Total risk | Risk of change | Clusters |
          | High   | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Medium | 10 days ago | Security    | Important  | Moderate       | 1        |
          | Low    | 10 days ago | Performance | Important  | Low            | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user selects "Likelihood" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | Critical    |
          | High        |
          | Medium      |
          | Low         |
     When user select "None" from the rigth pull-down menu
     Then content of the table will remain unchanged


  Scenario: Set and reset filter "Risk of change" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Important  | High           | Service Availability |
      And 2 another recommendations are available (but not detected)
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Abc12345 | 10 days ago | Important  | High           | Service Availability |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Performance          |
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
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
      And 2 filters need to be preselected
          | Filter name       | Tag         |
          | Clusters impacted | 1 or more   |
          | Status            | Enabled     |
     When user clicks on "x" icon displayed on "1 or more" filter tag
     Then table with advisor recommendation should contain recommendations names with 0 clusters
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And filter widget should consists of filter names pull-down menu and filter search input field
     When user selects "Risk of change" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | High        |
          | Moderate    |
          | Low         |
          | Very Low    |
     When user select "Low" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 1 row
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And 2 filters need to be preselected
          | Filter name     | Tag        |
          | Risk of change  | Low        |
          | Status          | Enabled    |
     When user selects "Risk of change" in filter names pull-down menu
     Then search input field becomes a pull-down menu with several options
          | Option name |
          | High        |
          | Moderate    |
          | Low         |
          | Very Low    |
     When user select "High" from the rigth pull-down menu
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain exactly 3 rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
      And 3 filters need to be preselected
          | Filter name     | Tag        |
          | Risk of change  | Low        |
          | Risk of change  | High       |
          | Status          | Enabled    |
     When user clicks on "x" icon displayed on "Low" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain 2 rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
     When user clicks on "x" icon displayed on "High" filter tag
     Then table with several columns should be displayed
          | Column name    |
          | Name           |
          | Modified       |
          | Category       |
          | Total risk     |
          | Risk of change |
          | Clusters       |
      And that table should contain 2 rows
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Service Availability | Important  | High           | 0        |
          | Bug12345    | 10 days ago | Service Availability | Important  | High           | 1        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 0        |
