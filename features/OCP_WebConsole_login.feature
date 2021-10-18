Feature: Login into OCP WebConsole

  Scenario: Login into OCP WebConsole via console.redhat.com
    Given console.redhat.com is accessible
      And user U1 has access granted to login into console.redhat.com
     When user U1 opens the page console.redhat.com
     Then the page with title "Log in to your Red Hat account" is displayed
      And "Red Hat login or email" input field is visible and editable
      And "Next" button is visible and clickable
     When user U1 enters his name into the input box
      And user U1 clicks on "Next" button
     Then "Password" input field should be made visible and editable
      And "Login" button is made visible and editable
      And "Next" button is made invisible
      And "Red Hat login or email" button is made invisible
     When user U1 enters his password into the input box
      And user U1 clicks on "Login" button
     Then Home page of console.redhat.com should be displayed
      And the left menu should contain at least these items
          | OpenShift                   |
     When user U1 selects the item "OpenShift" from the left menu 
     Then the OpenShift section page should be displayed
      And the left menu should contian at least these items
          | Clusters                    |
      And the toolbar should contain control widget with U1's name in it on the right side
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
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about number of issues found should be displayed below "Insights" label
