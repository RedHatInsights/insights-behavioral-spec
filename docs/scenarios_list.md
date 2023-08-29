---
layout: page
nav_order: 3
---

# List of scenarios

## [`OCM/cluster_list.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/cluster_list.feature)

* Displaying info about no clusters on OCM UI ("empty list")
* Displaying list of clusters on OCM UI

## [`OCM/cluster_overview.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/cluster_overview.feature)

* Display cluster overview page on OCM UI for cluster w/o any issues
* Display cluster overview page on OCM UI for cluster with one critical issue
* Display cluster overview page on OCM UI for cluster with one critical issue and one low issue
* Display cluster overview page on OCM UI for cluster with two moderate issues

## [`OCM/disable_rule.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/disable_rule.feature)

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

## [`OCM/disable_rule_on_ACM.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/disable_rule_on_ACM.feature)

* Check if OCM user interface is accessible for two test accounts
* Check if ACM user interface is accessible for two test accounts
* Check if selected rule R1 is visible for the first test account in OCM UI
* Check if selected rule R1 is visible for test account in ACM
* Check if first test account is able to disable rule R1
* Check if rule disabled on OCM UI is still visible on ACM
* Check if rule disabled on OCM UI by user U1 is still visible on ACM for other users

## [`OCM/disable_rule_on_OCP.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/disable_rule_on_OCP.feature)

* Check if OCM user interface is accessible for two test accounts
* Check if OCP WebConsole user interface is accessible for two test accounts
* Check if selected rule R1 is visible for the first test account in OCM UI
* Check if selected rule R1 is visible for test account in OCP WebConsole
* Check if first test account is able to disable rule R1
* Check if rule disabled on OCM UI is disabled on OCP WebConsole as well
* Check if rule disabled on OCM UI by user U1 is disabled on OCP WebConsole for other users as well

## [`OCM/insights_tab.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/insights_tab.feature)

* Insights tab for cluster without any issue
* Insights tab for cluster that does not send any insights-operator archive
* Insights tab for cluster with 1 potential security issue identified

## [`OCM/login.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/login.feature)

* Login into console.redhat.com
* Login into OCM UI

## [`OCM/rule_feedback.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/rule_feedback.feature)

* Displaying rule feedback controls on OCM UI
* Upvote for rule on OCM UI
* Downvote for rule on OCM UI
* Upvote then downvote for rule on OCM UI

## [`OCM/single_rule_page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/single_rule_page.feature)

* Displaying single rule page in OCM UI

## [`OCP_WebConsole/filter_managed_rules.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/filter_managed_rules.feature)

* Managed rules are not shown in OCP WebConsole
* Non-managed rules are shown, but managed rules are not in OCP WebConsole

## [`OCP_WebConsole/insights.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/insights.feature)

* Insights on OCP WebConsole for a cluster without any issue
* Insights on OCP WebConsole for a cluster that does not send any insights-operator archive
* Insights on OCP WebConsole for a situation when REST API is not accessbile
* Insights on OCP WebConsole for a cluster with 1 critical issue
* Insights on OCP WebConsole for a cluster with 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue and 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue, 1 important issue, and 1 moderate issue
* Insights on OCP WebConsole for a cluster with 10 low issues

## [`OCP_WebConsole/login.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/login.feature)

* Login into OCP WebConsole via console.redhat.com

## [`OCP_WebConsole/to_cluster_page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/to_cluster_page.feature)

* Using link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI

## [`ACM/cluster_issues_section.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_issues_section.feature)

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with no issues
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 important issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 moderate issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 low issue
* Displaying "Cluster issues" section on "Overview" page - 2 clusters each having 1 low issue

## [`ACM/cluster_issues_section_disabled_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_issues_section_disabled_issues.feature)

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 already disabled issue with low severity
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 issue with low severity that is being disabled in Insights Advisor
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 issue with low severity that is being enabled in Insights Advisor
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues, that are being disabled in Insights Advisor in one time
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues, that are being disabled in Insights Advisor one by one
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 2 issues with low severity that is being enabled in Insights Advisor

## [`ACM/cluster_list.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_list.feature)

* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by AWS infrastructure
* Displaying "Clusters" page on ACM for one managed clusters in Hibernating state managed by AWS infrastructure
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Google Cloud Platform
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Microsoft Azure
* Displaying "Clusters" page on ACM for two managed clusters

## [`ACM/cluster_view_disabled_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_view_disabled_issues.feature)

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue and 1 issue disabled in Insights Advisor

## [`ACM/cluster_view_with_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_view_with_issues.feature)

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue

## [`ACM/overview.page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/overview.page.feature)

* Displaying "Overview" page on ACM for one managed cluster in Ready state managed by AWS infrastruture

## [`ACM/overview_page_disabled_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/overview_page_disabled_issues.feature)

* Displaying "Overview" page on ACM for one managed cluster in Ready state managed by AWS infrastructure for cluster with one disabled rule

## [`ACM/recommentation_description.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/recommentation_description.feature)

* Displaying description of recommendation found for 1 cluster with 1 critical issue

## [`ACM/recommentation_description_disabled_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/recommentation_description_disabled_issues.feature)

* Displaying description of recommendation found for 1 cluster with 1 critical issue and 1 other issue disabled in Insights Advisor
* Displaying description of recommendation found for 1 cluster with 1 critical issue and 1 other issue being enabled in Insights Advisor
* Displaying description of recommendation found for 1 cluster with 2 critical issue, one issue being disabled in Insights Advisor

## [`ACM/search_disabled_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/search_disabled_issues.feature)

