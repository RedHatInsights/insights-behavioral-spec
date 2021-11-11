Feature: Advisor recommendations page behaviour on Hybrid Cloud Console - expanding information about selected recommendation


  Scenario: Displaying expanded information about selected recommendation with high likelihood and high impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 1 issue is detected for this cluster
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
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Important   |
          | Clusters    | 1           |
      And an "expand" arrow should be displayed before recommendation name
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
     When user looks at expanded information
     Then the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Important           | Widget (icon+label)       |
          | Likelihood  | High                | Widget (thermometer-like) |
          | Impact      | High                | Widget (thermometer-like) |


  Scenario: Displaying expanded information about selected recommendation with medium likelihood and low impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 1 issue is detected for this cluster
          | Title    | Added       | Total risk | Likelihood | Impact |
          | Bug12345 | 10 days ago | Low        | medium     | low    |
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
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Low         |
          | Clusters    | 1           |
      And an "expand" arrow should be displayed before recommendation name
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
     When user looks at expanded information
     Then the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Low                 | Widget (icon+label)       |
          | Likelihood  | Medium              | Widget (thermometer-like) |
          | Impact      | Low                 | Widget (thermometer-like) |


  Scenario: Displaying expanded information about selected recommendation with critical likelihood and low impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 1 issue is detected for this cluster
          | Title    | Added       | Total risk | Likelihood | Impact |
          | Bug12345 | 10 days ago | Moderate   | medium     | low    |
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
      And that table should contain at least one row
          | Column name | Value       |
          | Name        | Bug1234     |
          | Added       | 10 days ago |
          | Total risk  | Low         |
          | Clusters    | 1           |
      And an "expand" arrow should be displayed before recommendation name
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
     When user looks at expanded information
     Then the following values needs to be displayed
          | Value type  | Content             | Displayed as              |
          | Description | Textual description | Text                      |
          | KB article  | Link to KB article  | Link                      |
          | Total risk  | Moderate            | Widget (icon+label)       |
          | Likelihood  | Critical            | Widget (thermometer-like) |
          | Impact      | Low                 | Widget (thermometer-like) |
