Feature: Clusters view page with recommendations behaviour on Hybrid Cloud Console should show the cluster version


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
            | Clusters           | yes                    |
            | Recommendations    | no                     |
        When user select "Clusters" menu item from this sub-menu
        Then an "Advisor clusters" page should be displayed right of the left menu bar
        And widget with filter settings should be displayed
        And table with several columns should be displayed
            | Column name     |
            | Name            |
            | Version         |
            | Recommendations |
            | Critical        |
            | Important       |
            | Moderate        |
            | Low             |
            | Last Seen       |
        And that table should contain at least one row
            | Column name     | Value                                |
            | Name            | 00000000-0000-0000-0000-000000000000 |
            | Version         | 0.0                                  |
            | Recommendations | 1                                    |
            | Critical        | 0                                    |
            | Important       | 1                                    |
            | Moderate        | 0                                    |
            | Low             | 0                                    |
