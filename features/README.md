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

## `ACM_recommentation_description.feature`

* Displaying description of recommendation found for 1 cluster with 1 critical issue

## `Insights_Advisor_recommendations_page.feature`

* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console without any recommendations
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## `Insights_Advisor_recommendations_page_expanded_info.feature`

* Displaying expanded information about selected recommendation with high likelihood and high impact
* Displaying expanded information about selected recommendation with medium likelihood and low impact
* Displaying expanded information about selected recommendation with critical likelihood and low impact

## `Insights_Advisor_recommendations_page_pagination.feature`

* Pagination widgets displayed in Advisor recommendations page on Hybrid Cloud Console
* Goto to next page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to last page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to previous page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to first page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget

## `Insights_Advisor_recommendations_page_filtering.feature`

* Default filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Name" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Total risk" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Clusters impacted" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter to default value on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Category" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Likelihood" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* No-op action in filter menu on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## `Insights_Advisor_recommendations_page_sorting.feature`

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by total risk on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by clusters on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by added at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by different columns at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor_affected_clusters_page.feature`

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters

## `Insights_Advisor_affected_clusters_sorting.feature`

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name in different order on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor_affected_clusters_filtering.feature`

* Default filtering on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Basic filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* On-the-fly filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Ability to clear filter on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor_cluster_page.feature`

* Cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanded recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Folding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Collapsing all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `Insights_Advisor_cluster_page_sorting.feature`

* Default sort order in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by added at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by total risk at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `Insights_Advisor_cluster_page_filtering.feature`

* Default filtering in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by total risk in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple total risk values in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by category in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple categories in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status all in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `customer_notifications.feature`

* Check that notification service has all the information it needs to work properly
* Check that notification service produces instant notifications with the expected content
* Check that notification service produces instant notifications with the expected content
* Check that notification are sent to user when events are sent to the notification service's kafka topic
* Check that instant notification does not include the same reports as in previous notification
* Check that notification service does not flood custer with unnecessary instant emails
