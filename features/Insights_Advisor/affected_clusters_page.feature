Feature: Cluster view page with recommendations behaviour on Hybrid Cloud Console


  Scenario: Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Category | Total risk | Likelihood | Impact | Risk of change |
          | Bug12345 | 10 days ago | Security | Important  | high       | high   | Moderate       |
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
      And that table should contain at least one row
          | Column name    | Value       |
          | Name           | Bug1234     |
          | Modified       | 10 days ago |
          | Category       | Security    |
          | Total risk     | Important   |
          | Risk of change | Moderate    |
          | Clusters       | 1           |
     When user clicks on an "Bug1234" link
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
      And paging widget should say "1-1 of 1"


  Scenario: Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 2 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
      And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Category | Total risk | Likelihood | Impact | Risk of change |
          | Bug12345 | 10 days ago | Security | Important  | high       | high   | Moderate       |
      And 1 issue is detected for cluster 11111111-0000-0000-0000-000000000000
          | Title    | Modified    | Category | Total risk | Likelihood | Impact | Risk of change |
          | Bug12345 | 10 days ago | Security | Important  | high       | high   | Moderate       |
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
      And that table should contain at least one row
          | Column name    | Value       |
          | Name           | Bug1234     |
          | Modified       | 10 days ago |
          | Category       | Security    |
          | Total risk     | Important   |
          | Risk of change | Moderate    |
          | Clusters       | 1           |
     When user clicks on an "Bug1234" link
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
          | 11111111-0000-0000-0000-000000000000 | yes              |
      And paging widget should say "1-2 of 2"


  Scenario: Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 12 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
          | 11111111-0000-0000-0000-000000000000 |
          | 22222222-0000-0000-0000-000000000000 |
          | 33333333-0000-0000-0000-000000000000 |
          | 44444444-0000-0000-0000-000000000000 |
          | 55555555-0000-0000-0000-000000000000 |
          | 66666666-0000-0000-0000-000000000000 |
          | 77777777-0000-0000-0000-000000000000 |
          | 88888888-0000-0000-0000-000000000000 |
          | 99999999-0000-0000-0000-000000000000 |
          | aaaaaaaa-0000-0000-0000-000000000000 |
          | bbbbbbbb-0000-0000-0000-000000000000 |
      And 1 issue is detected for all clusters
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
      And that table should contain at least one row
          | Column name    | Value       |
          | Name           | Bug1234     |
          | Modified       | 10 days ago |
          | Category       | Security    |
          | Total risk     | Important   |
          | Risk of change | Moderate    |
          | Clusters       | 1           |
     When user clicks on an "Bug1234" link
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
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 00000000-0000-0000-0000-000000000000 | yes              |
          | 11111111-0000-0000-0000-000000000000 | yes              |
          | 22222222-0000-0000-0000-000000000000 | yes              |
          | 33333333-0000-0000-0000-000000000000 | yes              |
          | 44444444-0000-0000-0000-000000000000 | yes              |
          | 55555555-0000-0000-0000-000000000000 | yes              |
          | 66666666-0000-0000-0000-000000000000 | yes              |
          | 77777777-0000-0000-0000-000000000000 | yes              |
          | 88888888-0000-0000-0000-000000000000 | yes              |
          | 99999999-0000-0000-0000-000000000000 | yes              |
     When user look at top right pagination widget
     Then it should display text "1-10 of 12"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user click on ">" arrow on the pagination widget
     Then "Affected clusters" table needs to be refreshed to
          | Name                                 | Clickable (link) |
          | aaaaaaaa-0000-0000-0000-000000000000 | yes              |
          | bbbbbbbb-0000-0000-0000-000000000000 | yes              |
     When user look at top right pagination widget
     Then it should display text "11-12 of 12"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | yes       |
          | >     | no        |
