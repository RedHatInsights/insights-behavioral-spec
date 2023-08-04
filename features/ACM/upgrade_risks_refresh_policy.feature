Feature: Upgrade risks refresh policy


  Scenario: Upgrade risks are refreshed every 6 hours
    Given user USER1 owns one or more managed clusters
     When 6 hours are elapsed
     Then the ACM control plane requests to console.redhat.com the upgrade risk for all the managed clusters
      And the returned upgrade risks are cached for the next 6 hours 
      And the cached upgrade risks are displayed in the "Upgrade risk" sections
          in Overview and Infrastructure / Clusters
      And the date/time of the last successful call to console.redhat.com is displayed in the "Upgrade risk" sections
          in Overview and Infrastructure / Clusters


  Scenario: Upgrade risks for 100 clusters or less
    Given user USER1 owns at maximum 100 managed clusters
     When the ACM control plane requests to console.redhat.com the upgrade risk 
      And all the clusters are requested in a single call
     Then the upgrade risk info for all the requested clusters


  Scenario: Upgrade risks for more than 100 clusters
    Given user USER1 owns 101 or more managed clusters
     When the ACM control plane requests to console.redhat.com the upgrade risk 
      And all the clusters are requested in a single call
     Then an error will be returned