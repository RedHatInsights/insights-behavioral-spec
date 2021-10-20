Feature: Link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI


  Scenario: Using link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And exactly 1 critical issue has been detected for this cluster
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issue found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window named "Insights Advisor status" should appear
      And graph saying "1 total issue" should be displayed in this window
      And following table should be displayed left-of the graph
          | # | Total risk |
          | 1 | Critical   |
          | 0 | Important  |
          | 0 | Moderate   |
          | 0 | Low        |
      And a section named "Fixable issues" should be shown below graph and a table
      And that section should contain a link named "View all in OpenShift Cluster Manager"
     When user U1 click on a link named "View all in OpenShift Cluster Manager"
     Then a page with detailed information about the selected cluster should be displayed
      And at least four tab headers should be displayed on that page
          | Tab name         |
          | Overview         |
          | Monitoring       |
          | Insights Advisor |
          | Support          |
      And following sections should be displayed below four tab headers
          | Section name            |
          | Details                 |
          | Resource usage          |
          | Advisor recommendations |
          | Cluster history         |
     When I look into "Advisor recommendations" section
     Then I should see a label saying "1 issue"
      And issue counters should display
          | Risk      | Number |
          | Critical  | 1      |
          | Important | 0      |
          | Moderate  | 0      |
          | Low       | 0      |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed
