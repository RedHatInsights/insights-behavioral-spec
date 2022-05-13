Feature: Filtering on Advisor affected clusters page behaviour on Hybrid Cloud Console


  Scenario: Default filtering on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 12 clusters
          | Cluster name                         |
          | 00000000-0000-0000-aaaa-000000000000 |
          | 11111111-0000-0000-aaaa-000000000000 |
          | 22222222-0000-0000-aaaa-000000000000 |
          | 33333333-0000-0000-aaaa-000000000000 |
          | 00000000-0000-0000-bbbb-000000000000 |
          | 11111111-0000-0000-bbbb-000000000000 |
          | 22222222-0000-0000-bbbb-000000000000 |
          | 33333333-0000-0000-bbbb-000000000000 |
          | 00000000-0000-0000-0000-f00000000000 |
          | 00000000-0000-0000-0000-ff0000000000 |
          | 00000000-0000-0000-0000-fff000000000 |
          | 00000000-0000-0000-0000-ffff00000000 |
      And 1 issue is detected for following clusters
          | Title    | Added       | Total risk | Cluster name                         |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-bbbb-000000000000 |
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
          | Bug12345    | 10 days ago | Critical   | 8        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
      And "Filter by name" widget needs to be displayed under "Affected clusters" table


  Scenario: Basic filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 12 clusters
          | Cluster name                         |
          | 00000000-0000-0000-aaaa-000000000000 |
          | 11111111-0000-0000-aaaa-000000000000 |
          | 22222222-0000-0000-aaaa-000000000000 |
          | 33333333-0000-0000-aaaa-000000000000 |
          | 00000000-0000-0000-bbbb-000000000000 |
          | 11111111-0000-0000-bbbb-000000000000 |
          | 22222222-0000-0000-bbbb-000000000000 |
          | 33333333-0000-0000-bbbb-000000000000 |
          | 00000000-0000-0000-0000-f00000000000 |
          | 00000000-0000-0000-0000-ff0000000000 |
          | 00000000-0000-0000-0000-fff000000000 |
          | 00000000-0000-0000-0000-ffff00000000 |
      And 1 issue is detected for following clusters
          | Title    | Added       | Total risk | Cluster name                         |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-bbbb-000000000000 |
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
          | Bug12345    | 10 days ago | Critical   | 8        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
      And "Filter by name" widget needs to be displayed under "Affected clusters" table
     When user insert "1111" search pattern into "Filter by name" widget
     Then "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
      And "Clear filters" link should appear next to the widget
     When user insert deletes all text from search pattern "Filter by name" widget
     Then "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
     When user insert "aaaa" search pattern into "Filter by name" widget
     Then "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |


  Scenario: On-the-fly filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 12 clusters
          | Cluster name                         |
          | 00000000-0000-0000-aaaa-000000000000 |
          | 11111111-0000-0000-aaaa-000000000000 |
          | 22222222-0000-0000-aaaa-000000000000 |
          | 33333333-0000-0000-aaaa-000000000000 |
          | 00000000-0000-0000-bbbb-000000000000 |
          | 11111111-0000-0000-bbbb-000000000000 |
          | 22222222-0000-0000-bbbb-000000000000 |
          | 33333333-0000-0000-bbbb-000000000000 |
          | 00000000-0000-0000-0000-f00000000000 |
          | 00000000-0000-0000-0000-ff0000000000 |
          | 00000000-0000-0000-0000-fff000000000 |
          | 00000000-0000-0000-0000-ffff00000000 |
      And 1 issue is detected for following clusters
          | Title    | Added       | Total risk | Cluster name                         |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-bbbb-000000000000 |
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
          | Bug12345    | 10 days ago | Critical   | 8        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
      And "Filter by name" widget needs to be displayed under "Affected clusters" table
     When user inserts "f" search pattern into "Filter by name" widget
     Then the "Filter by name" widget should contain "f" pattern
      And "Clear filters" link should appear next to the widget
      And "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
     When user appends second into "f" into "Filter by name" widget
     Then the "Filter by name" widget should contain "ff" pattern
      And "Clear filters" link should still be visible next to the widget
      And "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
     When user appends third into "f" into "Filter by name" widget
     Then the "Filter by name" widget should contain "fff" pattern
      And "Clear filters" link should still be visible next to the widget
      And "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
     When user appends fourth into "f" into "Filter by name" widget
     Then the "Filter by name" widget should contain "ffff" pattern
      And "Clear filters" link should still be visible next to the widget
      And "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
      When user appends fifth into "f" into "Filter by name" widget
     Then the "Filter by name" widget should contain "fffff" pattern
      And "Clear filters" link should still be visible next to the widget
      And a message "No matching clusters found" should be displayed instead of a table


  Scenario: Ability to clear filter on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 12 clusters
          | Cluster name                         |
          | 00000000-0000-0000-aaaa-000000000000 |
          | 11111111-0000-0000-aaaa-000000000000 |
          | 22222222-0000-0000-aaaa-000000000000 |
          | 33333333-0000-0000-aaaa-000000000000 |
          | 00000000-0000-0000-bbbb-000000000000 |
          | 11111111-0000-0000-bbbb-000000000000 |
          | 22222222-0000-0000-bbbb-000000000000 |
          | 33333333-0000-0000-bbbb-000000000000 |
          | 00000000-0000-0000-0000-f00000000000 |
          | 00000000-0000-0000-0000-ff0000000000 |
          | 00000000-0000-0000-0000-fff000000000 |
          | 00000000-0000-0000-0000-ffff00000000 |
      And 1 issue is detected for following clusters
          | Title    | Added       | Total risk | Cluster name                         |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-aaaa-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 00000000-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 11111111-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 22222222-0000-0000-bbbb-000000000000 |
          | Bug12345 | 10 days ago | Critical   | 33333333-0000-0000-bbbb-000000000000 |
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
          | Bug12345    | 10 days ago | Critical   | 8        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
      And "Filter by name" widget needs to be displayed under "Affected clusters" table
     When user inserts "f" search pattern into "Filter by name" widget
     Then the "Filter by name" widget should contain "f" pattern
      And "Clear filters" link should still be visible next to the widget
      And "Affected clusters" table needs to be redisplayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
     When user click in "Clear filters" link
     Then the "Filter by name" widget should be empty
      And "Clear filters" link should not be visible
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-aaaa-000000000000 | yes              |
          | 11111111-0000-0000-aaaa-000000000000 | yes              |
          | 22222222-0000-0000-aaaa-000000000000 | yes              |
          | 33333333-0000-0000-aaaa-000000000000 | yes              |
          | 00000000-0000-0000-bbbb-000000000000 | yes              |
          | 11111111-0000-0000-bbbb-000000000000 | yes              |
          | 22222222-0000-0000-bbbb-000000000000 | yes              |
          | 33333333-0000-0000-bbbb-000000000000 | yes              |
          | 00000000-0000-0000-0000-f00000000000 | yes              |
          | 00000000-0000-0000-0000-ff0000000000 | yes              |
          | 00000000-0000-0000-0000-fff000000000 | yes              |
          | 00000000-0000-0000-0000-ffff00000000 | yes              |
