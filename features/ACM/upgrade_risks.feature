Feature: Upgrade risks


  Scenario: Displaying 1 cluster with upgrade risk
    Given user USER1 owns one managed cluster
      And an upgrade risk has been detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Clusters / Cluster page
     Then the "Upgrade risk" section displays
          | Upgrade risk  | High  |
      And the "Upgrade risk" section is clickable
     When user USER1 clicks on the "Upgrade risk" section
     Then the browser opens the details page on console.redhat.com (Advisor / Cluster / Upgrade risk)


  Scenario: Displaying 1 cluster with no upgrade risk
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns one managed cluster
      And no upgrade risk has been detected for this cluster
      And the user USER1 is already logged in into Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Clusters / Cluster page
     Then the "Upgrade risk" section displays
          | Upgrade risk  | Low |
      And the "Upgrade risk" section is not clickable


  Scenario: Displaying the overview of the clusters at risk
    Given user USER1 owns one or more managed clusters
      And the user USER1 is already logged in into Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Overview
     Then the "Upgrade risk" section displays the number of clusters with an upgrade risk
      And the "Upgrade risk" section displays the date/time of the last refresh
      And the "Upgrade risk" section is clickable
     When user USER1 clicks on the "Upgrade risk" section
     Then the browser displays the list of the clusters with an upgrade risk


  Scenario: Displaying the upgrade risk for multiple clusters
    Given user USER1 owns one or more managed clusters
      And the user USER1 is already logged in into Advanced Cluster Management
     When user USER1 looks at Advanced Cluster Management / Infrastructure / Clusters
      And user USER1 selects one or more clusters
      And user USER1 selects Actions / Upgrade clusters 
     Then the "Upgrade clusters" window appears
      And the "Upgrade clusters" window displays the upgrade risk for each listed cluster
      And the "Upgrade clusters" window displays the last refresh date/time      
     When user USER1 clicks on the "Upgrade risk" for a listed cluster
     Then the browser opens the details page on console.redhat.com (Advisor / Cluster / Upgrade risk)
     When user USER1 clicks "Refresh" next to the last refresh date/time
     Then the current upgrade risks are requested to the backend
      And the last refresh date/time displays the current date/time
