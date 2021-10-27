Feature: Cluster view with issues on ACM UI


  Scenario: Displaying description of recommendation found for 1 cluster with 1 critical issue
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And the infrastructure for that managed cluster is provided by Amazon Web Services
      And that managed cluster should be in Ready state
      And 1 critical issue is detected for this cluster: PROMETHEUS_DB_VOLUME_IS_EMPTY
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
     When I click on label saying "1 Critical"
     Then I should be redirected into Search page
      And Search entry box should contain the following two tags
          | Tag               |
          | kind policyreport |
          | critical>0        |
      And Result section should say "1 Related cluster"
      And Policyreport section should display 1 (number of reports)
      And table with reports needs to be displayed
     When I look at a table with reports
     Then the table should contain precisely one line
      And the attributes on the line should have the following names and values
          | Attribute name | Attribute value               |
          | Name           | mc-rmg-policyreport           |
          | Scope          | mc-rmg                        |
          | Critical       | 1                             |
          | Important      | 0                             |
          | Moderate       | 0                             |
          | Low            | 0                             |
          | Rules          | PROMETHEUS_DB_VOLUME_IS_EMPTY |
          | Categories     | service_availability          |
     When I click on name of policyreport
     Then cluster details page should be displayed
      And the left menu should be changed - Clusters item needs to be selected
      And popup window saying "1 identified issues" should be displayed on right side
     When I look at cluster detils page
     Then I should see cluster name at top
      And following tabs headers needs to be available
          | Tab header | Required for this test |
          | Overview   | yes                    |
          | Nodes      | no                     |
          | Add-ons    | no                     |
     When I look at popup window saying "1 identified issues"
     Then I should see a donut chart representing issue counts splitted by risk
      And I should see a table with issue counters
      And I should see a table with following columns
          | Column name |
          | Description |
          | Category    |
          | Total risk  |
     When I look at donut chart
     Then the donut chart should display "1" in the centre
      And should contain just red arc
     When I look at a table with issue counters
     Then issue counters should display
          | Severity  | Number | Color  |
          | Critical  | 1      | red    |
          | Important | 0      | orange |
          | Moderate  | 0      | yellow |
          | Low       | 0      | blue   |
     When I look at a table with recommendations
     Then I should see just one line
          | Column name | Value                             |
          | Description | PROMETHEUS_DB_VOLUME_IS_EMPTY:... |
          | Category    | service_availability              |
          | Total risk  | 2                                 |
     When I click on the recommendation description
     Then a new page with detailed description of recommendation should be displayed
      And that page should be splitted into several sections
          | Section                         | Content              |
          | Recommendation description text | one sentence         |
          | Total risk widget               | Moderate + info      |
          | Category widget                 | service_availability |
          | Matched on widget               | timestamp            |
          | How to remediate tab            | clickable tab header |
          | Reason tab                      | clickable tab header |
     When I click on tab header "How to remediate"
     Then I should see text with remediation text
      And I should see optional links to pages with detailed info
     When I click on tab header "Reason"
     Then I should see text with reasons
