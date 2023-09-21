Feature: Workloads page behavior in Insights Advisor menu on Hybrid Cloud Console

        Current way of presenting workload related recommendations is not good
        enough. As a customer using OCP Advisor I'd like to be able to consume
        Workload related recommendations grouped by namespaces. This means that
        new UX controls need to be added into Insights Advisor: it would split
        results of DVO recommendations per namespace and display it to end
        users.  Notifications should also be sent per namespace (which would
        enable developers to gain access to results per namespace they own).

        Workload related recommendations should be displayed on page named
        Workloads.  Entry point to this page is available through the Insights
        menu displayed in the left menu of Hybrid Cloud Console.

        The UX design for page that use these information is available there:
        https://www.sketch.com/s/46f6d8e3-a4d0-4249-9d57-e6a79b518a6d/a/y9y12qE


  Scenario: Existence of new tab named "Workloads" in Insights Advisor
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this scenario |
          | Application and Data Services | no                         |
          | OpenShift                     | yes                        |
          | Red Hat Enterprise Linux      | no                         |
          | Ansible Automation Platform   | no                         |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_menu_advisor.png
          | Left menu item           | Required for this scenario |
          | Clusters                 | no                         |
          | Learning resources       | no                         |
          | Overview                 | no                         |
          | Releases                 | no                         |
          | Developer Sandbox        | no                         |
          | Downloads                | no                         |
          | Advisor                  | yes                        |
          | Vulnerability Dashboard  | no                         |
          | Subscriptions            | no                         |
          | Cost Management          | no                         |
          | Support Cases            | no                         |
          | Cluster Manager Feedback | no                         |
          | Red Hat Marketplace      | no                         |
          | Documentation            | no                         |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_workloads_menu_item.png
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then an "Workloads" page should be displayed right of the left menu bar


  Scenario: Content displyed on a new tab named "Workloads" in Insights Advisor if no DVO recommendations has been found
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the user USER1 is already logged in into Hybrid Cloud Console
      And no DVO recommendations has been found for that cluster
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this scenario |
          | Application and Data Services | no                         |
          | OpenShift                     | yes                        |
          | Red Hat Enterprise Linux      | no                         |
          | Ansible Automation Platform   | no                         |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_menu_advisor.png
          | Left menu item           | Required for this scenario |
          | Clusters                 | no                         |
          | Learning resources       | no                         |
          | Overview                 | no                         |
          | Releases                 | no                         |
          | Developer Sandbox        | no                         |
          | Downloads                | no                         |
          | Advisor                  | yes                        |
          | Vulnerability Dashboard  | no                         |
          | Subscriptions            | no                         |
          | Cost Management          | no                         |
          | Support Cases            | no                         |
          | Cluster Manager Feedback | no                         |
          | Red Hat Marketplace      | no                         |
          | Documentation            | no                         |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_workloads_menu_item.png
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then an "Workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget  | Content                                    |
          | Recommendations | Section containing list of recommendations |
     When user look at "Recommendations" section
     Then following sections should be presented
          | Section          | State                  | Comment                            |
          | Filter list box  | Cluster name           | first selected item                |
          | Filter input box | Filter by cluster name | popup help text                    |
          | Counter          | 0 recommendations      | recommendation counter             |
          | Recommendations  | empty table            | table with list of recommendations |
     When user look at "Recommendations table"
     Then that table should contain following five columns in that order
          | Column         | Comment                                                  |
          | Expand button  |                                                          |
          | Cluster name   |                                                          |
          | App name       | app real name or UID depending on anonymization settings |
          | App UID        | app = namespace                                          |
      And the table content should be empty


  Scenario: Content displyed on a new tab named "Workloads" in Insights Advisor if one DVO recommendation has been found
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the cluster name is 11111111-2222-3333-4444-555555555555
      And the user USER1 is already logged in into Hybrid Cloud Console
      And one DVO recommendation with name Foo and ID 1234 has been found for that cluster
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item                | Required for this scenario |
          | Application and Data Services | no                         |
          | OpenShift                     | yes                        |
          | Red Hat Enterprise Linux      | no                         |
          | Ansible Automation Platform   | no                         |
     When user selects "OpenShift" from the left side menu
     Then menu on the left side should be changed
      And the left menu might contain these top level items as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_menu_advisor.png
          | Left menu item           | Required for this scenario |
          | Clusters                 | no                         |
          | Learning resources       | no                         |
          | Overview                 | no                         |
          | Releases                 | no                         |
          | Developer Sandbox        | no                         |
          | Downloads                | no                         |
          | Advisor                  | yes                        |
          | Vulnerability Dashboard  | no                         |
          | Subscriptions            | no                         |
          | Cost Management          | no                         |
          | Support Cases            | no                         |
          | Cluster Manager Feedback | no                         |
          | Red Hat Marketplace      | no                         |
          | Documentation            | no                         |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_workloads_menu_item.png
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then an "Workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget  | Content                                    |
          | Recommendations | Section containing list of recommendations |
     When user look at "Recommendations" section
     Then following sections should be presented
          | Section          | State                  | Comment                            |
          | Filter list box  | Cluster name           | first selected item                |
          | Filter input box | Filter by cluster name | popup help text                    |
          | Counter          | 0 recommendations      | recommendation counter             |
          | Recommendations  | empty table            | table with list of recommendations |
     When user look at "Recommendations table"
     Then that table should contain following five columns in that order
          | Column         | Comment                                                  |
          | Expand button  |                                                          |
          | Cluster name   |                                                          |
          | App name       | app real name or UID depending on anonymization settings |
          | App UID        | app = namespace                                          |
      And the table content should contain exactly one row with the following content
          | Column         | Comment                                                  |
          | Expand button  | present, rendered as ">"                                 |
          | Cluster name   | 11111111-2222-3333-4444-555555555555                     |
          | App name       | Foo                                                      |
          | App UID        | 1234                                                     |
     When user clicks on expand button
     Then the only one row in that table should change as follow
          | Column         | Comment                                                  |
          | Expand button  | present, rendered as "v"                                 |
          | Cluster name   | 11111111-2222-3333-4444-555555555555                     |
          | App name       | Foo                                                      |
          | App UID        | 1234                                                     |
       And new row in the table should be displayed
       And the new row should contains recommendation details in same format as on Recommendation page
     When user clicks on expand button
     Then the only one row in table should shrink again
