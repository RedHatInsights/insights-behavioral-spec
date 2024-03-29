Feature: Sorting on Advisor affected clusters page behaviour on Hybrid Cloud Console


  Scenario: Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | High                | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 33333333-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      And Sorting icon ↕ needs to be displayed right-of column title
      And That icon should not be highlighted


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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | High                | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 33333333-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      And Sorting icon ↕ needs to be displayed right-of column title
      And That icon should not be highlighted
     When User clicks on sorting icon ↕ 
     Then "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 33333333-0000-0000-0000-000000000000 | yes              |
      And Sorting icon ↑ needs to be displayed right-of column title
      And That icon should be highlighted


  Scenario: Sorting by name in different order on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 4        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 3        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 2        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very Low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | High                | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 33333333-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      And Sorting icon ↕ needs to be displayed right-of column title
      And That icon should not be highlighted
     When User clicks on sorting icon ↕ 
     Then Sorting icon ↑ needs to be displayed right-of column title
      And That icon should be highlighted
     When User clicks on sorting icon ↑ 
     Then Sorting icon ↓ needs to be displayed right-of column title
      And That icon should be highlighted
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 33333333-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 00000000-0000-0000-0000-000000000000 | yes              |
