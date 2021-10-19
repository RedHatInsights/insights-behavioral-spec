Feature: Cluster overview page on OCM UI

  Scenario: Display cluster overview page on OCM UI for cluster w/o any issues
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent the data to CCX data pipeline
      And no issues have been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
      And the page should contain at least one cluster
      And button "Create cluster" should be made visible
      And button "Register cluster" should be made visible
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And at least four tab headers should be displayed on that page
          | Tab name         |
          | Overview         |
          | Monitoring       |
          | Insights Advisor |
          | Support          |
      And following sectios should be displayed below four tab headers
          | Section name            |
          | Details                 |
          | Resource usage          |
          | Advisor recommendations |
          | Cluster history         |
     When I look into "Advisor recommendations" section
     Then I should see a label saying "0 issues"
      And issue counters should display
          | Risk      | Number |
          | Critical  | 0      |
          | Important | 0      |
          | Moderate  | 0      |
          | Low       | 0      |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed


  Scenario: Display cluster overview page on OCM UI for cluster with one critical issue
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent the data to CCX data pipeline
      And 1 critical issue has been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
      And the page should contain at least one cluster
      And button "Create cluster" should be made visible
      And button "Register cluster" should be made visible
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And at least four tab headers should be displayed on that page
          | Tab name         |
          | Overview         |
          | Monitoring       |
          | Insights Advisor |
          | Support          |
      And following sectios should be displayed below four tab headers
          | Section name            |
          | Details                 |
          | Resource usage          |
          | Advisor recommendations |
          | Cluster history         |
     When I look into "Advisor recommendations" section
     Then I should see a graph saying "1 total issue"
      And issue counters should display
          | Risk      | Number |
          | Critical  | 1      |
          | Important | 0      |
          | Moderate  | 0      |
          | Low       | 0      |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed


  Scenario: Display cluster overview page on OCM UI for cluster with one critical issue and one low issue
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent the data to CCX data pipeline
      And 1 critical issue has been detected for cluster C1
      And 1 low issue has been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
      And the page should contain at least one cluster
      And button "Create cluster" should be made visible
      And button "Register cluster" should be made visible
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And at least four tab headers should be displayed on that page
          | Tab name         |
          | Overview         |
          | Monitoring       |
          | Insights Advisor |
          | Support          |
      And following sectios should be displayed below four tab headers
          | Section name            |
          | Details                 |
          | Resource usage          |
          | Advisor recommendations |
          | Cluster history         |
     When I look into "Advisor recommendations" section
     Then I should see a graph saying "2 total issues"
      And issue counters should display
          | Risk      | Number |
          | Critical  | 1      |
          | Important | 0      |
          | Moderate  | 0      |
          | Low       | 1      |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed


  Scenario: Display cluster overview page on OCM UI for cluster with two moderate issues
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent the data to CCX data pipeline
      And 2 moderate issues have been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
      And the page should contain at least one cluster
      And button "Create cluster" should be made visible
      And button "Register cluster" should be made visible
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And at least four tab headers should be displayed on that page
          | Tab name         |
          | Overview         |
          | Monitoring       |
          | Insights Advisor |
          | Support          |
      And following sectios should be displayed below four tab headers
          | Section name            |
          | Details                 |
          | Resource usage          |
          | Advisor recommendations |
          | Cluster history         |
     When I look into "Advisor recommendations" section
     Then I should see a graph saying "2 total issues"
      And issue counters should display
          | Risk      | Number |
          | Critical  | 0      |
          | Important | 0      |
          | Moderate  | 2      |
          | Low       | 0      |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed
