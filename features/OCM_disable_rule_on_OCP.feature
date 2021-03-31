Feature: Disabling rule in OCM user interface should be visible in OCP WebConsole as well


  Scenario: Check if OCM user interface is accessible for two test accounts
    Given OCM user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to OCM UI
     Then user U1 should be logged in
     When user U2 tries to login to OCM UI
     Then user U2 should be logged in


  Scenario: Check if OCP WebConsole user interface is accessible for two test accounts
    Given OCP WebConsole user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And user U2 exists for test organization
     When user U1 tries to login to OCP WebConsole
     Then user U1 should be logged in
     When user U2 tries to login to OCP WebConsole
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


  Scenario: Check if selected rule R1 is visible for test account in OCP WebConsole
    Given OCP WebConsole user interface is accessible
      And CCX external data pipeline is in working state
      And user U1 exists for test organization
      And cluster C1 contains issue detected by rule R1
     When user U1 tries to login to OCP WebConsole
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCP WebConsole
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should include rule R1 as well
     When user U1 clicked into this pop-up dialog
     Then user U1 is redirected to OCM UI with cluster C1 preselected
      And the selected rule R1 should be visible in list of rule hits


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


  Scenario: Check if rule disabled on OCM UI is disabled on OCP WebConsole as well
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
     When user U1 tries to login to OCP WebConsole
     Then user U1 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCP WebConsole
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should not include rule R1
     When user U1 clicked into this pop-up dialog
     Then user U1 is redirected to OCM UI with cluster C1 preselected
      And the selected rule R1 should not be visible in list of rule hits


  Scenario: Check if rule disabled on OCM UI by user U1 is disabled on OCP WebConsole for other users as well
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
     When user U2 tries to login to OCP WebConsole
     Then user U2 should be logged in
     When user selects cluster C1 from his organization
     Then the info about this cluster should be displayed on OCP WebConsole
      And Insights status should be displayed in Status sub-window
     When user U1 clicked Insights status
     Then pop-up dialog should be displayed containing counters with number of rules in each category
      And counters should not include rule R1
     When user U1 clicked into this pop-up dialog
     Then user U1 is redirected to OCM UI with cluster C1 preselected
      And the selected rule R1 should not be visible in list of rule hits
