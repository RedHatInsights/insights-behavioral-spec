Feature: List of clusters on OCM UI

  Scenario: Displaying info about no clusters on OCM UI ("empty list")
    Given console.redhat.com is accessible
      And user U1 is already loged in into console.redhat.com
      And user U1 is part of account (organization) owning no cluster
     When user U1 selects the item "OpenShift" from the left menu on console.redhat.com
     Then the OpenShift section page should be displayed
      And the left menu should contian at least these items
          | Left menu item              |
          | Clusters                    |
          | Overview                    |
          | Releases                    |
          | Downloads                   |
          | Subscriptions               |
          | Cost Management             |
          | Support Cases               |
          | Cluster Manager Feedback    |
          | Red Hat Marketplace         |
          | Documentation               |
     When user U1 selects "Clusters" item from the menu
     Then new page saying "No OpenShift cluster to display" is displayed
      And button "Create cluster" should be made visible
     When user U1 clicked on its name
     Then menu with following items should be displayed
          | User menu        |
          | My profile       |
          | User preferences |
          | Internal         |
          | Log out          |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed

  Scenario: Displaying list of clusters on OCM UI
    Given console.redhat.com is accessible
      And user U1 is already loged in into console.redhat.com
      And user U1 is part of account (organization) owning at least one cluster registered on OCM UI
      And the cluster for an account is made active
     When user U1 selects the item "OpenShift" from the left menu on console.redhat.com
     Then the OpenShift section page should be displayed
      And the left menu should contian at least these items
          | Left menu item              |
          | Clusters                    |
          | Overview                    |
          | Releases                    |
          | Downloads                   |
          | Subscriptions               |
          | Cost Management             |
          | Support Cases               |
          | Cluster Manager Feedback    |
          | Red Hat Marketplace         |
          | Documentation               |
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
     When user U1 clicked on its name
     Then menu with following items should be displayed
          | User menu        |
          | My profile       |
          | User preferences |
          | Internal         |
          | Log out          |
     When user U1 selects the "Log out" item from the user menu
     Then the page with title "Log in to your Red Hat account" is displayed

