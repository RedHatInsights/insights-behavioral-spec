Feature: Cluster issues section on Overview page on ACM UI in case some or all issues are disabled in Insights Advisor

  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 already disabled issue with low severity
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 1 issue is detected for this cluster
      And 1 issue is disabled in Insights Advisor
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "0" in the centre



  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 issue with low severity that is being disabled in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 1 low issue is detected for this cluster
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 1      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "1" in the centre
      And should contain just blue arc
     When the issue is disabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "0" in the centre



  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 issue with low severity that is being enabled in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 1 low issue is detected for this cluster
      And that issue is disabled in Insights Advisor
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "0" in the centre
     When the issue is enabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 1"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 1      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "1" in the centre
      And should contain just blue arc



  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues, that are being disabled in Insights Advisor in one time
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 2 low issues are detected for this cluster
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
     Then I should see a label saying "Cluster issues 2"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 2      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "2" in the centre
      And should contain just blue arc
     When issue #1 is disabled in Insights Advisor
      And issue #2 is disabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |



  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues, that are being disabled in Insights Advisor one by one
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 2 low issues are detected for this cluster
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
     Then I should see a label saying "Cluster issues 2"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 2      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "2" in the centre
      And should contain just blue arc
     When issue #1 is disabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 1"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 1      | blue   |
     When issue #2 is disabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "0" in the centre



  Scenario: Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues with low severity that is being enabled in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 2 issues are detected for this cluster
      And 2 issues are disabled in Insights Advisor
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
     Then the menu should be expanded
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Welcome             | no                     |
          | Overview            | yes                    |
     When user select "Overview" menu item from this sub-menu
     Then an "Overview" page should be displayed right of menu
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
     Then I should see a label saying "Cluster issues 0"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "0" in the centre
     When the issue #1 is enabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 1"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 1      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "1" in the centre
      And should contain just blue arc
     When the issue #2 is enabled in Insights Advisor
      And I look into "Cluster issues" section
     Then I should see a label saying "Cluster issues 2"
      And I should see a table with issue counters
      And I should see a donut chart representing issue counts splitted by risk
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 0      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 2      | blue   |
     When I look at a donut chart representing issue counts
     Then the donut chart should display "2" in the centre
      And should contain just blue arc
