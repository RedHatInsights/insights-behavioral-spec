# Description
Directory where feature files with scenarios and scenario outlines are stored.

# List of scenarios

## `OCM_login.feature`

* Login into console.redhat.com
* Login into OCM UI

## `OCM_insights_tab.feature`

* Insights tab for cluster without any issue
* Insights tab for cluster that does not send any insights-operator archive
* Insights tab for cluster with 1 potential security issue identified

## `OCM_rule_feedback.feature`

* Displaying rule feedback controls on OCM UI
* Upvote for rule on OCM UI
* Downvote for rule on OCM UI
* Upvote then downvote for rule on OCM UI

## `OCM_single_rule_page.feature`

* Displaying single rule page in OCM UI

## `OCM_cluster_list.feature`

* Displaying info about no clusters on OCM UI ("empty list")
* Displaying list of clusters on OCM UI

## `OCM_cluster_overview.feature`

* Display cluster overview page on OCM UI for cluster w/o any issues
* Display cluster overview page on OCM UI for cluster with one critical issue
* Display cluster overview page on OCM UI for cluster with one critical issue and one low issue
* Display cluster overview page on OCM UI for cluster with two moderate issues

## `OCP_WebConsole_login.feature`

* Login into OCP WebConsole via console.redhat.com

## `OCP_WebConsole_insights.feature`

* Insights on OCP WebConsole for a cluster without any issue
* Insights on OCP WebConsole for a cluster that does not send any insights-operator archive
* Insights on OCP WebConsole for a situation when REST API is not accessbile
* Insights on OCP WebConsole for a cluster with 1 critical issue
* Insights on OCP WebConsole for a cluster with 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue and 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue, 1 important issue, and 1 moderate issue
* Insights on OCP WebConsole for a cluster with 10 low issues

## `OCP_WebConsole_to_cluster_page.feature`

* Using link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI

## `OCM_disable_rule_on_OCP.feature`

* Disabling rule in OCM user interface should be visible in OCP WebConsole as well

## `OCM_disable_rule.feature`

* Check if OCM user interface is accessible for two test accounts
* Check if tutorial rule is visible for two test accounts
* Check if first test account is able to disable tutorial rule
* Check if tutorial rule disabled by first test account is disabled for second test account as well
* Check if first test account is able to enable tutorial rule
* Check if tutorial rule enabled by first test account is enabled for second test account as well
* Check if rule is disabled for one cluster only
* Check if rule R1 is visible for two test accounts
* Check if first test account is able to disable rule R1
* Check if rule R1 disabled by first test account is disabled for second test account as well
* Check if first test account is able to enable rule R1
* Check if rule R1 enabled by first test account is enabled for second test account as well
* Check if rule is disabled for one cluster only

## `OCM_disable_rule_on_ACM.feature`

* Check if OCM user interface is accessible for two test accounts
* Check if ACM user interface is accessible for two test accounts
* Check if selected rule R1 is visible for the first test account in OCM UI
* Check if selected rule R1 is visible for test account in ACM
* Check if first test account is able to disable rule R1
* Check if rule disabled on OCM UI is still visible on ACM
* Check if rule disabled on OCM UI by user U1 is still visible on ACM for other users
* Check if OCM user interface is accessible for two test accounts
* Check if OCP WebConsole user interface is accessible for two test accounts
* Check if selected rule R1 is visible for the first test account in OCM UI
* Check if selected rule R1 is visible for test account in OCP WebConsole
* Check if first test account is able to disable rule R1
* Check if rule disabled on OCM UI is disabled on OCP WebConsole as well
* Check if rule disabled on OCM UI by user U1 is disabled on OCP WebConsole for other users as well

## `ACM_overview.page.feature`

* Displaying "Overview" page on ACM for one managed cluster in Ready state managed by AWS infrastruture

## `ACM_cluster_list.feature`

* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by AWS infrastruture
* Displaying "Clusters" page on ACM for one managed clusters in Hibernating state managed by AWS infrastruture
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Google Cloud Platform
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Microsoft Azure
* Displaying "Clusters" page on ACM for two managed clusters

## `ACM_cluster_issues_section`

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with no issues
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 important issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 moderate issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 low issue
* Displaying "Cluster issues" section on "Overview" page - 2 clusters each having 1 low issue

## `ACM_search_issues.feature`

* Ability to search for issues on Advanced Cluster Management for one local cluster
* Ability to search for issues on Advanced Cluster Management for one managed cluster

## `ACM_cluster_view_with_issues.feature`

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue

## `customer_notifications.feature`

* Check that notification service has all the information it needs to work properly
* Check that notification service produces instant notifications with the expected content
* Check that notification service produces instant notifications with the expected content
* Check that notification are sent to user when events are sent to the notification service's kafka topic
* Check that instant notification does not include the same reports as in previous notification
* Check that notification service does not flood custer with unnecessary instant emails