* Ability to search for issues on Advanced Cluster Management for one local cluster (1 rule disabled)

## [`ACM/search_issues.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/search_issues.feature)

* Ability to search for issues on Advanced Cluster Management for one local cluster
* Ability to search for issues on Advanced Cluster Management for one managed cluster

## [`ACM/upgrade_risks.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/upgrade_risks.feature)

* Displaying 1 cluster with high upgrade risk
* Displaying 1 cluster with low upgrade risk
* Displaying the overview of the clusters at risk
* Displaying the upgrade risk for 100 clusters or less
* Displaying the upgrade risk for more than 100 clusters

## [`Insights_Advisor/affected_clusters_filtering.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_filtering.feature)

* Default filtering on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Basic filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* On-the-fly filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Ability to clear filter on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## [`Insights_Advisor/affected_clusters_page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_page.feature)

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters

## [`Insights_Advisor/affected_clusters_sorting.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_sorting.feature)

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name in different order on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## [`Insights_Advisor/affected_clusters_version.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_version.feature)

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster should show the cluster version
* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters should show the cluster version
* Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters should show the cluster version

## [`Insights_Advisor/cluster_page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page.feature)

* Cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanded recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Folding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Collapsing all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## [`Insights_Advisor/cluster_page_filtering.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page_filtering.feature)

* Default filtering in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by total risk in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple total risk values in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by category in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple categories in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status all in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## [`Insights_Advisor/cluster_page_sorting.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page_sorting.feature)

* Default sort order in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by added at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by total risk at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## [`Insights_Advisor/clusters_version.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/clusters_version.feature)

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console should show the cluster version

## [`Insights_Advisor/recommendations_page.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page.feature)

* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console without any recommendations
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## [`Insights_Advisor/recommendations_page_expanded_info.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_expanded_info.feature)

* Displaying expanded information about selected recommendation with high likelihood and high impact
* Displaying expanded information about selected recommendation with medium likelihood and low impact
* Displaying expanded information about selected recommendation with critical likelihood and low impact

## [`Insights_Advisor/recommendations_page_filtering.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_filtering.feature)

* Default filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Name" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Total risk" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Clusters impacted" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter to default value on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Category" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Likelihood" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* No-op action in filter menu on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set and reset filter "Risk of change" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## [`Insights_Advisor/recommendations_page_pagination.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_pagination.feature)

* Pagination widgets displayed in Advisor recommendations page on Hybrid Cloud Console
* Goto to next page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to last page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to previous page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to first page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget

## [`Insights_Advisor/recommendations_page_sorting.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_sorting.feature)

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by total risk on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by clusters on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by added at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by different columns at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by Risk of change on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## [`DVO_Recommendations/DVO_recommendations.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/DVO_Recommendations/DVO_recommendations.feature)

* Existence of new tab named "Workloads" in Insights Advisor
* Content displyed on a new tab named "Workloads" in Insights Advisor if no DVO recommendations has been found
* Content displyed on a new tab named "Workloads" in Insights Advisor if one DVO recommendation has been found

## [`DVO_Recommendations/Smart_Proxy_REST_API.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/DVO_Recommendations/Smart_Proxy_REST_API.feature)

* Accessing Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
* Returning just active clusters in Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
* Checking organization in Smart Proxy REST API endpoint to retrieve list of all DVO namespaces for current organization
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for selected existing cluster
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for not known cluster
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for known cluster without DVO namespaces
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper cluster UUID
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper organization
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces when cluster is not specified
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for not known cluster
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for known cluster without DVO namespaces
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper cluster UUID
* Accessing Smart Proxy REST API endpoint to retrieve DVO namespaces for improper organization
* Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace
* Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace when no such namespace exists
* Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace for improper organization
* Accessing Smart Proxy REST API endpoint to retrieve information about selected DVO namespace for improper user
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace when no rules are hitting
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace when just one rule is hitting
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace when two rules are hitting
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace when no such namespace exists
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace for improper organization
* Accessing Smart Proxy REST API endpoint to retrieve list of all recommendations affecting the selected namespace for improper user

## [`DVO_Recommendations/namespace_disable.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/DVO_Recommendations/namespace_disable.feature)

* Command to disable selected DVO recommendation on Insights Advisor
* Dialog that allow user to disable selected DVO recommendation on Insights Advisor
* Disable DVO recommendation for one actually selected cluster in Insights Advisor
* Disable DVO recommendation for all clusters in Insights Advisor
* Provide justification when disabling DVO recommendation for one selected cluster in Insights Advisor
* Provide justification when disabling DVO recommendation for all clusters in Insights Advisor

## [`DVO_Recommendations/namespace_feedback.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/DVO_Recommendations/namespace_feedback.feature)


## [`SHA_Extractor/sha_extractor.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/SHA_Extractor/sha_extractor.feature)

* Check that SHA extractor service has all the information and interfaces it needs to work properly
* Check if SHA extractor is able to consume messages from Kafka
* Check if SHA extractor is able to consume messages from Kafka and then download tarball
* Check if SHA extractor is able to consume messages from Kafka, download tarball, and take SHA images
* Check if SHA extractor is able to finish the processing of SHA images

## [`smart-proxy/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/smart-proxy/smoketests.feature)

* Check if Smart Proxy application is available
* Check if Smart Proxy displays help message
* Check if Smart Proxy displays version info

## [`insights-content-service/endpoints.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-service/endpoints.feature)

* check /info endpoint response
* check /groups endpoint response
* check /status endpoint response

## [`insights-content-service/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-service/smoketests.feature)

* Check if /groups endpoint is working
* Check if /content endpoint is working
* Check if /metrics endpoint is working
* Check if /status endpoint is working
* Check if /info endpoint is working

## [`insights-content-template-renderer/endpoints.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-template-renderer/endpoints.feature)

* check /v1/rendered_reports endpoint response

## [`insights-content-template-renderer/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-template-renderer/smoketests.feature)

* Check if /v1/rendered_reports endpoint is working
* Check if /docs endpoint is working
* Check if /metrics endpoint is working

## [`insights-results-aggregator/basic_rest_api.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/basic_rest_api.feature)

* Check if the main endpoint is reachable (w/o using auth. token)
* Check if the main endpoint is reachable (with proper auth. token)
* Check if the info endpoint is reachable (w/o using auth. token)
* Check if the info endpoint is reachable (with proper auth. token)
* Check if the organizations endpoint is reachable (w/o using auth. token)
* Check if the organizations endpoint is reachable (with proper auth. token)
* Check if the organizations endpoint is reachable (with proper auth. token and filled-in database with report for one org)
* Check if the organizations endpoint is reachable (with proper auth. token and filled-in database with reports for two orgs)
* Check if the list of clusters for organization endpoint is reachable (w/o using auth. token)
* Check if the list of clusters for known organization endpoint is reachable (with proper auth. token)
* Check if the list of clusters for unknown organization endpoint is reachable (with proper auth. token)
* Check if the list of clusters for known organization endpoint is reachable (with proper auth. token and one report)
* Check if the list of clusters for known organization endpoint is reachable (with proper auth. token and two reports)
* Check if the list of disabled rules for organization endpoint is reachable (w/o using auth. token)
* Check if the list of disabled rules for known organization endpoint is reachable (with proper auth. token)
* Check if the list of disabled rules for unknown organization endpoint is reachable (with proper auth. token)

## [`insights-results-aggregator/cluster_reports.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/cluster_reports.feature)

* Check if the cluster report endpoint is reachable (w/o using auth. token)
* Check if the cluster report endpoint is reachable (w/o using auth. token) for different organization
* Check if the cluster report endpoint is reachable for correct cluster ID (with using auth. token)
* Check if the cluster report endpoint is reachable for correct cluster ID (with using auth. token) and different organization
* Check if the cluster report endpoint is reachable for incorrect cluster ID (with using auth. token)
* Check if the cluster report endpoint is reachable for two correct cluster IDs (with using auth. token)

## [`insights-results-aggregator/consumer.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/consumer.feature)

* Check if Insights Results Aggregator is able to consume messages and store results into database
* Check if Insights Results Aggregator is able to consume messages and store results into database for multiple results
* Check if Insights Results Aggregator is able to consume messages and store results into database for multiple clusters
* Check rule hits after Insights Results Aggregator consumes messages and stores results into database
* Check rule hits after Insights Results Aggregator consumes message and stores results into database for multiple results
* Check rule hits after Insights Results Aggregator consumes two messages when the second is older then the first one
* Check rule hits after Insights Results Aggregator consumes two messages when the second is newer then the first one
* Check rule hits after Insights Results Aggregator consumes message and stores results into database for multiple clusters
* Check rule hits after Insights Results Aggregator consumes message with no results

## [`insights-results-aggregator/database_access.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_access.feature)

* Check access to empty database

## [`insights-results-aggregator/database_migration.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_migration.feature)

* Check that default migration is set to 0
* Check database migration from version #0 to version #1
* Check database migration from version #0 to version #2 and back to version #1
* Check database migration from version #0 to version #3
* Check database migration from version #0 to version #4
* Check database migration from version #0 to version #5
* Check database migration from version #0 to version #6
* Check database migration from version #0 to version #7
* Check database migration from version #0 to version #8
* Check database migration from version #0 to version #9
* Check database migration from version #0 to version #10
* Check database migration from version #0 to version #11
* Check database migration from version #0 to version #12
* Check database migration from version #0 to version #13
* Check database migration from version #0 to version #14
* Check database migration from version #0 to version #15
* Check database migration from version #0 to version #16
* Check database migration from version #0 to version #17
* Check database migration from version #0 to version #18
* Check database migration from version #0 to version #19
* Check database migration from version #0 to version #20
* Check database migration from version #0 to version #21
* Check database migration from version #0 to version #22
* Check database migration from version #0 to version #23
* Check database migration from version #0 to version #24
* Check database migration from version #0 to version #25
* Check database migration from version #0 to version #26
* Check database migration from version #0 to version #27
* Check database migration from version #0 to version #28
* Check database migration from version #0 to version #29
* Check database migration from version #0 to version #30
* Check database migration from version #0 to version #31

## [`insights-results-aggregator/database_migration_downgrades.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_migration_downgrades.feature)

* Check database downgrade from version #2 to version #1
* Check database downgrade from version #3 to version #2
* Check database downgrade from version #4 to version #3
* Check database downgrade from version #5 to version #4
* Check database downgrade from version #6 to version #5
* Check database downgrade from version #7 to version #6
* Check database downgrade from version #8 to version #7
* Check database downgrade from version #9 to version #8
* Check database downgrade from version #10 to version #9
* Check database downgrade from version #11 to version #10
* Check database downgrade from version #12 to version #11
* Check database downgrade from version #13 to version #12
* Check database downgrade from version #14 to version #13
* Check database downgrade from version #15 to version #14
* Check database downgrade from version #16 to version #15
* Check database downgrade from version #17 to version #16
* Check database downgrade from version #18 to version #17
* Check database downgrade from version #19 to version #18
* Check database downgrade from version #20 to version #19
* Check database downgrade from version #21 to version #20
* Check database downgrade from version #22 to version #21
* Check database downgrade from version #23 to version #22
* Check database downgrade from version #24 to version #23
* Check database downgrade from version #25 to version #24
* Check database downgrade from version #26 to version #25
* Check database downgrade from version #27 to version #26
* Check database downgrade from version #28 to version #27
* Check database downgrade from version #29 to version #28
* Check database downgrade from version #30 to version #29
* Check database downgrade from version #31 to version #30

