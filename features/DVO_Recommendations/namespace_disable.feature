Feature: it is expected that customers will see some false positives for
    several namespaces, so it would be needed for them to be able to disable
    such namespace(s) from graphical user interface. It means that this
    functionality will need to be implemented in backend, which also mean that
    changes should be made in database structure.


  Scenario: Command to disable selected DVO recommendation on Insights Advisor
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
     When user expands "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_workloads_menu_item.png
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then a "Workloads" page should be displayed right of the left menu bar
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
          | ︙             | widget to display context menu                           |
     When user clicks on context menu button ︙
     Then the context menu should be displayed as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_disable_recommendation_for_cluster.png
      And the following menu items should be found there
          | Menu item                               |
          | Disable recommendation for this cluster |


  Scenario: Dialog that allow user to disable selected DVO recommendation on Insights Advisor
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
     When user expands "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_workloads_menu_item.png
          | Expanded menu item  | Required for this scenario |
          | Clusters            | no                         |
          | Recommendations     | no                         |
          | Workloads           | yes                        |
     When user select "Workloads" menu item from this sub-menu
     Then a "Workloads" page should be displayed right of the left menu bar
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
          | ︙             | widget to display context menu                           |
     When user clicks on context menu button ︙
     Then the context menu should be displayed as can be seen on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_disable_recommendation_for_cluster.png
      And the following menu items should be found there
          | Menu item                               |
          | Disable recommendation for this cluster |
     When user selects this menu item
     Then the dialog to disable recommendation and provide feedback should be displayed
      And it's layout should be like  https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/ui/hcc_disable_recommendation_feedback.png
      And the checkbox "Disable only for this cluster" should be checked by default
