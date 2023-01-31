Feature: Sorting on Advisor recommendations page behaviour on Hybrid Cloud Console


  Scenario: Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Category                  | Risk of change |
          | Bug12345 | 10 days ago | Critical   | Availability, Security    | High           |
          | Abc12345 | 10 days ago | Important  | Availability              | Moderate       |
          | Xyz12345 | 10 days ago | Moderate   | Performance               | Low            |
          | Uvw12345 | 10 days ago | Low        | Security                  | Very Low       |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Category                  | Risk of change |
          | Bug12345 | 10 days ago | Critical   | Availability, Security    | High           |
          | Abc12345 | 10 days ago | Important  | Availability              | Moderate       |
          | Xyz12345 | 10 days ago | Moderate   | Performance               | Low            |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Category                  | Risk of change |
          | Bug12345 | 10 days ago | Critical   | Availability, Security    | High           |
          | Abc12345 | 10 days ago | Important  | Availability              | Moderate       |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Category                  | Risk of change |
          | Bug12345 | 10 days ago | Critical   | Availability, Security    | High           |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Category                  | Risk of change |
          | Nohit    | 10 days ago | Critical   | Fault tolerance           | Very Low       |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Availability, 1 more | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Availability         | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Performance          | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |


  Scenario: Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Name" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↓    | yes         |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
     When user clicks on ↓ symbol in "Name" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↑    | yes         |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |


  Scenario: Sorting by total risk on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↓ symbol in "Total risk" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↑    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
     When user clicks on ↑ symbol in "Total risk" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |


  Scenario: Sorting by clusters on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Clusters" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↓    | yes         |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↓ symbol in "Clusters" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↑    | yes         |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |


  Scenario: Sorting by added at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 20 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 20 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 50 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Modified" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↓    | yes         |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↓ symbol in "Modified" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↑    | yes         |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |


  Scenario: Sorting by different columns at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 20 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 20 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 40 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 30 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 50 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Name" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↓    | yes         |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
     When user clicks on ↕ symbol in "Modified" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↓    | yes         |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Clusters" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↓    | yes         |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Category" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↑    | yes         |
          | Total risk     | ↕    | no          |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Xyz12345    | 20 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Abc12345    | 40 days ago | Performance          | Important  | Moderate       | 3        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Bug12345    | 30 days ago | Service Availability | Critical   | High           | 4        |



  Scenario: Sorting by Risk of change on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 3 issues are detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
      And 2 issues are detected for cluster 22222222-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
      And 1 issue is detected for cluster 33333333-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↓    | yes         |
          | Risk of change | ↕    | no          |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on ↕ symbol in "Risk of change" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↑    | yes         |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
     When user clicks on ↑ symbol in "Risk of change" column title
      And table with several columns should be displayed with sorting setting
          | Column name    | Sort | Highlighted |
          | Name           | ↕    | no          |
          | Modified       | ↕    | no          |
          | Category       | ↕    | no          |
          | Total risk     | ↕    | no          |
          | Risk of change | ↓    | yes         |
          | Clusters       | ↕    | no          |
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
