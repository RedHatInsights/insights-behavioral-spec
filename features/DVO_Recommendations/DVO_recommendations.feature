Feature: Workloads page behavior in Insights Advisor menu on Hybrid Cloud Console

        Current way of presenting workload related recommendations is not good
        enough. As a customer using OCP Advisor I'd like to be able to consume
        Workload related recommendations grouped by namespaces. This means that
        new UX controls need to be added into Insights Advisor: it would split
        results of DVO recommendations per namespace and display it to end
        users. Notifications should also be sent per namespace (which would
        enable developers to gain access to results per namespace they own).

        Workload related recommendations should be displayed on page named
        Workloads. Entry point to this page is available through the Advisor
        menu displayed in the left menu of Hybrid Cloud Console.

        The UX design for page that use these information is available there:
        https://www.sketch.com/s/46f6d8e3-a4d0-4249-9d57-e6a79b518a6d/a/y9y12qE


  Scenario: Existence of new tab named "Workloads" in Insights Advisor that is accessible through Hybrid Cloud Console menu
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
     Then a "Workloads" page should be displayed right of the left menu bar


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
     Then a "Advisor workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget    | Content                                                 |
          | Advisor workloads | Section containing list of cluster names and namespaces |
     When user look at "Advisor workloads" section
     Then following sections should be presented
          | Section          | State                  | Comment             |
          | Filter list box  | Cluster name           | first selected item |
          | Filter input box | Filter by cluster name | popup help text     |
          | Workloads        | empty table            | table with list of clusters and namespaces |
     When user look at "Recommendations table"
     Then that table should contain following six columns in that order
          | Column           | Comment                                                         |
          | Select button    | used to select one or more namespaces                           |
          | Workload         | cluster name (or UUID) followed by namespace name (or UUID)     |
          | Recommendations  | number of recommendations found for given cluster and namespace |
          | Highest severity | highest severity selected from all recommendations              |
          | Objects          | number of all objects found for given cluster and namespace     |
          | Last seen        | relative time when the data was updated recently                |
      And the table content should be empty


  Scenario: Content displyed on a new tab named "Workloads" in Insights Advisor if one DVO recommendation has been found
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the cluster name is 11111111-2222-3333-4444-555555555555
      And the user USER1 is already logged in into Hybrid Cloud Console
      And one DVO recommendation with name Foo and ID 1234 has been found for that cluster
      And this recommendation is part of namespace with UUID ffffffff-eeee-dddd-cccc-bbbbbbbbbbbb
      And the severity of this recommendation is Moderate
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
     Then a "Advisor workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget    | Content                                                 |
          | Advisor workloads | Section containing list of cluster names and namespaces |
     When user look at "Advisor workloads" section
     Then following sections should be presented
          | Section          | State                  | Comment             |
          | Filter list box  | Cluster name           | first selected item |
          | Filter input box | Filter by cluster name | popup help text     |
          | Workloads        | empty table            | table with list of clusters and namespaces |
     When user look at "Recommendations table"
     Then that table should contain following six columns in that order
          | Column           | Comment                                                         |
          | Select button    | used to select one or more namespaces                           |
          | Workload         | cluster name (or UUID) followed by namespace name (or UUID)     |
          | Recommendations  | number of recommendations found for given cluster and namespace |
          | Highest severity | highest severity selected from all recommendations              |
          | Objects          | number of all objects found for given cluster and namespace     |
          | Last seen        | relative time when the data was updated recently                |
      And the table content should contain exactly one row with the following content
          | Column           | Content                                                                     |
          | Select button    | unselected                                                                  |
          | Workload         | 11111111-2222-3333-4444-555555555555 / ffffffff-eeee-dddd-cccc-bbbbbbbbbbbb |
          | Recommendations  | 1                                                                           |
          | Highest severity | Moderate                                                                    |
          | Objects          | 1                                                                           |
          | Last seen        | relative time when the data was updated recently                            |


  Scenario: Ability to display real namespace name if provided
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 1 cluster
      And the cluster name is 11111111-2222-3333-4444-555555555555
      And the user USER1 is already logged in into Hybrid Cloud Console
      And one DVO recommendation with name Foo and ID 1234 has been found for that cluster
      And this recommendation is part of namespace with UUID ffffffff-eeee-dddd-cccc-bbbbbbbbbbbb and name Namespace1
      And the severity of this recommendation is Moderate
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
     Then a "Advisor workloads" page should be displayed right of the left menu bar
      And that page should contain following controls and widgets
          | Control/widget    | Content                                                 |
          | Advisor workloads | Section containing list of cluster names and namespaces |
     When user look at "Advisor workloads" section
     Then following sections should be presented
          | Section          | State                  | Comment             |
          | Filter list box  | Cluster name           | first selected item |
          | Filter input box | Filter by cluster name | popup help text     |
          | Workloads        | empty table            | table with list of clusters and namespaces |
     When user look at "Recommendations table"
     Then that table should contain following six columns in that order
          | Column           | Comment                                                         |
          | Select button    | used to select one or more namespaces                           |
          | Workload         | cluster name (or UUID) followed by namespace name (or UUID)     |
          | Recommendations  | number of recommendations found for given cluster and namespace |
          | Highest severity | highest severity selected from all recommendations              |
          | Objects          | number of all objects found for given cluster and namespace     |
          | Last seen        | relative time when the data was updated recently                |
      And the table content should contain exactly one row with the following content
          | Column           | Content                                            |
          | Select button    | unselected                                         |
          | Workload         | 11111111-2222-3333-4444-555555555555 / Namespace 1 |
          | Recommendations  | 1                                                  |
          | Highest severity | Moderate                                           |
          | Objects          | 1                                                  |
          | Last seen        | relative time when the data was updated recently   |
