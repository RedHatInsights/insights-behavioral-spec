Feature: Cluster view page with recommendations behaviour on Hybrid Cloud Console

  Scenario: Cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |


  Scenario: Recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Expanded recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
      When user look at the expanded recommendation named Bug12345
      Then following information should be displayed on page
          | Section name     | Section description                 |
          | Detected issues  | Detailed recommendation description |
          | Steps to resolve | Usually bunch of steps to follow    |
          | Additional info  | Contains link to KB and/or KCS      |


  Scenario: Folding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
     When user clicks on "v" button displayed left-of "Bug12345"
     Then the first row should be folded
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | >    | Bug12345    | 10 days ago | Critical   | no         |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Expanding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
     When user clicks on ">" button displayed left-of "Abc12345"
     Then the first row should be folded
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | v    | Abc12345    | 10 days ago | Important  | yes        |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Expanding all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
     When user clicks on ">" button displayed left-of Filter widget
     Then all rows should have expanded
      And the ">" button should change to "v"
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | v    | Abc12345    | 10 days ago | Important  | yes        |
          | v    | Xyz12345    | 10 days ago | Moderate   | yes        |
          | v    | Uvw12345    | 10 days ago | Low        | yes        |


  Scenario: Collapsing all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Bug12345 | 10 days ago | Critical   | High           | Service Availability |
          | Abc12345 | 10 days ago | Important  | Moderate       | Performance          |
          | Xyz12345 | 10 days ago | Moderate   | Low            | Fault Tolerance      |
          | Uvw12345 | 10 days ago | Low        | Very low       | Security             |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk | Risk of change | Category             |
          | Nohit    | 10 days ago | Critical   | High           | Service Availability |
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
      And that table should contain following four rows in that order
          | Name        | Modified    | Category             | Total risk | Risk of change | Clusters |
          | Bug12345    | 10 days ago | Service Availability | Critical   | High           | 1        |
          | Abc12345    | 10 days ago | Performance          | Important  | Moderate       | 1        |
          | Xyz12345    | 10 days ago | Fault Tolerance      | Moderate   | Low            | 1        |
          | Uvw12345    | 10 days ago | Security             | Low        | Very low       | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed
          | Column name |
          | Descriptiom |
          | Modified    |
          | Total risk  |
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | v    | Bug12345    | 10 days ago | Critical   | yes        |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
     When user clicks on ">" button displayed left-of Filter widget
     Then all rows should have expanded
      And the ">" button should change to "v"
     When user clicks on "v" button displayed left-of Filter widget
     Then all rows should have collapsed
      And the "v" button should change to ">"
      And the table should contain following rows
          | Icon | Description | Modified    | Total risk | (Expanded) |
          | >    | Bug12345    | 10 days ago | Critical   | no         |
          | >    | Abc12345    | 10 days ago | Important  | no         |
          | >    | Xyz12345    | 10 days ago | Moderate   | no         |
          | >    | Uvw12345    | 10 days ago | Low        | no         |
