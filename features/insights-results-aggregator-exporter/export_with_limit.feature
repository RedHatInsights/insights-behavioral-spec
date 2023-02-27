@aggregator_exporter
Feature: Ability to export tables into file with max limit of records set


  Background: System is in default state, database exist and is empty
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export empty tables into file with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from REPORT table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at  |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 1990-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 1990-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2100-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2100-01-01   |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 2       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from ADVISOR_RATINGS table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into ADVISOR_RATINGS table
          | org_id | user_id | rule_fqdn    | error_key | rule_id  |
          | 1      | 1       | ruleA.error1 | error1    | ruleA    |
          | 2      | 2       | ruleA.error2 | error2    | ruleA    |
          | 2      | 2       | ruleB.error1 | error1    | ruleB    |
          | 2      | 2       | ruleB.error2 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 2       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_RULE_TOGGLE table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_RULE_TOGGLE table
          | cluster_id                           | user_id | disabled | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | 1        | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | 1        | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | 1        | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | 1        | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 2       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_RULE_USER_FEEDBACK table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_RULE_USER_FEEDBACK table
          | cluster_id                           | user_id | user_vote | message   | added_at   | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | 1         | feedbackA | 1990-01-01 | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | 1         | feedbackB | 1990-01-01 | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | 1         | feedbackC | 2100-01-01 | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | 1         | feedbackD | 2100-01-01 | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 2       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_USER_RULE_DISABLE_FEEDBACK table
          | cluster_id                           | user_id | message   | added_at   | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | feedbackA | 1990-01-01 | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | feedbackB | 1990-01-01 | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | feedbackC | 2100-01-01 | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | feedbackD | 2100-01-01 | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 2       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from RULE_HIT table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RULE_HIT table
          | org_id | cluster_id                           | rule_fqdn    | error_key | template_data |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | ruleA.error1 | error1    | template1     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | ruleA.error2 | error2    | template2     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | ruleB.error1 | error1    | template3     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | ruleB.error2 | error2    | template4     |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 2       |
     When I delete all tables from database
     Then I should find that the database is empty



  @database @file @export @database-read @database-write
  Scenario: Check export from RECOMMENDATION table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RECOMMENDATION table
          | org_id | cluster_id                           | rule_fqdn    | error_key | rule_id |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | ruleA.error1 | error1    | ruleA   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | ruleA.error2 | error2    | ruleA   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | ruleB.error1 | error1    | ruleB   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | ruleB.error2 | error2    | ruleB   |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 2       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from MIGRATION_INFO table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into MIGRATION_INFO table
          | version |
          | 42      |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 1       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
      And I should see following records in exported file migration_info.csv placed in column 0
          | Record |
          | 42     |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from ADVISOR_RATINGS table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into ADVISOR_RATINGS table
          | org_id | user_id | rule_fqdn    | error_key | rule_id  |
          | 1      | 1       | ruleA.error1 | error1    | ruleA    |
          | 2      | 2       | ruleA.error2 | error2    | ruleA    |
          | 2      | 2       | ruleB.error1 | error1    | ruleB    |
          | 2      | 2       | ruleB.error2 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 2       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_RULE_TOGGLE table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_RULE_TOGGLE table
          | cluster_id                           | user_id | disabled | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | 1        | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | 1        | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | 1        | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | 1        | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 2       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_RULE_USER_FEEDBACK table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_RULE_USER_FEEDBACK table
          | cluster_id                           | user_id | user_vote | message   | added_at   | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | 1         | feedbackA | 1990-01-01 | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | 1         | feedbackB | 1990-01-01 | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | 1         | feedbackC | 2100-01-01 | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | 1         | feedbackD | 2100-01-01 | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 2       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CLUSTER_USER_RULE_DISABLE_FEEDBACK table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CLUSTER_USER_RULE_DISABLE_FEEDBACK table
          | cluster_id                           | user_id | message   | added_at   | updated_at | error_key | rule_id  |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1       | feedbackA | 1990-01-01 | 1990-01-01 | error1    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 2       | feedbackB | 1990-01-01 | 1990-01-01 | error2    | ruleA    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 2       | feedbackC | 2100-01-01 | 2100-01-01 | error1    | ruleB    |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 2       | feedbackD | 2100-01-01 | 2100-01-01 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 2       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from RULE_HIT table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RULE_HIT table
          | org_id | cluster_id                           | rule_fqdn    | error_key | template_data |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | ruleA.error1 | error1    | template1     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | ruleA.error2 | error2    | template2     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | ruleB.error1 | error1    | template3     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | ruleB.error2 | error2    | template4     |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 2       |
     When I delete all tables from database
     Then I should find that the database is empty



  @database @file @export @database-read @database-write
  Scenario: Check export from RECOMMENDATION table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RECOMMENDATION table
          | org_id | cluster_id                           | rule_fqdn    | error_key | rule_id |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | ruleA.error1 | error1    | ruleA   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | ruleA.error2 | error2    | ruleA   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | ruleB.error1 | error1    | ruleB   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | ruleB.error2 | error2    | ruleB   |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 2       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from CONSUMER_ERROR table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into CONSUMER_ERROR table
          | topic | partition | topic_offset | key | produced_at | consumed_at | message  | error  |
          | testT | 1         | 0            | k1  | 2022-01-01  | 2022-01-01  | messageX | errorX |
          | testT | 1         | 1            | k2  | 2022-01-01  | 2022-01-01  | messageY | errorY |
          | testT | 2         | 0            | k3  | 2022-01-01  | 2022-01-01  | messageZ | errorZ |
          | testT | 2         | 1000         | k4  | 2022-01-01  | 2022-01-01  | messageW | errorW |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 2       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from REPORT_INFO table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT_INFO table
          | org_id | cluster_id                           | version_info |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1.0          |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab | 42.5beta     |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac | 1.2.3        |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad | 1.2.3.4      |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 2       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export from RULE_DISABLE table with record limit explicitly set
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into RULE_DISABLE table
          | org_id | user_id | rule_id | error_key | justification  |
          | 1      | 10      | ruleA   | error1    | justificationX |
          | 2      | 20      | ruleA   | error2    | justificationY |
          | 2      | 30      | ruleB   | error1    | justificationZ |
          | 2      | 40      | ruleC   | error2    | justificationW |
      And I run the exporter with the following command line flags: --output file --limit 2
     Then The process should finish with exit code 0
      And I should see following files generated
          | File name                              |
          | advisor_ratings.csv                    |
          | cluster_rule_toggle.csv                |
          | cluster_rule_user_feedback.csv         |
          | cluster_user_rule_disable_feedback.csv |
          | consumer_error.csv                     |
          | migration_info.csv                     |
          | recommendation.csv                     |
          | report.csv                             |
          | report_info.csv                        |
          | rule_disable.csv                       |
          | rule_hit.csv                           |
      And I should see following number of records stored in CSV files
          | File name                              | Records |
          | advisor_ratings.csv                    | 0       |
          | cluster_rule_toggle.csv                | 0       |
          | cluster_rule_user_feedback.csv         | 0       |
          | cluster_user_rule_disable_feedback.csv | 0       |
          | consumer_error.csv                     | 0       |
          | migration_info.csv                     | 0       |
          | recommendation.csv                     | 0       |
          | report.csv                             | 0       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 2       |
          | rule_hit.csv                           | 0       |
     When I delete all tables from database
     Then I should find that the database is empty
