Feature: Insights displayed on OCP WebConsole


  Scenario: Managed rules are not shown in OCP WebConsole
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pip
      And at least 1 managed issue have been detected for cluster C1
      And no non-managed issues have been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 0 issues found should be displayed below "Insights" label

  Scenario: Non-managed rules are shown, but managed rules are not in OCP WebConsole
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pip
      And at least 1 managed issue have been detected for cluster C1
      And exactly 1 non-managed issue have been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issues found should be displayed below "Insights" label
