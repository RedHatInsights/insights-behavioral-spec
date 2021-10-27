# insights-behavioral-spec
Behavioral specifications for Insights pipelines and its integration into OCM, OCP, and ACM

## List of existing behavioral specifications (features)

### OCM UI

* [Login into console.redhat.com](features/OCM_login.feature)
* [List of clusters page on OCM UI](features/OCM_cluster_list.feature)
* [Insights tab on OCM UI](features/OCM_insights_tab.feature)
* [Cluster overview page on OCM UI](features/OCM_cluster_overview.feature)
* [Single rule page in OCM UI](features/OCM_single_rule_page.feature)
* [Rule feedback ability on OCM UI](features/OCM_rule_feedback.feature)
* [Disabling rule in OCM user interface](features/OCM_disable_rule.feature)
* [Disabling rule in OCM user interface should NOT be visible in ACM UI](features/OCM_disable_rule_on_ACM.feature)
* [Disabling rule in OCM user interface should be visible in OCP WebConsole as well](features/OCM_disable_rule_on_OCP.feature)


### OCP WebConsole

* [Login into OCP WebConsole](features/OCP_WebConsole_login.feature)
* [Insights displayed on OCP WebConsole](features/OCP_WebConsole_insights.feature)
* [Link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI](features/OCP_WebConsole_to_cluster_page.feature)


### Advanced Cluster Management

* [Overview page behaviour on Advanced Cluster Management](features/ACM_overview.page.feature)
* [List of clusters on ACM](features/ACM_cluster_list.feature)
* [Cluster issues section on Overview page on ACM UI](features/ACM_cluster_issues_section.feature)
* [Search for issues](features/ACM_search_issues.feature)
* [Cluster view with issues on ACM UI](features/ACM_cluster_view_with_issues.feature)
* [Displaying description of recommendation found for 1 cluster with 1 critical issue] (ACM_recommentation_description.feature)


### Customer Notifications

* [Customer Notifications](features/customer_notifications.feature)

List of scenarios can be seen [there](features/README.md)
