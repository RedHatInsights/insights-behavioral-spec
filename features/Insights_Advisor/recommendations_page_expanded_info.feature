Feature: Advisor recommendations page behaviour on Hybrid Cloud Console - expanding information about selected recommendation


  Scenario: Displaying expanded information about selected recommendation with high likelihood and high impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 1 issue is detected for this cluster
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
          | Name           | Bug12345     |
          | Modified       | 10 days ago |
          | Category       | Security    |
          | Total risk     | Important   |
          | Risk of change | Moderate    |
          | Clusters       | 1           |
      And an "expand" arrow should be displayed before recommendation name
      And the "expand" arrow should point to east
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
      And the "expand" arrow should point to south
     When user looks at expanded information
     Then the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Important           | Widget (icon+label)       | no       |
          | Likelihood     | High                | Widget (thermometer-like) | no       |
          | Impact         | High                | Widget (thermometer-like) | no       |
          | Risk of change | Moderate            | Widget (icon+label)       | no       |
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be hidden
      And the "expand" arrow should point to east


  Scenario: Displaying expanded information about selected recommendation with medium likelihood and low impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 1 issue is detected for this cluster
          | Title    | Modified    | Category | Total risk | Likelihood | Impact | Risk of change |
          | Bug12345 | 10 days ago | Security | Low        | medium     | low    | Very Low       |
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
          | Name           | Bug12345     |
          | Modified       | 10 days ago |
          | Category       | Security    |
          | Total risk     | Low         |
          | Risk of change | Very Low    |
          | Clusters       | 1           |
      And an "expand" arrow should be displayed before recommendation name
      And the "expand" arrow should point to east
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
      And the "expand" arrow should point to south
     When user looks at expanded information
     Then the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Low                 | Widget (icon+label)       | no       |
          | Likelihood     | Medium              | Widget (thermometer-like) | no       |
          | Impact         | Low                 | Widget (thermometer-like) | no       |
          | Risk of change | Very Low            | Widget (icon+label)       | no       |
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be hidden
      And the "expand" arrow should point to east


  Scenario: Displaying expanded information about selected recommendation with critical likelihood and low impact
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 1 issue is detected for this cluster
          | Title    | Modified    | Category    | Total risk | Likelihood | Impact | Risk of change |
          | Bug12345 | 10 days ago | Performance | Moderate   | medium     | low    | Low            |
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
          | Name           | Bug12345     |
          | Modified       | 10 days ago |
          | Category       | Performance |
          | Total risk     | Moderate    |
          | Risk of change | Low         |
          | Clusters       | 1           |
      And an "expand" arrow should be displayed before recommendation name
      And the "expand" arrow should point to east
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be displayed below a row with recommendation info
     When user looks at expanded information
      And the "expand" arrow should point to south
     Then the following values needs to be displayed
          | Value type     | Content             | Displayed as              | Optional |
          | Description    | Textual description | Text                      | no       |
          | KB article     | Link to KB article  | Link                      | yes      |
          | Total risk     | Moderate            | Widget (icon+label)       | no       |
          | Likelihood     | Medium              | Widget (thermometer-like) | no       |
          | Impact         | Low                 | Widget (thermometer-like) | no       |
          | Risk of change | Low                 | Widget (icon+label)       | no       |
     When user clicks on an "expand" arrow
     Then additional information about selected recommendation should be hidden
      And the "expand" arrow should point to east
