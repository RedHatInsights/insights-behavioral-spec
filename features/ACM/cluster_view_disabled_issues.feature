Feature: Cluster view with issues on ACM UI in case some or all issues are disabled in Insights Advisor


  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue and 1 issue disabled in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 1 critical issue is detected for this cluster: PROMETHEUS_DB_VOLUME_IS_EMPTY
      And 1 other issue #2 is detected for this cluster
      And issue #2 is disabled in Insights Advisor
      And the user USER1 is already logged in into Advanced Cluster Management
     When user looks at Advanced Cluster Management main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item      | Required for this test |
          | Home                | yes                    |
          | Infrastructure      | no                     |
          | Applications        | no                     |
          | Governance          | no                     |
          | Credential          | no                     |
          | Visual Web Terminal | no                     |
     When user expand "Home" top level item
     Then the menu should be expanded under "Home" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of the left menu bar
      And several sections needs to be placed on the page
          | Section             | Required for this test |
          | AWS Amazon          | yes                    |
          | Summary             | yes                    |
          | Cluster compliance  | no                     |
          | Pods                | no                     |
          | Cluster status      | no                     |
          | Cluster issues      | yes                    |
      And "AWS Amazon" section should say "1 cluster"
     When I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 1"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 1      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "1" in the centre
      And should contain just red arc
