Feature: Ability to export tables into file

  Background: System is in default state, database exist and is empty
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty

  Scenario: Check export empty tables into file
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --output file
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

  Scenario: Check export from REPORT table
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into REPORT table
          | org_id | cluster                              | report | reported_at  |
          | 1      | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |        | 1990-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |        | 1990-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |        | 2100-01-01   |
          | 2      | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |        | 2100-01-01   |
      And I run the exporter with the following command line flags: --output file
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
          | report.csv                             | 4       |
          | report_info.csv                        | 0       |
          | rule_disable.csv                       | 0       |
          | rule_hit.csv                           | 0       |
      And I should see following records in exported file report.csv placed in column 1
          | Record                               |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767aa |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ab |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ac |
          | 5d5892d4-1f74-4ccf-91af-548dfc9767ad |
     When I delete all tables from database
     Then I should find that the database is empty

  Scenario: Check export from ADVISOR_RATINGS table
     When I prepare database schema
     Then I should find that all tables are empty
     When I insert following records into ADVISOR_RATINGS table
          | org_id | user_id | rule_fqdn    | error_key | rule_id  |
          | 1      | 1       | ruleA.error1 | error1    | ruleA    |
          | 2      | 2       | ruleA.error2 | error2    | ruleA    |
          | 2      | 2       | ruleB.error1 | error1    | ruleB    |
          | 2      | 2       | ruleB.error2 | error2    | ruleB    |
      And I run the exporter with the following command line flags: --output file
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
          | advisor_ratings.csv                    | 4       |
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
      And I should see following records in exported file advisor_ratings.csv placed in column 2
          | Record       |
          | ruleA.error1 |
          | ruleA.error2 |
          | ruleB.error1 |
          | ruleB.error2 |
      And I should see following records in exported file advisor_ratings.csv placed in column 3
          | Record |
          | error1 |
          | error2 |
          | error1 |
          | error2 |
      And I should see following records in exported file advisor_ratings.csv placed in column 7
          | Record |
          | ruleA  |
          | ruleA  |
          | ruleB  |
          | ruleB  |
     When I delete all tables from database
     Then I should find that the database is empty
