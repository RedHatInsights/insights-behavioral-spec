Feature: Insights displayed on OCP WebConsole


  Scenario: Insights on OCP WebConsole for a cluster without any issue
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And no issues have been detected for cluster C1
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about no issues found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window should appear
      And an information "No insights data to display" is shown in this window
      And a clickable link named "More about Insights" is shown as well


  Scenario: Insights on OCP WebConsole for a cluster that does not send any insights-operator archive
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 has not sent any insights-operator archive to the external data pipeline
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about no issues found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window should appear
      And an information "No insights data to display" is shown in this window
      And a sentence "The results will be displayed shortly" is shown in this window
      And a clickable link named "More about Insights" is shown as well
