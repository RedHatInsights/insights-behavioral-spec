# Description
Directory where feature files with scenarios and scenario outlines are stored.

# List of scenarios

## `OCM/login.feature`

* Login into console.redhat.com
* Login into OCM UI

## `OCM/insights_tab.feature`

* Insights tab for cluster without any issue
* Insights tab for cluster that does not send any insights-operator archive
* Insights tab for cluster with 1 potential security issue identified

## `OCM/rule_feedback.feature`

* Displaying rule feedback controls on OCM UI
* Upvote for rule on OCM UI
* Downvote for rule on OCM UI
* Upvote then downvote for rule on OCM UI

## `OCM/single_rule_page.feature`

* Displaying single rule page in OCM UI

## `OCM/cluster_list.feature`

* Displaying info about no clusters on OCM UI ("empty list")
* Displaying list of clusters on OCM UI

## `OCM/cluster_overview.feature`

* Display cluster overview page on OCM UI for cluster w/o any issues
* Display cluster overview page on OCM UI for cluster with one critical issue
* Display cluster overview page on OCM UI for cluster with one critical issue and one low issue
* Display cluster overview page on OCM UI for cluster with two moderate issues

## `OCP_WebConsole/login.feature`

* Login into OCP WebConsole via console.redhat.com

## `OCP_WebConsole/insights.feature`

* Insights on OCP WebConsole for a cluster without any issue
* Insights on OCP WebConsole for a cluster that does not send any insights-operator archive
* Insights on OCP WebConsole for a situation when REST API is not accessbile
* Insights on OCP WebConsole for a cluster with 1 critical issue
* Insights on OCP WebConsole for a cluster with 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue and 2 critical issues
* Insights on OCP WebConsole for a cluster with 1 low issue, 1 important issue, and 1 moderate issue
* Insights on OCP WebConsole for a cluster with 10 low issues

## `OCP_WebConsole/to_cluster_page.feature`

* Using link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI

## `OCM/disable_rule_on_OCP.feature`

* Disabling rule in OCM user interface should be visible in OCP WebConsole as well

## `OCM/disable_rule.feature`

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

## `OCM/disable_rule_on_ACM.feature`

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

## `ACM/overview.page.feature`

* Displaying "Overview" page on ACM for one managed cluster in Ready state managed by AWS infrastruture

## `ACM/cluster_list.feature`

* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by AWS infrastruture
* Displaying "Clusters" page on ACM for one managed clusters in Hibernating state managed by AWS infrastruture
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Google Cloud Platform
* Displaying "Clusters" page on ACM for one managed clusters in Ready state managed by Microsoft Azure
* Displaying "Clusters" page on ACM for two managed clusters

## `ACM/cluster_issues_section`

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with no issues
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 important issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 moderate issue
* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 low issue
* Displaying "Cluster issues" section on "Overview" page - 2 clusters each having 1 low issue

## `ACM/search_issues.feature`

* Ability to search for issues on Advanced Cluster Management for one local cluster
* Ability to search for issues on Advanced Cluster Management for one managed cluster

## `ACM/cluster_view_with_issues.feature`

* Displaying "Cluster issues" section on "Overview" page - 1 cluster with 1 critical issue

## `ACM/recommentation_description.feature`

* Displaying description of recommendation found for 1 cluster with 1 critical issue

## `Insights_Advisor/recommendations_page.feature`

* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console without any recommendations
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## `Insights_Advisor/recommendations_page_expanded_info.feature`

* Displaying expanded information about selected recommendation with high likelihood and high impact
* Displaying expanded information about selected recommendation with medium likelihood and low impact
* Displaying expanded information about selected recommendation with critical likelihood and low impact

## `Insights_Advisor/recommendations_page_pagination.feature`

* Pagination widgets displayed in Advisor recommendations page on Hybrid Cloud Console
* Goto to next page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to last page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to previous page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget
* Goto to first page in Advisor recommendations page on Hybrid Cloud Console using top right pagination widget