## [`insights-results-aggregator/list_of_clusters.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/list_of_clusters.feature)

* Check if Insights Results Aggregator service returns correct list of clusters for known organization
* Check if Insights Results Aggregator service return correct list of clusters for organization w/o access rights
* Check if Insights Results Aggregator service returns correct list of clusters for known organization and one report
* Check if Insights Results Aggregator service returns correct list of clusters for known organization and several reports
* Check if Insights Results Aggregator service returns correct list of clusters for known organization and several reports, some from different organization
* Check if Insights Results Aggregator service returns correct list of clusters for known organization without any report (all reports belong to different organization)

## [`insights-results-aggregator/list_of_organizations.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/list_of_organizations.feature)

* Check if empty list of organizations is returned when report table is empty
* Check if list with one organization is returned when report table contains one report only
* Check if list with one organization is returned when report table contains reports for one organization only
* Check if list with two organizations is returned when report table contains reports for two organizations
* Check if list with two organizations is returned when report table contains multiple reports for two organizations

## [`insights-results-aggregator/results_for_cluster_list.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/results_for_cluster_list.feature)

* Check if Insights Results Aggregator service returns results for empty list of clusters
* Check if Insights Results Aggregator service returns results for non empty list of clusters without proper report
* Check if Insights Results Aggregator service returns results for non empty list of clusters with proper report
* Check if Insights Results Aggregator service returns results for non empty list of clusters with proper report and one unknown cluster
* Check if Insights Results Aggregator service returns results for non empty list of clusters with proper report and two unknown clusters
* Check if Insights Results Aggregator service returns results for two unknown clusters

## [`insights-results-aggregator/rule_ack.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/rule_ack.feature)

* Check if Insights Results Aggregator service returns list of acked rules
* Check if Insights Results Aggregator service is able to disable one specific rule
* Check if Insights Results Aggregator service is able to disable two specific rules
* Check if Insights Results Aggregator service is able to enable already disabled one specific rule
* Check if Insights Results Aggregator service is able to enable one already disabled specific rule from two rules
* Check if Insights Results Aggregator service is able to update one specific rule
* Check if Insights Results Aggregator service is able to update non disabled specific rule
* Check if Insights Results Aggregator service is able to update one specific rule two times

## [`insights-results-aggregator/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/smoketests.feature)

* Check if Insights Results Aggregator application is available
* Check if Insights Results Aggregator displays help message
* Check if Insights Results Aggregator displays help message
* Check if Insights Results Aggregator displays version info
* Check if Insights Results Aggregator displays actual configuration
* Check if jps utility is available
* Check if ZooKeeper is running locally
* Check if Kafka broker is running locally
* Check if Kafka broker is running on expected port

## [`insights-results-aggregator/starting_service.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/starting_service.feature)

* Check how Insights Results Aggregator reacts to non existent configuration file
* Check how Insights Results Aggregator reacts to broken database configuration
* Check how Insights Results Aggregator reacts to situation when Kafka is not reachable

## [`insights-results-aggregator-cleaner/cleanup_selected_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/cleanup_selected_records.feature)

* Clean up one old cluster should be visible
* Clean up of existing old clusters
* Clean up of existing new clusters
* Clean up non-existing clusters
* Clean up clusters with wrong names

## [`insights-results-aggregator-cleaner/display_old_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/display_old_records.feature)

* Read old records from empty database
* Read old records from empty database giving different time period
* Read old records from prepared non-empty database with new records only
* Read old records from prepared non-empty database with old records only
* Read old records from prepared non-empty database with mixed records

## [`insights-results-aggregator-cleaner/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/smoketests.feature)

* Check if cleaner application is available
* Check if cleaner displays help message
* Check if cleaner displays version info
* Check if cleaner displays authors
* Check if cleaner displays actual configuration
* Check if Postgres database is available

## [`insights-results-aggregator-cleaner/vacuuming.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/vacuuming.feature)

* Vacuum the database

## [`insights-results-aggregator-exporter/database_access.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/database_access.feature)

* Check access to empty database
* Check table creation on deletion

## [`insights-results-aggregator-exporter/export_log.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/export_log.feature)

* Check export empty tables into file with producing log file
* Check export empty tables and metadata table into file with producing log file

## [`insights-results-aggregator-exporter/file_export.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export.feature)

* Check export empty tables into file
* Check export from REPORT table
* Check export from ADVISOR_RATINGS table
* Check export from CLUSTER_RULE_TOGGLE table
* Check export from CLUSTER_RULE_USER_FEEDBACK table
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table
* Check export from RULE_HIT table
* Check export from RECOMMENDATION table
* Check export from MIGRATION_INFO table
* Check export from ADVISOR_RATINGS table
* Check export from CLUSTER_RULE_TOGGLE table
* Check export from CLUSTER_RULE_USER_FEEDBACK table
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table
* Check export from RULE_HIT table
* Check export from RECOMMENDATION table
* Check export from CONSUMER_ERROR table
* Check export from REPORT_INFO table
* Check export from RULE_DISABLE table

