Feature: Pagination feature in Advisor recommendations page on Hybrid Cloud Console


  Scenario: Pagination widgets displayed in Advisor recommendations page on Hybrid Cloud Console
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one cluster
      And 30 issues are detected for this cluster
          | Title    | Added       | Total risk |
          | Bug01    | 10 days ago | Important  |
          | Bug02    | 10 days ago | Important  |
          | Bug03    | 10 days ago | Important  |
          | Bug04    | 10 days ago | Important  |
          | Bug05    | 10 days ago | Important  |
          | Bug06    | 10 days ago | Important  |
          | Bug07    | 10 days ago | Important  |
          | Bug08    | 10 days ago | Important  |
          | Bug09    | 10 days ago | Important  |
          | Bug10    | 10 days ago | Important  |
          | Bug11    | 10 days ago | Moderate   |
          | Bug12    | 10 days ago | Moderate   |
          | Bug13    | 10 days ago | Moderate   |
          | Bug14    | 10 days ago | Moderate   |
          | Bug15    | 10 days ago | Moderate   |
          | Bug16    | 10 days ago | Moderate   |
          | Bug17    | 10 days ago | Moderate   |
          | Bug18    | 10 days ago | Moderate   |
          | Bug19    | 10 days ago | Moderate   |
          | Bug20    | 10 days ago | Moderate   |
          | Bug21    | 10 days ago | Low        |
          | Bug22    | 10 days ago | Low        |
          | Bug23    | 10 days ago | Low        |
          | Bug24    | 10 days ago | Low        |
          | Bug25    | 10 days ago | Low        |
          | Bug26    | 10 days ago | Low        |
          | Bug27    | 10 days ago | Low        |
          | Bug28    | 10 days ago | Low        |
          | Bug29    | 10 days ago | Low        |
          | Bug30    | 10 days ago | Low        |
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
      And that table should contain the following 20 rows
          | Name  | Added       | Total risk | Clusters |
          | Bug01 | 10 days ago | Important  | 1        |
          | Bug02 | 10 days ago | Important  | 1        |
          | Bug03 | 10 days ago | Important  | 1        |
          | Bug04 | 10 days ago | Important  | 1        |
          | Bug05 | 10 days ago | Important  | 1        |
          | Bug06 | 10 days ago | Important  | 1        |
          | Bug07 | 10 days ago | Important  | 1        |
          | Bug08 | 10 days ago | Important  | 1        |
          | Bug09 | 10 days ago | Important  | 1        |
          | Bug10 | 10 days ago | Important  | 1        |
          | Bug11 | 10 days ago | Moderate   | 1        |
          | Bug12 | 10 days ago | Moderate   | 1        |
          | Bug13 | 10 days ago | Moderate   | 1        |
          | Bug14 | 10 days ago | Moderate   | 1        |
          | Bug15 | 10 days ago | Moderate   | 1        |
          | Bug16 | 10 days ago | Moderate   | 1        |
          | Bug17 | 10 days ago | Moderate   | 1        |
          | Bug18 | 10 days ago | Moderate   | 1        |
          | Bug19 | 10 days ago | Moderate   | 1        |
          | Bug20 | 10 days ago | Moderate   | 1        |
      And pagination widget needs to be displayed in the top right corner
      And pagination widget needs to be displayed in the bottom right
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 25"
      And expand icon should be displayed right-of this text
      And two page arrows should be displayed as well
          | Arrow | Clickable |
          | <     | no        |
          | <     | yes       |
     When user look at top right pagination widget
     Then it should display text "1 - 20 of 25"
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
