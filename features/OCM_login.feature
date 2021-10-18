Feature: Login into console.redhat.com

  Scenario: Login into console.redhat.com
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
          | Left menu item              |
          | Application services        |
          | OpenShift                   |
          | Red Hat Enterprise Linux    |
          | Ansible Automation Platform |
      And the toolbar should contain control widget with U1's name in it on the right side
     When user U1 clicked on its name
     Then menu with following items should be displayed
          | User menu        |
          | My profile       |
          | User preferences |
          | Internal         |
          | Log out          |
      When user U1 selects the "Log out" item from the user menu
      Then the page with title "Log in to your Red Hat account" is displayed


  Scenario: Login into OCM UI
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
          | Left menu item              |
          | Application services        |
          | OpenShift                   |
          | Red Hat Enterprise Linux    |
          | Ansible Automation Platform |
     When user U1 selects the item "OpenShift" from the left menu 
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
      And the toolbar should contain control widget with U1's name in it on the right side
     When user U1 clicked on its name
     Then menu with following items should be displayed
          | User menu        |
          | My profile       |
          | User preferences |
          | Internal         |
          | Log out          |
      When user U1 selects the "Log out" item from the user menu
      Then the page with title "Log in to your Red Hat account" is displayed