## [`insights-results-aggregator-exporter/file_export_metadata.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export_metadata.feature)

* Check export metadata table into file
* Check export metadata table into file when REPORT table is not empty
* Check export metadata table into file when ADVISOR_RATINGS table is not empty
* Check export metadata table into file when CLUSTER_RULE_TOGGLE table is not empty
* Check export metadata table into file when CLUSTER_RULE_USER_FEEDBACK table is not empty
* Check export metadata table into file when CLUSTER_USER_RULE_DISABLE_FEEDBACK table is not empty
* Check export metadata table into file when RULE_HIT table is not empty
* Check export metadata table into file when RECOMMENDATION table is not empty
* Check export metadata table into file when MIGRATION_INFO table is not empty
* Check export metadata table into file when ADVISOR_RATINGS table is not empty
* Check export metadata table into file when CLUSTER_RULE_TOGGLE table is not empty
* Check export metadata table into file when CLUSTER_RULE_USER_FEEDBACK table is not empty
* Check export metadata table into file when CLUSTER_USER_RULE_DISABLE_FEEDBACK table is not empty
* Check export metadata table into file when RULE_HIT table is not empty
* Check export metadata table into file when RECOMMENDATION table is not empty
* Check export metadata table into file when CONSUMER_ERROR table is not empty
* Check export metadata table into file when REPORT_INFO table is not empty
* Check export metadata table into file when RULE_DISABLE table is not empty

## [`insights-results-aggregator-exporter/file_export_with_limit.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export_with_limit.feature)

* Check export empty tables into file with record limit explicitly set to 2
* Check export from REPORT table with record limit explicitly set to 2
* Check export from ADVISOR_RATINGS table with record limit explicitly set to 2
* Check export from CLUSTER_RULE_TOGGLE table with record limit explicitly set to 2
* Check export from CLUSTER_RULE_USER_FEEDBACK table with record limit explicitly set to 2
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with record limit explicitly set to 2
* Check export from RULE_HIT table with record limit explicitly set to 2
* Check export from RECOMMENDATION table with record limit explicitly set to 2
* Check export from MIGRATION_INFO table with record limit explicitly set to 2
* Check export from ADVISOR_RATINGS table with record limit explicitly set to 2
* Check export from CLUSTER_RULE_TOGGLE table with record limit explicitly set to 2
* Check export from CLUSTER_RULE_USER_FEEDBACK table with record limit explicitly set to 2
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with record limit explicitly set to 2
* Check export from RULE_HIT table with record limit explicitly set to 2
* Check export from RECOMMENDATION table with record limit explicitly set to 2
* Check export from CONSUMER_ERROR table with record limit explicitly set to 2
* Check export from REPORT_INFO table with record limit explicitly set to 2
* Check export from RULE_DISABLE table with record limit explicitly set to 2
* Check export empty tables into file with limit explicitly set to zero
* Check export from REPORT table with limit explicitly set to zero
* Check export from ADVISOR_RATINGS table with limit explicitly set to zero
* Check export from CLUSTER_RULE_TOGGLE table with limit explicitly set to zero
* Check export from CLUSTER_RULE_USER_FEEDBACK table with limit explicitly set to zero
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with limit explicitly set to zero
* Check export from RULE_HIT table with limit explicitly set to zero
* Check export from RECOMMENDATION table with limit explicitly set to zero
* Check export from MIGRATION_INFO table with limit explicitly set to zero
* Check export from ADVISOR_RATINGS table with limit explicitly set to zero
* Check export from CLUSTER_RULE_TOGGLE table with limit explicitly set to zero
* Check export from CLUSTER_RULE_USER_FEEDBACK table with limit explicitly set to zero
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with limit explicitly set to zero
* Check export from RULE_HIT table with limit explicitly set to zero
* Check export from RECOMMENDATION table with limit explicitly set to zero
* Check export from CONSUMER_ERROR table with limit explicitly set to zero
* Check export from REPORT_INFO table with limit explicitly set to zero
* Check export from RULE_DISABLE table with limit explicitly set to zero

## [`insights-results-aggregator-exporter/s3_export.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export.feature)

* Check export empty tables into S3/Minio
* Check export from REPORT table into S3/Minio
* Check export from ADVISOR_RATINGS table into S3/Minio
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio
* Check export from RULE_HIT table into S3/Minio
* Check export from RECOMMENDATION table into S3/Minio
* Check export from MIGRATION_INFO table into S3/Minio
* Check export from ADVISOR_RATINGS table into S3/Minio
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio
* Check export from RULE_HIT table into S3/Minio
* Check export from RECOMMENDATION table into S3/Minio
* Check export from CONSUMER_ERROR table into S3/Minio
* Check export from REPORT_INFO table into S3/Minio
* Check export from RULE_DISABLE table into S3/Minio

## [`insights-results-aggregator-exporter/s3_export_metadata.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export_metadata.feature)

* Check export metadata table into S3 object
* Check export metadata table into S3 object when REPORT table is not empty
* Check export metadata table into S3 object when ADVISOR_RATINGS table is not empty
* Check export metadata table into S3 object when CLUSTER_RULE_TOGGLE table is not empty
* Check export metadata table into S3 object when CLUSTER_RULE_USER_FEEDBACK table is not empty
* Check export metadata table into S3 object when CLUSTER_USER_RULE_DISABLE_FEEDBACK table is not empty
* Check export metadata table into S3 object when RULE_HIT table is not empty
* Check export metadata table into S3 object when RECOMMENDATION table is not empty
* Check export metadata table into S3 object when MIGRATION_INFO table is not empty
* Check export metadata table into S3 object when ADVISOR_RATINGS table is not empty
* Check export metadata table into S3 object when CLUSTER_RULE_TOGGLE table is not empty
* Check export metadata table into S3 object when CLUSTER_RULE_USER_FEEDBACK table is not empty
* Check export metadata table into S3 object when CLUSTER_USER_RULE_DISABLE_FEEDBACK table is not empty
* Check export metadata table into S3 object when RULE_HIT table is not empty
* Check export metadata table into S3 object when RECOMMENDATION table is not empty
* Check export metadata table into S3 object when CONSUMER_ERROR table is not empty
* Check export metadata table into S3 object when REPORT_INFO table is not empty
* Check export metadata table into S3 object when RULE_DISABLE table is not empty

## [`insights-results-aggregator-exporter/s3_export_with_limit.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export_with_limit.feature)

* Check export empty tables into S3/Minio with record limit explicitly set to 2
* Check export from REPORT table into S3/Minio with record limit explicitly set to 2
* Check export from ADVISOR_RATINGS table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio with record limit explicitly set to 2
* Check export from RULE_HIT table into S3/Minio with record limit explicitly set to 2
* Check export from RECOMMENDATION table into S3/Minio with record limit explicitly set to 2
* Check export from MIGRATION_INFO table into S3/Minio with record limit explicitly set to 2
* Check export from ADVISOR_RATINGS table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio with record limit explicitly set to 2
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio with record limit explicitly set to 2
* Check export from RULE_HIT table into S3/Minio with record limit explicitly set to 2
* Check export from RECOMMENDATION table into S3/Minio with record limit explicitly set to 2
* Check export from CONSUMER_ERROR table into S3/Minio with record limit explicitly set to 2
* Check export from REPORT_INFO table into S3/Minio with record limit explicitly set to 2
* Check export from RULE_DISABLE table into S3/Minio with record limit explicitly set to 2
* Check export empty tables into S3/Minio with limit explicitly set to zero
* Check export from REPORT table into S3/Minio with limit explicitly set to zero
* Check export from ADVISOR_RATINGS table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio with limit explicitly set to zero
* Check export from RULE_HIT table into S3/Minio with limit explicitly set to zero
* Check export from RECOMMENDATION table into S3/Minio with limit explicitly set to zero
* Check export from MIGRATION_INFO table into S3/Minio with limit explicitly set to zero
* Check export from ADVISOR_RATINGS table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_RULE_TOGGLE table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_RULE_USER_FEEDBACK table into S3/Minio with limit explicitly set to zero
* Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table into S3/Minio with limit explicitly set to zero
* Check export from RULE_HIT table into S3/Minio with limit explicitly set to zero
* Check export from RECOMMENDATION table into S3/Minio with limit explicitly set to zero
* Check export from CONSUMER_ERROR table into S3/Minio with limit explicitly set to zero
* Check export from REPORT_INFO table into S3/Minio with limit explicitly set to zero
* Check export from RULE_DISABLE table into S3/Minio with limit explicitly set to zero

## [`insights-results-aggregator-exporter/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/smoketests.feature)

* Check if exporter application is available
* Check if exporter displays help message
* Check if exporter displays version info
* Check if exporter displays authors
* Check if exporter displays configuration

## [`insights-results-aggregator-mock/basic_rest_api.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/basic_rest_api.feature)

* Check if the main endpoint is reachable
* Check the groups endpoint
* Check the organizations endpoint

## [`insights-results-aggregator-mock/cluster_report.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/cluster_report.feature)

* Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits without org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits without org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with one rule hit without org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with no rule hits without org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits with org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with 7 rule hits with org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with one rule hit with org. selector
* Check if Insights Results Aggregator Mock service return correct cluster report with no rule hits with org. selector

## [`insights-results-aggregator-mock/clusters_hitting_rule.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/clusters_hitting_rule.feature)

* Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.cluster_wide_proxy_auth_check
* Check if Insights Results Aggregator Mock service returns correct list of clusters for rule minimum requirements
* Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.bug_rules.bug_1766907
* Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.nodes_kubelet_version_check
* Check if Insights Results Aggregator Mock service returns correct list of clusters for rule ccx_rules_ocp.external.rules.samples_op_failed_image_import_check

## [`insights-results-aggregator-mock/content_info.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/content_info.feature)

* Check if Insights Results Aggregator Mock service return correct list of groups

## [`insights-results-aggregator-mock/list_of_clusters.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_clusters.feature)

* Check if Insights Results Aggregator Mock service return correct list of clusters for organization 1
* Check if Insights Results Aggregator Mock service return correct list of clusters for organization 2
* Check if Insights Results Aggregator Mock service return correct list of clusters for organization 3
* Check if Insights Results Aggregator Mock service return correct list of clusters for organization with many clusters
* Check if Insights Results Aggregator Mock service return correct list of clusters for organization w/o access rights

## [`insights-results-aggregator-mock/list_of_groups.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_groups.feature)

* Check if Insights Results Aggregator Mock service return correct list of groups

## [`insights-results-aggregator-mock/list_of_organizations.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_organizations.feature)

* Check if Insights Results Aggregator Mock service return correct list of organizations

## [`insights-results-aggregator-mock/rest_api_clusters.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/rest_api_clusters.feature)

* Check if is is possible to get list of clusters for given organization #1
* Check if is is possible to get list of clusters for given organization #2
* Check if is is possible to get list of clusters for organization w/o access rights

