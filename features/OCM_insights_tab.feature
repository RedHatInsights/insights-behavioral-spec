Feature: Insights tab on OCM UI

  Scenario: Insights tab for cluster without any issue
    Given console.redhat.com is accessible
      And user U1 is already loged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) at least one cluster C1
      And the cluster C1 sent data to the external data pipeline
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
     When user U1 clicks on tab named "Insights Advisor"
     Then new page should be displayed saying "Your cluster passed all recommendations"
      And button with text "What is insights?" is displayed on this page
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed
