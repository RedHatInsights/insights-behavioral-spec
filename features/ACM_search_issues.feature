Feature: Search for issues


  Scenario: Ability to search for issues on Advanced Cluster Management for one local cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one local cluster
      And that local cluster should be in Ready state
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
          | Name           | local-cluster-policyreport    |
          | Scope          | local-cluster                 |
          | Critical       | 1                             |
          | Important      | 0                             |
          | Moderate       | 0                             |
          | Low            | 0                             |
          | Rules          | PROMETHEUS_DB_VOLUME_IS_EMPTY |
          | Categories     | service_availability          |


  Scenario: Ability to search for issues on Advanced Cluster Management for one managed cluster
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
