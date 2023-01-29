Feature: Pagination feature in Advisor recommendations page on Hybrid Cloud Console


  Scenario: Pagination widgets displayed in Advisor recommendations page on Hybrid Cloud Console
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 30 issues are detected for this cluster
          | Title    | Modified    | Category | Total risk | Risk of change |
          | Bug01    | 10 days ago | Security | Important  | High           |
          | Bug02    | 10 days ago | Security | Important  | High           |
          | Bug03    | 10 days ago | Security | Important  | High           |
          | Bug04    | 10 days ago | Security | Important  | High           |
          | Bug05    | 10 days ago | Security | Important  | High           |
          | Bug06    | 10 days ago | Security | Important  | High           |
          | Bug07    | 10 days ago | Security | Important  | High           |
          | Bug08    | 10 days ago | Security | Important  | High           |
          | Bug09    | 10 days ago | Security | Important  | High           |
          | Bug10    | 10 days ago | Security | Important  | High           |
          | Bug11    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug12    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug13    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug14    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug15    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug16    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug17    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug18    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug19    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug20    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug21    | 10 days ago | Security | Low        | Very Low       |
          | Bug22    | 10 days ago | Security | Low        | Very Low       |
          | Bug23    | 10 days ago | Security | Low        | Very Low       |
          | Bug24    | 10 days ago | Security | Low        | Very Low       |
          | Bug25    | 10 days ago | Security | Low        | Very Low       |
          | Bug26    | 10 days ago | Security | Low        | Very Low       |
          | Bug27    | 10 days ago | Security | Low        | Very Low       |
          | Bug28    | 10 days ago | Security | Low        | Very Low       |
          | Bug29    | 10 days ago | Security | Low        | Very Low       |
          | Bug30    | 10 days ago | Security | Low        | Very Low       |
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
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user look at bottom right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | no        |
          | <     | no        |
          | >     | yes       |
          | >>    | yes       |
     When user clicks on the expand icon on top right pagination widget
     Then following context menu should be displayed
          | Menu item    | Checked |
          | 10 per page  | no      |
          | 20 per page  | yes     |
          | 50 per page  | no      |
          | 100 per page | no      |
     When user clicks on the expand icon on bottom right pagination widget
     Then following context menu should be displayed
          | Menu item    | Checked |
          | 10 per page  | no      |
          | 20 per page  | yes     |
          | 50 per page  | no      |
          | 100 per page | no      |



  Scenario: Goto to next page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 30 issues are detected for this cluster
          | Title    | Modified    | Category | Total risk | Risk of change |
          | Bug01    | 10 days ago | Security | Important  | High           |
          | Bug02    | 10 days ago | Security | Important  | High           |
          | Bug03    | 10 days ago | Security | Important  | High           |
          | Bug04    | 10 days ago | Security | Important  | High           |
          | Bug05    | 10 days ago | Security | Important  | High           |
          | Bug06    | 10 days ago | Security | Important  | High           |
          | Bug07    | 10 days ago | Security | Important  | High           |
          | Bug08    | 10 days ago | Security | Important  | High           |
          | Bug09    | 10 days ago | Security | Important  | High           |
          | Bug10    | 10 days ago | Security | Important  | High           |
          | Bug11    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug12    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug13    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug14    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug15    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug16    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug17    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug18    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug19    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug20    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug21    | 10 days ago | Security | Low        | Very Low       |
          | Bug22    | 10 days ago | Security | Low        | Very Low       |
          | Bug23    | 10 days ago | Security | Low        | Very Low       |
          | Bug24    | 10 days ago | Security | Low        | Very Low       |
          | Bug25    | 10 days ago | Security | Low        | Very Low       |
          | Bug26    | 10 days ago | Security | Low        | Very Low       |
          | Bug27    | 10 days ago | Security | Low        | Very Low       |
          | Bug28    | 10 days ago | Security | Low        | Very Low       |
          | Bug29    | 10 days ago | Security | Low        | Very Low       |
          | Bug30    | 10 days ago | Security | Low        | Very Low       |
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
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user click on ">" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 10 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug21 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug22 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug23 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug24 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug25 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug26 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug27 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug28 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug29 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug30 | 10 days ago | Security | Low        | Very Low       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | yes       |
          | >     | no        |
     When user look at bottom right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | yes       |
          | <     | yes       |
          | >     | no        |
          | >>    | no        |



  Scenario: Goto to last page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 30 issues are detected for this cluster
          | Title    | Modified    | Category | Total risk | Risk of change |
          | Bug01    | 10 days ago | Security | Important  | High           |
          | Bug02    | 10 days ago | Security | Important  | High           |
          | Bug03    | 10 days ago | Security | Important  | High           |
          | Bug04    | 10 days ago | Security | Important  | High           |
          | Bug05    | 10 days ago | Security | Important  | High           |
          | Bug06    | 10 days ago | Security | Important  | High           |
          | Bug07    | 10 days ago | Security | Important  | High           |
          | Bug08    | 10 days ago | Security | Important  | High           |
          | Bug09    | 10 days ago | Security | Important  | High           |
          | Bug10    | 10 days ago | Security | Important  | High           |
          | Bug11    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug12    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug13    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug14    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug15    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug16    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug17    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug18    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug19    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug20    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug21    | 10 days ago | Security | Low        | Very Low       |
          | Bug22    | 10 days ago | Security | Low        | Very Low       |
          | Bug23    | 10 days ago | Security | Low        | Very Low       |
          | Bug24    | 10 days ago | Security | Low        | Very Low       |
          | Bug25    | 10 days ago | Security | Low        | Very Low       |
          | Bug26    | 10 days ago | Security | Low        | Very Low       |
          | Bug27    | 10 days ago | Security | Low        | Very Low       |
          | Bug28    | 10 days ago | Security | Low        | Very Low       |
          | Bug29    | 10 days ago | Security | Low        | Very Low       |
          | Bug30    | 10 days ago | Security | Low        | Very Low       |
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
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at bottom right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | no        |
          | <     | no        |
          | >     | yes       |
          | >>    | yes       |
     When user click on ">>" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 10 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug21 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug22 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug23 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug24 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug25 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug26 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug27 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug28 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug29 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug30 | 10 days ago | Security | Low        | Very Low       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | yes       |
          | >     | no        |
     When user look at bottom right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | yes       |
          | <     | yes       |
          | >     | no        |
          | >>    | no        |



  Scenario: Goto to previous page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 30 issues are detected for this cluster
          | Title    | Modified    | Category | Total risk | Risk of change |
          | Bug01    | 10 days ago | Security | Important  | High           |
          | Bug02    | 10 days ago | Security | Important  | High           |
          | Bug03    | 10 days ago | Security | Important  | High           |
          | Bug04    | 10 days ago | Security | Important  | High           |
          | Bug05    | 10 days ago | Security | Important  | High           |
          | Bug06    | 10 days ago | Security | Important  | High           |
          | Bug07    | 10 days ago | Security | Important  | High           |
          | Bug08    | 10 days ago | Security | Important  | High           |
          | Bug09    | 10 days ago | Security | Important  | High           |
          | Bug10    | 10 days ago | Security | Important  | High           |
          | Bug11    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug12    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug13    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug14    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug15    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug16    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug17    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug18    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug19    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug20    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug21    | 10 days ago | Security | Low        | Very Low       |
          | Bug22    | 10 days ago | Security | Low        | Very Low       |
          | Bug23    | 10 days ago | Security | Low        | Very Low       |
          | Bug24    | 10 days ago | Security | Low        | Very Low       |
          | Bug25    | 10 days ago | Security | Low        | Very Low       |
          | Bug26    | 10 days ago | Security | Low        | Very Low       |
          | Bug27    | 10 days ago | Security | Low        | Very Low       |
          | Bug28    | 10 days ago | Security | Low        | Very Low       |
          | Bug29    | 10 days ago | Security | Low        | Very Low       |
          | Bug30    | 10 days ago | Security | Low        | Very Low       |
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
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user click on ">" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 10 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug21 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug22 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug23 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug24 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug25 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug26 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug27 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug28 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug29 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug30 | 10 days ago | Security | Low        | Very Low       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | yes       |
          | >     | no        |
     When user look at bottom right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | yes       |
          | <     | yes       |
          | >     | no        |
          | >>    | no        |
     When user click on "<" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user look at bottom right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | no        |
          | <     | no        |
          | >     | yes       |
          | >>    | yes       |



  Scenario: Goto to first page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And 30 issues are detected for this cluster
          | Title    | Modified    | Category | Total risk | Risk of change |
          | Bug01    | 10 days ago | Security | Important  | High           |
          | Bug02    | 10 days ago | Security | Important  | High           |
          | Bug03    | 10 days ago | Security | Important  | High           |
          | Bug04    | 10 days ago | Security | Important  | High           |
          | Bug05    | 10 days ago | Security | Important  | High           |
          | Bug06    | 10 days ago | Security | Important  | High           |
          | Bug07    | 10 days ago | Security | Important  | High           |
          | Bug08    | 10 days ago | Security | Important  | High           |
          | Bug09    | 10 days ago | Security | Important  | High           |
          | Bug10    | 10 days ago | Security | Important  | High           |
          | Bug11    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug12    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug13    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug14    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug15    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug16    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug17    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug18    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug19    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug20    | 10 days ago | Security | Moderate   | Moderate       |
          | Bug21    | 10 days ago | Security | Low        | Very Low       |
          | Bug22    | 10 days ago | Security | Low        | Very Low       |
          | Bug23    | 10 days ago | Security | Low        | Very Low       |
          | Bug24    | 10 days ago | Security | Low        | Very Low       |
          | Bug25    | 10 days ago | Security | Low        | Very Low       |
          | Bug26    | 10 days ago | Security | Low        | Very Low       |
          | Bug27    | 10 days ago | Security | Low        | Very Low       |
          | Bug28    | 10 days ago | Security | Low        | Very Low       |
          | Bug29    | 10 days ago | Security | Low        | Very Low       |
          | Bug30    | 10 days ago | Security | Low        | Very Low       |
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
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user click on ">" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 10 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug21 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug22 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug23 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug24 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug25 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug26 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug27 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug28 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug29 | 10 days ago | Security | Low        | Very Low       | 1        |
          | Bug30 | 10 days ago | Security | Low        | Very Low       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | yes       |
          | >     | no        |
     When user look at bottom right pagination widget
     Then it should display text "21 - 30 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | yes       |
          | <     | yes       |
          | >     | no        |
          | >>    | no        |
     When user click on "<<" arrow on the pagination widget
     Then table with recommendations should be refreshed with new content
      And that table should contain the following 20 rows
          | Name  | Modified    | Category | Total risk | Risk of change | Clusters |
          | Bug01 | 10 days ago | Security | Important  | High           | 1        |
          | Bug02 | 10 days ago | Security | Important  | High           | 1        |
          | Bug03 | 10 days ago | Security | Important  | High           | 1        |
          | Bug04 | 10 days ago | Security | Important  | High           | 1        |
          | Bug05 | 10 days ago | Security | Important  | High           | 1        |
          | Bug06 | 10 days ago | Security | Important  | High           | 1        |
          | Bug07 | 10 days ago | Security | Important  | High           | 1        |
          | Bug08 | 10 days ago | Security | Important  | High           | 1        |
          | Bug09 | 10 days ago | Security | Important  | High           | 1        |
          | Bug10 | 10 days ago | Security | Important  | High           | 1        |
          | Bug11 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug12 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug13 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug14 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug15 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug16 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug17 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug18 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug19 | 10 days ago | Security | Moderate   | Moderate       | 1        |
          | Bug20 | 10 days ago | Security | Moderate   | Moderate       | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | >     | yes       |
     When user look at bottom right pagination widget
     Then it should display text "1 - 20 of 30"
      And expand icon should be displayed right-of this text
      And four page arrows should be displayed as well
          | Arrow | Clickable |
          | <<    | no        |
          | <     | no        |
          | >     | yes       |
          | >>    | yes       |
