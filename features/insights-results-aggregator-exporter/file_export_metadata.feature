Feature: Ability to export metadata into file

  Background: System is in default state, database exist and is empty
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty


  @database
  Scenario: Check export metadata table into file
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --metadata --output file
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
          | _metadata.csv                          |
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
          | _metadata.csv                          | 11      |
      And I should see following records in exported file _metadata.csv placed in column 0
          | Record                             |
          | advisor_ratings                    |
          | report                             |
          | cluster_rule_toggle                |
          | cluster_rule_user_feedback         |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | consumer_error                     |
          | migration_info                     |
          | recommendation                     |
          | report_info                        |
          | rule_disable                       |
     When I delete all tables from database
     Then I should find that the database is empty
