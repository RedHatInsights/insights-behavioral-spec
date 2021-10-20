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
     Then pop-up window named "Insights status" should appear
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
     Then pop-up window named "Insights status" should appear
      And an information "No insights data to display" is shown in this window
      And a sentence "The results will be displayed shortly" is shown in this window
      And a clickable link named "More about Insights" is shown as well


  Scenario: Insights on OCP WebConsole for a situation when REST API is not accessbile
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the REST API of external data pipeline is not accessible
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
     Then pop-up window named "Insights status" should appear
      And an information "Something went wrong" is shown in this window
      And a clickable link "Red Hat support" is shown as well in this window
      And a clickable link "status page" is shown as well in this window


  Scenario: Insights on OCP WebConsole for a cluster with 1 critical issue
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And exactly 1 critical issue has been detected for this cluster
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issue found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window named "Insights status" should appear
      And graph saying "1 total issue" should be displayed in this window
      And following table should be displayed left-of the graph
          | # | Total risk |
          | 1 | Critical   |
          | 0 | Important  |
          | 0 | Moderate   |
          | 0 | Low        |
      And a section named "Fixable issues" should be shown below graph and a table
      And that section should contain a link named "View all in OpenShift Cluster Manager"


  Scenario: Insights on OCP WebConsole for a cluster with 2 critical issues
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And exactly 2 critical issues has been detected for this cluster
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issue found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window named "Insights status" should appear
      And graph saying "2 total issues" should be displayed in this window
      And following table should be displayed left-of the graph
          | # | Total risk |
          | 2 | Critical   |
          | 0 | Important  |
          | 0 | Moderate   |
          | 0 | Low        |
      And a section named "Fixable issues" should be shown below graph and a table
      And that section should contain a link named "View all in OpenShift Cluster Manager"


  Scenario: Insights on OCP WebConsole for a cluster with 1 low issue and 2 critical issues
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And exactly 2 critical issues has been detected for this cluster
      And exactly 1 low risk issue has been detected for this cluster
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issue found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window named "Insights status" should appear
      And graph saying "3 total issues" should be displayed in this window
      And following table should be displayed left-of the graph
          | # | Total risk |
          | 2 | Critical   |
          | 0 | Important  |
          | 0 | Moderate   |
          | 1 | Low        |
      And a section named "Fixable issues" should be shown below graph and a table
      And that section should contain a link named "View all in OpenShift Cluster Manager"


  Scenario: Insights on OCP WebConsole for a cluster with 1 low issue, 1 important issue, and 1 moderate issue
    Given console.redhat.com is accessible
      And user U1 is already logged in into console.redhat.com
      And user U1 switch to "OpenShift" page in console.redhat.com (OCM UI)
      And user U1 is part of account (organization) with at least one cluster C1
      And the cluster C1 sent insights-operator archive to the external data pipeline
      And exactly 1 low risk issue has been detected for this cluster
      And exactly 1 important issue has been detected for this cluster
      And exactly 1 moderate issue has been detected for this cluster
     When user U1 selects "Clusters" item from the menu
     Then new page with list of clusters should be displayed
     When user U1 click on cluster name
     Then a page with detailed information about the selected cluster should be displayed
      And button named "Open Console" should be displayed
     When user U1 click on "Open Console" button
     Then new page named "Overview" with OCP WebConsole content should be displayed
      And clickable "Insights" label should be displayed on that page
      And information about 1 issue found should be displayed below "Insights" label
     When user U1 click on "Insights" label
     Then pop-up window named "Insights status" should appear
      And graph saying "3 total issues" should be displayed in this window
      And following table should be displayed left-of the graph
          | # | Total risk |
          | 0 | Critical   |
          | 1 | Important  |
          | 1 | Moderate   |
          | 1 | Low        |
      And a section named "Fixable issues" should be shown below graph and a table
      And that section should contain a link named "View all in OpenShift Cluster Manager"
