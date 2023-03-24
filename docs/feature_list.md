---
layout: page
nav_order: 2
---

# List of existing behavioral specifications (features)

## OCM UI

* [Login into console.redhat.com](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/login.feature)
* [List of clusters page on OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/cluster_list.feature)
* [Insights tab on OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/insights_tab.feature)
* [Cluster overview page on OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/cluster_overview.feature)
* [Single rule page in OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/single_rule_page.feature)
* [Rule feedback ability on OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/rule_feedback.feature)
* [Disabling rule in OCM user interface](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/disable_rule.feature)
* [Disabling rule in OCM user interface should NOT be visible in ACM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCM/disable_rule_on_ACM.feature)
* [Disabling rule in OCM user interface should be visible in OCP WebConsole as well](features/OCM/disable_rule_on_OCP.feature)


## OCP WebConsole

* [Login into OCP WebConsole](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/login.feature)
* [Insights displayed on OCP WebConsole](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/insights.feature)
* [Link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/OCP_WebConsole/to_cluster_page.feature)


## Advanced Cluster Management

* [Overview page behaviour on Advanced Cluster Management](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/overview_page.feature)
* [Overview page behaviour on Advanced Cluster Management in case some or all issues are disabled in Insights Advisor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/overview_page_disabled_issues.feature)
* [List of clusters on ACM](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_list.feature)
* [Cluster issues section on Overview page on ACM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_issues_section.feature)
* [Cluster issues section on Overview page on ACM UI in case some or all issues are disabled in Insights Advisor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_issues_section_disabled_issues.feature)
* [Search for issues](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/search_issues.feature)
* [Search for issues in case some or all issues are disabled in Insights Advisor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/search_disabled_issues.feature)
* [Cluster view with issues on ACM UI](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_view_with_issues.feature)
* [Cluster view with issues on ACM UI in case some or all issues are disabled in Insights Advisor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/cluster_view_disabled_issues.feature)
* [Recommendation description view](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/recommentation_description.feature)
* [Recommendation description view in case some or all issues are disabled in Insights Advisor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ACM/recommentation_description_disabled_issues.feature)


## Insights Advisor

* [Advisor recommendations page behaviour on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page.feature)
* [Expanding information about selected recommendation](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_expanded_info.feature)
* [Pagination feature in Advisor recommendations page on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_pagination.feature)
* [Filtering feature in Advisor recommendations page on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_filtering.feature)
* [Sorting feature in Advisor recommendations page on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/recommendations_page_sorting.feature)
* [Cluster view page with recommendations behaviour on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_page.feature)
* [Sorting feature in Affected clusters page on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_sorting.feature)
* [Filtering feature in Affected clusters page on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/affected_clusters_filtering.feature)
* [Cluster view page with recommendations behaviour on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page.feature)
* [Filtering feature in Cluster view page with recommendations behaviour on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page_filtering.feature)
* [Sorting feature in Cluster view page with recommendations behaviour on Hybrid Cloud Console](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Insights_Advisor/cluster_page_sorting.feature)


## Customer Notifications

* [Customer Notifications](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/Notification_Service/customer_notifications.feature)

### CCX Notification Writer

* [Basic set of smoke tests - checks if all required tools are available and all services are running](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/smoketests.feature)
* [Check command line options provided by CCX Notification Writer](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cli_flags.feature)
* [Ability to clean up old records stored in database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cleanup_old_records.feature)
* [Ability to clean up old records stored in database with new records](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/cleanup_new_records.feature)
* [Ability to display old records stored in database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-writer/display_old_records.feature)

### CCX Notification Service

* [Basic set of smoke tests - checks if all required tools are available and all services are running](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/smoketests.feature)
* [Check command line options provided by CCX Notification Service](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/cli_flags.feature)
* [Integration with Customer Notifications](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/customer_notifications.feature)
* [Integration with Service Log](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/service_log.feature)
* [Ability to clean up records stored in database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/cleanup_records.feature)
* [Ability to display old records stored in database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/ccx-notification-service/display_records.feature)

## SHA Extractor

* [SHA Extractor](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/SHA_Extractor/sha_extractor.feature)


## Smart Proxy

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/smart-proxy/smoketests.feature)


## Insights Content Service

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-service/smoketests.feature)
* [Test the service endpoints](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-content-service/endpoints.feature)

## Insights Results Aggregator

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/smoketests.feature)
* [Ability to access database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_access.feature)
* [Database migration tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_migration.feature)
* [Database migration downgrades tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/database_migration_downgrades.feature)
* [Checking Aggregator behaviour during starting the service](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/starting_service.feature)
* [Basic REST API endpoints provided by Insights Results Aggregator](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/basic_rest_api.feature)
* [Checking responses from Insights Results Aggregator service: "organizations" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/list_of_organizations.feature)
* [Checking responses from Insights Results Aggregator service: "{organization}/clusters" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/list_of_clusters.feature)
* [Checking REST API endpoint that returns results for provided list of clusters](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/results_for_cluster_list.feature)
* [Checks for cluster reports provided by Insights Results Aggregator](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator/cluster_reports.feature)


## Insights Results Aggregator Cleaner service

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/smoketests.feature)
* [Ability to display old records](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/display_old_records.feature)
* [Ability to delete selected records](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/cleanup_selected_records.feature)
* [Ability to vacuum database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-cleaner/vacuuming.feature)



## Insights Results Aggregator Exporter service

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/smoketests.feature)
* [Ability to access database](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/database_access.feature)
* [Ability to export tables into file](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export.feature)
* [Ability to export tables into file with max limit of records set](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export_with_limit.feature)
* [Ability to export metadata into file](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/file_export_metadata.feature)
* [Ability to export tables into S3](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export.feature)
* [Ability to export tables into S3 with max limit of records set](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export_with_limit.feature)
* [Ability to export metadata into S3](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/s3_export_metadata.feature)
* [Ability to export log into file](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-exporter/export_log.feature)



## Insights Results Aggregator Mock service

* [Basic set of smoke tests](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/smoketests.feature)
* [REST API endpoints provided by Insights Results Aggregator Mock](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/basic_rest_api.feature)
* [Tests for cluster list endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/rest_api_clusters.feature)
* [Checking responses from Insights Results Aggregator Mock service: "groups" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_groups.feature)
* [Checking responses from Insights Results Aggregator Mock service: "content" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/content_info.feature)
* [Checking responses from Insights Results Aggregator Mock service: "organizations" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_organizations.feature)
* [Checking responses from Insights Results Aggregator Mock service: "{organization}/clusters" endpoint](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/list_of_clusters.feature)
* [Checking responses from Insights Results Aggregator Mock service: endpoint to return cluster report](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/cluster_report.feature)
* [Reading acked rules, acking new rule and acking existing rule](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/smoketests.featurehttps://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/rule_ack.feature)
* [Checking REST API endpoint that returns list of clusters hitting specified rule](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/clusters_hitting_rule.feature)
* [Checking REST API endpoint that returns results for provided list of clusters](https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features/insights-results-aggregator-mock/results_for_cluster_list.feature)

