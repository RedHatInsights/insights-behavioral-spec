Feature: Upgrade risks


  Scenario: Displaying 1 cluster with high upgrade risk
    Given user USER1 owns a managed cluster
      And an upgrade risk has been detected for this cluster
      And the user USER1 is already logged in to Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Clusters / Cluster page
     Then the "Upgrade risk" section displays
          | Upgrade risk  | High  |
      And the "Upgrade risk" section is clickable
     When user USER1 clicks on the "Upgrade risk" section
     Then the browser opens the details page on console.redhat.com (Advisor / Cluster / Upgrade risk)


  Scenario: Displaying 1 cluster with low upgrade risk
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns a managed cluster
      And no or low upgrade risk has been detected for this cluster
      And the user USER1 is already logged in to Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Clusters / Cluster page
     Then the "Upgrade risk" section displays
          | Upgrade risk  | Low |
      And the "Upgrade risk" section is not clickable


  Scenario: Displaying the overview of the clusters at risk
    Given user USER1 owns one or more managed clusters
      And the user USER1 is already logged in to Advanced Cluster Management
     When user USER1 views Advanced Cluster Management / Overview
     Then the "Upgrade risk" section displays the current N clusters with high upgrade risk
      And the "Upgrade risk" section displays the date/time of the last refresh
      And the "Upgrade risk" section is clickable
     When user USER1 clicks on the "Upgrade risk" section
     Then the browser displays the list of the N clusters


  Scenario: Displaying the upgrade risk for 100 clusters or less
    Given user USER1 owns a maximum of 100 managed clusters
     When the ACM control plane requests the upgrade risk from console.redhat.com
      And all the clusters are requested in a single call
     Then console.redhat.com returns the upgrade risk for all the requested clusters


  Scenario: Displaying the upgrade risk for more than 100 clusters
    Given user USER1 owns 101 or more managed clusters
     When the ACM control plane requests the upgrade risk from console.redhat.com
      And all the clusters are requested in a single call
     Then console.redhat.com returns an error