## `Insights_Advisor/recommendations_page_filtering.feature`

* Default filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Name" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Total risk" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Clusters impacted" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Reset filter to default value on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Category" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Set filter "Likelihood" on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters
* No-op action in filter menu on Advisor's "Recommendations" page on Hybrid Cloud Console with at least one recommendation and two clusters

## `Insights_Advisor/recommendations_page_sorting.feature`

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by total risk on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by clusters on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by added at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by different columns at on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor/affected_clusters_page.feature`

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster
* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters
* Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters

## `Insights_Advisor/affected_clusters_sorting.feature`

* Default sorting on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Sorting by name in different order on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor/affected_clusters_version.feature`

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster should show the cluster version
* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and two clusters should show the cluster version
* Pagination on "Affected clusters" page on Hybrid Cloud Console with more than 10 clusters should show the cluster version

## `Insights_Advisor/affected_clusters_filtering.feature`

* Default filtering on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Basic filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* On-the-fly filtering by name on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters
* Ability to clear filter on Advisor's "Recommendations" page on Hybrid Cloud Console with five recommendations and four clusters

## `Insights_Advisor/cluster_page.feature`

* Cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanded recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Folding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding recommendation on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Expanding all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Collapsing all recommendations on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `Insights_Advisor/cluster_page_sorting.feature`

* Default sort order in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by added at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Sorting by total risk at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `Insights_Advisor/cluster_page_filtering.feature`

* Default filtering in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by total risk in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple total risk values in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by category in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by multiple categories in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
* Filtering by status all in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster

## `Insights_Advisor/cluster_version.feature`

* Displaying Advisor's "Affected clusters" page on Hybrid Cloud Console with at least one recommendation and one cluster should show the cluster version

## `Notification_Service/customer_notifications.feature`

* Check that notification service has all the information it needs to work properly
* Check that notification service produces instant notifications with the expected content
* Check that notification service produces instant notifications with the expected content
* Check that notification are sent to user when events are sent to the notification service's kafka topic
* Check that instant notification does not include the same reports as in previous notification
* Check that notification service does not flood custer with unnecessary instant emails

## `SHA_Extractor/sha_extractor.feature`

* Check that SHA exctractor service has all the information it needs to work properly
* Check if SHA extractor is able to consume messages from Kafka
* Check if SHA extractor is able to consume messages from Kafka and download tarball
* Check if SHA extractor is able to consume messages from Kafka, download tarball, and take SHA images
* Check if SHA extractor is able to finish the processing of SHA images

## `insights-results-aggregator-cleaner/smoketests.feature`

* Check if cleaner application is available
* Check if cleaner displays help message
* Check if cleaner displays version info
* Check if cleaner displays authors
* Check if Postgres database is available
* Check if the test database does not contain tables to be created by tests

## `insights-results-aggregator-cleaner/display_old_records.feature`

* Read old records from empty database
* Read old records from empty database giving different time period
* Read old records from prepared non-empty database with new records only
* Read old records from prepared non-empty database with old records only
* Read old records from prepared non-empty database with mixed records

## `insights-results-aggregator-cleaner/cleanup_selected_records.feature`

* Clean up one old cluster should be visible
* Clean up of existing old clusters
* Clean up of existing new clusters
* Clean up non-existing clusters
* Clean up clusters with wrong names

## `insights-results-aggregator-exporter/smoketests.feature`

* Check if exporter application is available
* Check if exporter displays help message
* Check if exporter displays version info
* Check if exporter displays authors
* Check if exporter displays configuration

## `insights-results-aggregator-exporter/database_access.feature`

* Check access to empty database
* Check table creatinon on deletion

## `insights-results-aggregator-exporter/file_export.feature`

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

## `insights-results-aggregator-exporter/file_export_metadata.feature`

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

## `insights-results-aggregator-exporter/s3_export.feature`

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

## `insights-results-aggregator-exporter/s3_export_metadata.feature`

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
