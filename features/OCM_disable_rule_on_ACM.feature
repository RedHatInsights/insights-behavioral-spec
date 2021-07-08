Feature: Disabling rule in OCM user interface should NOT be visible in ACM UI


  Scenario: Check if OCM user interface is accessible for two test accounts
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in


  Scenario: Check if ACM user interface is accessible for two test accounts
    Given ACM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to ACM
     Then user U1 should be logged in
     When user U2 tries to login to ACM
     Then user U2 should be logged in


  Scenario: Check if selected rule R1 is visible for the first test account in OCM UI
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the selected rule R1 should be visible in list of rule hits


  Scenario: Check if selected rule R1 is visible for test account in ACM
    Given ACM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to ACM
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on ACM
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should include rule R1 as well


  Scenario: Check if first test account is able to disable rule R1
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user disables rule R1 by using UI widget
     Then the rule R1 should be no longer visible in list of rule hits


  Scenario: Check if rule disabled on OCM UI is still visible on ACM
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user disables rule R1 by using UI widget
     Then the rule R1 should be no longer visible in list of rule hits
     When user U1 tries to login to ACM
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on ACM
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should include rule R1


  Scenario: Check if rule disabled on OCM UI by user U1 is still visible on ACM for other users
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCM UI
     When user selects Insights tab
     Then list of rule hits should be displayed on OCM UI
      And the Tutorial rule should be visible in list of rule hits
     When user disables rule R1 by using UI widget
     Then the rule R1 should be no longer visible in list of rule hits
     When user U2 tries to login to ACM
     Then user U2 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on ACM
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should not include rule R1
