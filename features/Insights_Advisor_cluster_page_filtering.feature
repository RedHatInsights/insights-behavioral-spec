Feature: Filtering on cluster view page with recommendations behaviour on Hybrid Cloud Console


  Scenario: Default filtering in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |



  Scenario: Filtering by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user insert "Bug" search pattern into "Filter by description" widget
     Then new widget with label "Description" and value "Bug" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
     When user deletes all text from search pattern "Filter by description" widget
     Then widget with label "Description" and value "Bug" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user insert "thisdoesnotexist" search pattern into "Filter by description" widget
     Then new widget with label "Description" and value "thisdoesnotexist" should be made visible
      And "Reset filters" link should appear next to the widget
      And "No matching recommendations found" message should be displayed instead of recommendation table


  Scenario: Filtering by total risk in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Total risk" from Filter type widget
     Then Filter by widget should be changed to contain list of following values
          | Value     | Type      |
          | Critical  | check box |
          | Important | check box |
          | Moderate  | check box |
          | Low       | check box |
     When user select "Critical" value from the previous list
     Then new widget with label "Total risk" and value "Critical" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
     When user click on the "x" icon on "Critical" label
     Then new widget with label "Total risk" and value "Critical" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Filtering by multiple total risk values in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Total risk" from Filter type widget
     Then Filter by widget should be changed to contain list of following values
          | Value     | Type      |
          | Critical  | check box |
          | Important | check box |
          | Moderate  | check box |
          | Low       | check box |
     When user select "Critical" value from the previous list
     Then new widget with label "Total risk" and value "Critical" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
     When user select "Important" value from the previous list
     Then new value "Important" should added into the "Total risk" widget
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
     When user click on the "x" icon on "Critical" label
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Abc12345    | 10 days ago | Important  | no         |
     When user click on the "x" icon on "Important" label
     Then new widget with label "Total risk" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Filtering by category in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Category" from Filter type widget
     Then Filter by widget should be changed to contain list of following values
          | Value                | Type      |
          | Service Availability | check box |
          | Performance          | check box |
          | Fault Tolerance      | check box |
          | Security             | check box |
     When user select "Service Availability" value from the previous list
     Then new widget with label "Category" and value "Service Availability" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
     When user click on the "x" icon on "Service Availability" label
     Then new widget with label "Category" and value "Service Availability" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Filtering by multiple categories in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Category" from Filter type widget
     Then Filter by widget should be changed to contain list of following values
          | Value                | Type      |
          | Service Availability | check box |
          | Performance          | check box |
          | Fault Tolerance      | check box |
          | Security             | check box |
     When user select "Service Availability" value from the previous list
     Then new widget with label "Category" and value "Service Availability" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
     When user select "Category" from Filter type widget
      And user select "Performance" value from the previous list
     Then new value "Performance" should be made visible in the already existing widget "Category"
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
     When user click on the "x" icon on "Service Availability" label
     Then the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Abc12345    | 10 days ago | Important  | no         |
     When user click on the "x" icon on "Performance" label
     Then new widget with label "Category" and value "Service Availability" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Filtering by status in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Added       | Total risk | Category             | Status   |
          | Bug12345 | 10 days ago | Critical   | Service Availability | enabled  |
          | Abc12345 | 10 days ago | Important  | Performance          | enabled  |
          | Xyz12345 | 10 days ago | Moderate   | Fault Tolerance      | disabled |
          | Uvw12345 | 10 days ago | Low        | Security             | disabled |
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
      And that table should contain following four rows in that order
          | Name        | Added       | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |
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
     When user look at Filtering widgets
     Then two widget needs be be displayed on the same line
          | Icon             | Widget      | Content                            |
          | Funnel           | Filter type | Description                        |
          | Magnifying glass | Filter by   | Filter by description help message |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name |
          | Descriptiom |
          | Added       |
          | Total risk  |
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Status" from Filter type widget
     Then Filter by widget should be changed to contain list of following values
          | Value    | Type         |
          | All      | radio button |
          | Enabled  | radio button |
          | Disabled | radio button |
     When user select "Enabled" value from the previous list
     Then new widget with label "Status" and value "Enabled" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
     When user click on the "x" icon on "Enabled" label
     Then new widget with label "Status" and value "Enabled" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user select "Disabled" value from the previous list
     Then widget with label "Status" and value "Disabled" should be made visible
      And "Reset filters" link should appear next to the widget
      And the table should contain following row
          | Description | Added       | Total risk | (Expanded) |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |
     When user click on the "x" icon on "Enabled" label
     Then new widget with label "Status" and value "Enabled" should be made invisible
      And the table should contain following rows in any order
          | Description | Added       | Total risk | (Expanded) |
          | Bug12345    | 10 days ago | Critical   | yes        |
          | Abc12345    | 10 days ago | Important  | no         |
          | Xyz12345    | 10 days ago | Moderate   | no         |
          | Uvw12345    | 10 days ago | Low        | no         |