## [`insights-results-aggregator-mock/results_for_cluster_list.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/results_for_cluster_list.feature)

* Check if Insights Results Aggregator Mock service returns results for list of four known clusters
* Check if Insights Results Aggregator Mock service returns results for list of three known clusters
* Check if Insights Results Aggregator Mock service returns results for list of three known clusters
* Check if Insights Results Aggregator Mock service returns results for list of one known cluster
* Check if Insights Results Aggregator Mock service returns results for empty list of clusters
* Check if Insights Results Aggregator Mock service returns results for one unknown cluster
* Check if Insights Results Aggregator Mock service returns results for two unknown clusters

## [`insights-results-aggregator-mock/rule_ack.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/rule_ack.feature)

* Check if Insights Results Aggregator Mock service returns list of acked rules
* Check if it is possible to ack new rule
* Check if it is possible to delete acknowledgement
* Check if it is possible to ack already acked rule w/o changing the internal state of the service
* Check the behaviour when ACK for non existing rule is to be deleted
* Check if it is possible to ack new rule without providing justification
* Check if it is possible to ack already acked rule without providing justification
* Check if it is possible to change justification text of already acked rule
* Check the behaviour when acked rule to be changed does not exist

## [`insights-results-aggregator-mock/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/smoketests.feature)

* Check if Insights Results Aggregator Mock application is available
* Check if Insights Results Aggregator Mock displays help message
* Check if Insights Results Aggregator Mock displays version info
* Check if Insights Results Aggregator Mock displays authors
* Check if Insights Results Aggregator Mock displays actual configuration

## [`insights-results-aggregator-mock/upgrades.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/upgrades.feature)

* Check if Insights Results Aggregator Mock service returns upgrade recommended for a cluster without risks
* Check if Insights Results Aggregator Mock service returns upgrade not recommended for a cluster with risks
* Check if Insights Results Aggregator Mock service returns 204 NoContent for a managed cluster
* Check if Insights Results Aggregator Mock service returns 503 if AMS is not available
* Check if Insights Results Aggregator Mock service returns 503 if Upgrade service is not available
* Check if Insights Results Aggregator Mock service returns 404 if the cluster has no data in RHOBS

## [`ccx-notification-service/cleanup_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/cleanup_records.feature)

* Check the ability to clean up old records from `new_reports` table if the table is empty.
* Check the ability to clean up old records from `reported` if the table is empty.
* Check the ability to clean up old records from `new_reports` if the table contains one old report.
* Check the ability to clean up old records from `new_reports` table if the table contains multiple old reports.
* Check the ability to clean up old records from `reported` table if the table contains one old report.
* Check the ability to clean up old records from `reported` table if the table contains two old reports.
* Check that newest records in `new_reports` table are not deleted by cleanup - one new record only.
* Check that newest records in `new_reports` table are not deleted by cleanup - multiple new records only.
* Check that newest records in `new_reports` table are not deleted by cleanup - old and new records.
* Check the ability to clean up old records from `reported` table if the table is not empty - contains one new report.
* Check the ability to clean up old records from `reported` table if the table is not empty and contains only new reports.
* Check the ability to clean up old records from `reported` table if the table is not empty and contains old and new reports.

## [`ccx-notification-service/cli_flags.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/cli_flags.feature)

* Check if CCX Notification Service displays help message
* Check if CCX Notification Service displays version info
* Check if CCX Notification Service displays configuration
* Check if CCX Notification Service displays authors
* Check the ability to display new reports for cleanup
* Check the ability to display old reports for cleanup
* Check the ability to display new reports for cleanup with max-age specified
* Check the ability to display old reports for cleanup with max-age specified
* Check the ability to perform database cleanup on startup

## [`ccx-notification-service/configuration.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/configuration.feature)

* Check that notification service exits with exit code 1 if no destination is configured
* Check that notification-to-notification-backend is not started and exits with status 4 if rules cannot be fetched
* Check that notification-to-service-log is not started and exits with status 4 if rules cannot be fetched

## [`ccx-notification-service/customer_notifications.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/customer_notifications.feature)

* Check that notification service does not need kafka if database has no new report
* Check that notification service does not send messages to kafka if broker is disabled and service log enabled
* Check that notification service produces instant notifications with the expected content if all dependencies are available
* Check that notification service produces a single notification event for cluster with multiple new reports
* Check that instant notification does not include the same reports as in previous notification
* Check that notification service does not flood customer with unnecessary instant emails
* Check that notification service resends notification after cooldown has passed

## [`ccx-notification-service/display_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/display_records.feature)

* Check the ability to display old records from `new_reports` if the table is empty.
* Check the ability to display old records from `reported` table if the table is empty.
* Check the ability to display old records from `new_reports` if the table contains one old report.
* Check the ability to display old records from `new_reports` if the table contains only new reports.
* Check the ability to display old records from `new_reports` if the table contains new and old reports.
* Check the ability to display old records from `reported` if the table contains one old report.
* Check the ability to display old records from `reported` if the table contains only new reports.
* Check the ability to display old records from `reported` if the table contains multiple old reports.
* Check the ability to display old records from `reported` if the table contains old and new reports

## [`ccx-notification-service/service_log.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/service_log.feature)

* Check that notification service does not send messages to service log if it is disabled
* Check that notification service sends messages to service log if it is enabled
* Check that notification service includes correct service name if set
* Check that notification service does not send messages to service log if it cannot be rendered
* Check that notification service doesn't send message to service log if it is not moderate
* Check that notification service sends log events for the configured total risk threshold
* Check that notification service doesn't send message that has been sent within cooldown
* Check that notification service resends message after cooldown has passed
* Check that notification service produces a single notification event for cluster with multiple new reports
* Check that Kafka related rows in reported table do not affect notifications sent to service log

