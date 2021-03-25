Feature: Disabling rule in OCM user interface


  Scenario: Check if OCM user interface is accessible for two test accounts
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in


  Scenario: Check if tutorial rule is visible for two test accounts
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits


  Scenario: Check if first test account is able to disable tutorial rule
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user disables Tutorial rule by using UI widget
     Then the Tutorial rule should be no longer visible in list of rule hits


  Scenario: Check if tutorial rule disabled by first test account is disabled for second test account as well
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U2 exists for test organization
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be no longer visible in list of rule hits


  Scenario: Check if first test account is able to enable tutorial rule
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be no longer visible in list of rule hits
     When user enables Tutorial rule by using UI widget
      And the Tutorial rule should be visible in list of rule hits


  Scenario: Check if tutorial rule enabled by first test account is enabled for second test account as well
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U2 exists for test organization
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits


  Scenario: Check if rule is disabled for one cluster only
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user disables Tutorial rule by using UI widget
     Then the Tutorial rule should be no longer visible in list of rule hits
     When user selects cluster C2 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
