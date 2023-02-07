# insights-behavioral-spec
Behavioral specifications for Insights pipelines and its integration into OCM, OCP, and ACM

## How to run the scenarios

Optional: Spin up the docker containers:

```
docker-compose up -d
```

If you don't want to spin up the containers, you'll need to locally run the required services (database, Kafka, etc.). You may need to add or remove the `managed` tag in the `${SERVICE}_tests.sh`.

If you want to run the real dependencies (content-service and service log), run `docker-compose --profile no-mock up -d` instead and `export WITHMOCK=0`.

Run the tests for your repository, for example:

```
make notification-service
```

## List of existing behavioral specifications (features)

### OCM UI

* [Login into console.redhat.com](features/OCM/login.feature)
* [List of clusters page on OCM UI](features/OCM/cluster_list.feature)
* [Insights tab on OCM UI](features/OCM/insights_tab.feature)
* [Cluster overview page on OCM UI](features/OCM/cluster_overview.feature)
* [Single rule page in OCM UI](features/OCM/single_rule_page.feature)
* [Rule feedback ability on OCM UI](features/OCM/rule_feedback.feature)
* [Disabling rule in OCM user interface](features/OCM/disable_rule.feature)
* [Disabling rule in OCM user interface should NOT be visible in ACM UI](features/OCM/disable_rule_on_ACM.feature)
* [Disabling rule in OCM user interface should be visible in OCP WebConsole as well](features/OCM/disable_rule_on_OCP.feature)


### OCP WebConsole

* [Login into OCP WebConsole](features/OCP_WebConsole/login.feature)
* [Insights displayed on OCP WebConsole](features/OCP_WebConsole/insights.feature)
* [Link from OCP WebConsole "Insights Advisor status" window to cluster page on OCM UI](features/OCP_WebConsole/to_cluster_page.feature)


### Advanced Cluster Management

* [Overview page behaviour on Advanced Cluster Management](features/ACM/overview_page.feature)
* [Overview page behaviour on Advanced Cluster Management in case some or all issues are disabled in Insights Advisor](features/ACM/overview_page_disabled_issues.feature)
* [List of clusters on ACM](features/ACM/cluster_list.feature)
* [Cluster issues section on Overview page on ACM UI](features/ACM/cluster_issues_section.feature)
* [Cluster issues section on Overview page on ACM UI in case some or all issues are disabled in Insights Advisor](features/ACM/cluster_issues_section_disabled_issues.feature)
* [Search for issues](features/ACM/search_issues.feature)
* [Search for issues in case some or all issues are disabled in Insights Advisor](features/ACM/search_disabled_issues.feature)
* [Cluster view with issues on ACM UI](features/ACM/cluster_view_with_issues.feature)
* [Cluster view with issues on ACM UI in case some or all issues are disabled in Insights Advisor](features/ACM/cluster_view_disabled_issues.feature)
* [Recommendation description view](features/ACM/recommentation_description.feature)
* [Recommendation description view in case some or all issues are disabled in Insights Advisor](features/ACM/recommentation_description_disabled_issues.feature)


### Insights Advisor

* [Advisor recommendations page behaviour on Hybrid Cloud Console](features/Insights_Advisor/recommendations_page.feature)
* [Expanding information about selected recommendation](features/Insights_Advisor/recommendations_page_expanded_info.feature)
* [Pagination feature in Advisor recommendations page on Hybrid Cloud Console](features/Insights_Advisor/recommendations_page_pagination.feature)
* [Filtering feature in Advisor recommendations page on Hybrid Cloud Console](features/Insights_Advisor/recommendations_page_filtering.feature)
* [Sorting feature in Advisor recommendations page on Hybrid Cloud Console](features/Insights_Advisor/recommendations_page_sorting.feature)
* [Cluster view page with recommendations behaviour on Hybrid Cloud Console](features/Insights_Advisor/affected_clusters_page.feature)
* [Sorting feature in Affected clusters page on Hybrid Cloud Console](features/Insights_Advisor/affected_clusters_sorting.feature)
* [Filtering feature in Affected clusters page on Hybrid Cloud Console](features/Insights_Advisor/affected_clusters_filtering.feature)
* [Cluster view page with recommendations behaviour on Hybrid Cloud Console](features/Insights_Advisor/cluster_page.feature)
* [Filtering feature in Cluster view page with recommendations behaviour on Hybrid Cloud Console](features/Insights_Advisor/cluster_page_filtering.feature)
* [Sorting feature in Cluster view page with recommendations behaviour on Hybrid Cloud Console](features/Insights_Advisor/cluster_page_sorting.feature)


### Customer Notifications

* [Customer Notifications](features/Notification_Service/customer_notifications.feature)

#### CCX Notification Writer

* [Basic set of smoke tests - checks if all required tools are available and all services are running](features/ccx-notification-writer/smoketests.feature)
* [Check command line options provided by CCX Notification Writer](features/ccx-notification-writer/cli_flags.feature)
* [Ability to clean up old records stored in database](features/ccx-notification-writer/cleanup_old_records.feature)
* [Ability to clean up old records stored in database with new records](features/ccx-notification-writer/cleanup_new_records.feature)
* [Ability to display old records stored in database](features/ccx-notification-writer/display_old_records.feature)

#### CCX Notification Service

* [Basic set of smoke tests - checks if all required tools are available and all services are running](features/ccx-notification-service/smoketests.feature)
* [Check command line options provided by CCX Notification Service](features/ccx-notification-service/cli_flags.feature)
* [Integration with Customer Notifications](features/ccx-notification-service/customer_notifications.feature)
* [Integration with Service Log](features/ccx-notification-service/service_log.feature)
* [Ability to clean up records stored in database](features/ccx-notification-service/cleanup_records.feature)
* [Ability to display old records stored in database](features/ccx-notification-service/display_records.feature)

### SHA Extractor

* [SHA Extractor](features/SHA_Extractor/sha_extractor.feature)


### Insights Results Aggregator Cleaner service

* [Basic set of smoke tests](features/insights-results-aggregator-cleaner/smoketests.feature)
* [Ability to display old records](features/insights-results-aggregator-cleaner/display_old_records.feature)
* [Ability to delete selected records](features/insights-results-aggregator-cleaner/cleanup_selected_records.feature)



### Insights Results Aggregator Exporter service

* [Basic set of smoke tests](features/insights-results-aggregator-exporter/smoketests.feature)
* [Ability to access database](features/insights-results-aggregator-exporter/database_access.feature)
* [Ability to export tables into file](features/insights-results-aggregator-exporter/file_export.feature)
* [Ability to export metadata into file](features/insights-results-aggregator-exporter/file_export_metadata.feature)
* [Ability to export tables into S3](features/insights-results-aggregator-exporter/s3_export.feature)
* [Ability to export metadata into S3](features/insights-results-aggregator-exporter/s3_export_metadata.feature)



### Insights Results Aggregator Mock service

* [Basic set of smoke tests](features/insights-results-aggregator-mock/smoketests.feature)



List of scenarios can be seen [there](features/README.md)