## [`ccx-notification-service/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/smoketests.feature)

* Check if CCX Notification Service application is available
* Check if kcat utility is available
* Check if jps utility is available
* Check if CCX Notification database can be reached
* Check if ZooKeeper is running locally
* Check if Kafka broker is running locally
* Check if Kafka broker is running on expected port
* Check if content-service dependency is available on expected port
* Check if prometheus push gateway dependency is available on expected port

## [`ccx-notification-writer/cleanup_new_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cleanup_new_records.feature)

* Check the ability to clean up old records from `new_reports` table if the table is empty.
* Check the ability to clean up old records from `reported` table if the table is empty.
* Check the ability to clean up old records from `new_reports` table if the table is not empty.
* Check the ability to clean up old records from `new_reports` table if the table is not empty and contains two new reports.
* Check the ability to clean up old records from `new_reports` table if the table is not empty and contains old and new reports.
* Check the ability to clean up old records from `reported` table if the table is not empty - contains one new report.
* Check the ability to clean up old records from `reported` table if the table is not empty and contains only new reports.
* Check the ability to clean up old records from `reported` table if the table is not empty and contains old and new reports.

## [`ccx-notification-writer/cleanup_old_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cleanup_old_records.feature)

* Check the ability to clean up old records from `new_reports` table if the table is empty.
* Check the ability to clean up old records from `reported` table if the table is empty.
* Check the ability to clean up old records from `new_reports` table if the table contains one old report.
* Check the ability to clean up old records from `new_reports` table if the table contains two old reports.
* Check the ability to clean up old records from `reported` table if the table contains one old report.
* Check the ability to clean up old records from `reported` table if the table contains two old reports.

## [`ccx-notification-writer/cli_flags.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cli_flags.feature)

* Check if CCX Notification Writer displays help message
* Check if CCX Notification Writer displays version info
* Check if CCX Notification Writer displays authors
* Check the ability to initialize migration info table
* Check the ability to initialize all database tables
* Check the ability to perform database cleanup
* Check the ability to drop all database tables when database is migrated to initial version

## [`ccx-notification-writer/display_old_records.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/display_old_records.feature)

* Check the ability to display old records from `new_reports` table if the table is empty.
* Check the ability to display old records from `reported` table if the table is empty.
* Check the ability to display old records from `new_reports` table if the table is not empty and contains old report.
* Check the ability to display old records from `new_reports` table if the table is not empty and contains new report.
* Check the ability to display old records from `new_reports` table if the table is not empty and contains old reports.
* Check the ability to display old records from `new_reports` table if the table is not empty and contains new reports.
* Check the ability to display old records from `new_reports` table if the table is not empty and contains mixed reports.
* Check the ability to display old records from `reported` table if the table is not empty and contains one old report.
* Check the ability to display old records from `reported` table if the table is not empty and contains one new report.
* Check the ability to display old records from `reported` table if the table is not empty and contains old reports.
* Check the ability to display old records from `reported` table if the table is not empty and contains old reports and contains new reports.
* Check the ability to display old records from `reported` table if the table is not empty and contains old reports and contains mixed reports.

## [`ccx-notification-writer/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/smoketests.feature)

* Check if CCX Notification Writer application is available
* Check if kcat utility is available
* Check if jps utility is available
* Check if CCX Notification Writer database can be reached
* Check if ZooKeeper is running locally
* Check if Kafka broker is running locally
* Check if Kafka broker is running on expected port

## [`ccx-upgrades-inference/perform_inference.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-upgrades-inference/perform_inference.feature)

* Check Inference Service response with no body is sent in the request
* Check Inference Service response with an invalid body is used in the request
* Check Inference Service response with a valid body with invalid data is used in the request
* Check Inference Service predicts risk for degraded operator condition
* Check Inference Service does not predict risk for available operator conditions
* Check Inference Service predicts risk for 2 alerts with critical severity
* Check Inference Service does not predict risk for 2 alerts with info severity
* Check Inference Service does not predict risk for 1 alert with critical severity
* Check Inference Service predicts risk for not available operator condition

## [`ccx-upgrades-inference/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-upgrades-inference/smoketests.feature)

* Check if CCX Upgrade Risk Inference Service application is available
* Check if CCX Upgrade Risk Inference Service can be run

## [`ccx-upgrades-data-eng/caching.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-upgrades-data-eng/caching.feature)

* Check that nothing is cached if CACHE_ENABLED is set to 0
* Check that nothing is cached if CACHE_TTL is set to 0
* Check that nothing is cached if CACHE_SIZE is set to 0
* Check Data Engineering Service response with a valid cluster ID is properly cached
* Check maximum size of cache
* Check LRU eviction of items if maximum size is reached
* Check that entries are evicted properly when TTL expires

## [`ccx-upgrades-data-eng/request_prediction.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-upgrades-data-eng/request_prediction.feature)

* Check Data Engineering Service response with an invalid cluster ID in the request
* Check Data Engineering Service response with a valid cluster ID
* Check Data Engineering Service removes duplicates from the response
* Check Data Engineering Service maps the FOC condition correctly
* Check Data Engineering Service response with a valid cluster ID but no cluster version

## [`ccx-upgrades-data-eng/smoketests.feature`](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-upgrades-data-eng/smoketests.feature)

* Check if CCX Upgrade Risk Data Engineering Service application is available
* Check if CCX Upgrade Risk Data Engineering Service can be run

