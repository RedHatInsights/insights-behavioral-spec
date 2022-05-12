Feature: Recommendations view page with recommendations behaviour on Hybrid Cloud Console should show the cluster version


    Scenario: Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster should show the cluster version
        Given user USER1 is part of account (organization) ACCOUNT1
        And account (organization) ACCOUNT1 owns 1 cluster
            | Cluster name                         | Version |
            | 00000000-0000-0000-0000-000000000000 | 0.0     |
        And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
            | Title    | Added       | Total risk | Likelihood | Impact |
            | Bug12345 | 10 days ago | Important  | high       | high   |
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
            | Expanded menu item | Required for this test |
            | Clusters           | no                     |
            | Recommendations    | yes                    |
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
        When user clicks on an "Bug1234" link
        Then new page with additional information about selected recommendation should be displayed
        And the following values needs to be displayed
            | Value type  | Content             | Displayed as              |
            | Description | Textual description | Text                      |
            | KB article  | Link to KB article  | Link                      |
            | Total risk  | Important           | Widget (icon+label)       |
            | Likelihood  | High                | Widget (thermometer-like) |
            | Impact      | High                | Widget (thermometer-like) |
        And "Affected clusters" table needs to be displayed below additional info
            | Name                                 | Clickable (link) | Version |
            | 00000000-0000-0000-0000-000000000000 | yes              | 0.0     |
        And paging widget should say "1-1 of 1"


    Scenario: Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters should show the cluster version
        Given user USER1 is part of account (organization) ACCOUNT1
        And account (organization) ACCOUNT1 owns 2 clusters
            | Cluster name                         | Version |
            | 00000000-0000-0000-0000-000000000000 | 0.0     |
            | 11111111-0000-0000-0000-000000000000 |         |
        And 1 issue is detected for cluster 00000000-0000-0000-0000-000000000000
            | Title    | Added       | Total risk | Likelihood | Impact |
            | Bug12345 | 10 days ago | Important  | high       | high   |
        And 1 issue is detected for cluster 11111111-0000-0000-0000-000000000000
            | Title    | Added       | Total risk | Likelihood | Impact |
            | Bug12345 | 10 days ago | Important  | high       | high   |
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
            | Expanded menu item | Required for this test |
            | Clusters           | no                     |
            | Recommendations    | yes                    |
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
            | Clusters    | 2           |
        When user clicks on an "Bug1234" link
        Then new page with additional information about selected recommendation should be displayed
        And the following values needs to be displayed
            | Value type  | Content             | Displayed as              |
            | Description | Textual description | Text                      |
            | KB article  | Link to KB article  | Link                      |
            | Total risk  | Important           | Widget (icon+label)       |
            | Likelihood  | High                | Widget (thermometer-like) |
            | Impact      | High                | Widget (thermometer-like) |
        And "Affected clusters" table needs to be displayed below additional info
            | Name                                 | Clickable (link) | Version |
            | 00000000-0000-0000-0000-000000000000 | yes              | 0.0     |
            | 11111111-0000-0000-0000-000000000000 | yes              | N/A     |
        And paging widget should say "1-2 of 2"


    Scenario: Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters should show the cluster version
        Given user USER1 is part of account (organization) ACCOUNT1
        And account (organization) ACCOUNT1 owns 2 clusters
            | Cluster name                         | Version |
            | 00000000-0000-0000-0000-000000000000 | 0.0     |
            | 11111111-0000-0000-0000-000000000000 | 1.0     |
            | 22222222-0000-0000-0000-000000000000 | 2.0     |
            | 33333333-0000-0000-0000-000000000000 | 3.0     |
            | 44444444-0000-0000-0000-000000000000 | 4.0     |
            | 55555555-0000-0000-0000-000000000000 | 5.0     |
            | 66666666-0000-0000-0000-000000000000 | 6.0     |
            | 77777777-0000-0000-0000-000000000000 | 7.0     |
            | 88888888-0000-0000-0000-000000000000 | 8.0     |
            | 99999999-0000-0000-0000-000000000000 | 9.0     |
            | aaaaaaaa-0000-0000-0000-000000000000 | a.0     |
            | bbbbbbbb-0000-0000-0000-000000000000 | b.0     |
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
            | Expanded menu item | Required for this test |
            | Clusters           | no                     |
            | Recommendations    | yes                    |
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
            | Clusters    | 12          |
        When user clicks on an "Bug1234" link
        Then new page with additional information about selected recommendation should be displayed
        And the following values needs to be displayed
            | Value type  | Content             | Displayed as              |
            | Description | Textual description | Text                      |
            | KB article  | Link to KB article  | Link                      |
            | Total risk  | Important           | Widget (icon+label)       |
            | Likelihood  | High                | Widget (thermometer-like) |
            | Impact      | High                | Widget (thermometer-like) |
        And "Affected clusters" table needs to be displayed below additional info
            | Name                                 | Clickable (link) | Version |
            | 00000000-0000-0000-0000-000000000000 | yes              | 0.0     |
            | 11111111-0000-0000-0000-000000000000 | yes              | 1.0     |
            | 00000000-0000-0000-0000-000000000000 | yes              | 0.0     |
            | 11111111-0000-0000-0000-000000000000 | yes              | 1.0     |
            | 22222222-0000-0000-0000-000000000000 | yes              | 2.0     |
            | 33333333-0000-0000-0000-000000000000 | yes              | 3.0     |
            | 44444444-0000-0000-0000-000000000000 | yes              | 4.0     |
            | 55555555-0000-0000-0000-000000000000 | yes              | 5.0     |
            | 66666666-0000-0000-0000-000000000000 | yes              | 6.0     |
            | 77777777-0000-0000-0000-000000000000 | yes              | 7.0     |
            | 88888888-0000-0000-0000-000000000000 | yes              | 8.0     |
            | 99999999-0000-0000-0000-000000000000 | yes              | 9.0     |
        When user look at top right pagination widget
        Then it should display text "1-10 of 12"
        And expand icon should be displayed right-of this text
        And two page arrows should be displayed as well
            | Arrow | Clickable |
            | <     | no        |
            | >     | yes       |
        When user click on ">" arrow on the pagination widget
        Then "Affected clusters" table needs to be refreshed to
            | Name                                 | Clickable (link) | Version |
            | aaaaaaaa-0000-0000-0000-000000000000 | yes              | a.0     |
            | bbbbbbbb-0000-0000-0000-000000000000 | yes              | b.0     |
        When user look at top right pagination widget
        Then it should display text "11-12 of 12"
        And expand icon should be displayed right-of this text
        And two page arrows should be displayed as well
            | Arrow | Clickable |
            | <     | yes       |
            | >     | no        |
