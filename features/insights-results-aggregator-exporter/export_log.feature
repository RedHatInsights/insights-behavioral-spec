@aggregator_exporter
Feature: Ability to export log into file


  Background: System is in default state, database exist and is empty
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export empty tables into file with producing log file
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --output file --export-log
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
          | _logs.txt                              |
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
      And I should see following messages written into file _logs.txt
          """
          {"level":"info","message":"File logger initialized"}
          {"level":"info","message":"Retrieving connection to storage"}
          {"level":"info","message":"Exporting to file"}
          {"level":"info","message":"Reading list of tables"}
          {"level":"info","message":"Exporting tables"}
          {"level":"info","Table name":"advisor_ratings","message":"Exporting table"}
          {"level":"info","Table name":"report","message":"Exporting table"}
          {"level":"info","Table name":"cluster_rule_toggle","message":"Exporting table"}
          {"level":"info","Table name":"cluster_rule_user_feedback","message":"Exporting table"}
          {"level":"info","Table name":"cluster_user_rule_disable_feedback","message":"Exporting table"}
          {"level":"info","Table name":"rule_hit","message":"Exporting table"}
          {"level":"info","Table name":"consumer_error","message":"Exporting table"}
          {"level":"info","Table name":"migration_info","message":"Exporting table"}
          {"level":"info","Table name":"recommendation","message":"Exporting table"}
          {"level":"info","Table name":"report_info","message":"Exporting table"}
          {"level":"info","Table name":"rule_disable","message":"Exporting table"}
          {"level":"info","message":"Closing connection to storage"}
          """
     When I delete all tables from database
     Then I should find that the database is empty


  @database @file @export @database-read @database-write
  Scenario: Check export empty tables and metadata table into file with producing log file
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --output file --export-log --metadata
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
          | _logs.txt                              |
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
      And I should see following messages written into file _logs.txt
          """
          {"level":"info","message":"File logger initialized"}
          {"level":"info","message":"Retrieving connection to storage"}
          {"level":"info","message":"Exporting to file"}
          {"level":"info","message":"Reading list of tables"}
          {"level":"info","message":"Exporting metadata"}
          {"level":"info","message":"Exporting tables"}
          {"level":"info","Table name":"advisor_ratings","message":"Exporting table"}
          {"level":"info","Table name":"report","message":"Exporting table"}
          {"level":"info","Table name":"cluster_rule_toggle","message":"Exporting table"}
          {"level":"info","Table name":"cluster_rule_user_feedback","message":"Exporting table"}
          {"level":"info","Table name":"cluster_user_rule_disable_feedback","message":"Exporting table"}
          {"level":"info","Table name":"rule_hit","message":"Exporting table"}
          {"level":"info","Table name":"consumer_error","message":"Exporting table"}
          {"level":"info","Table name":"migration_info","message":"Exporting table"}
          {"level":"info","Table name":"recommendation","message":"Exporting table"}
          {"level":"info","Table name":"report_info","message":"Exporting table"}
          {"level":"info","Table name":"rule_disable","message":"Exporting table"}
          {"level":"info","message":"Closing connection to storage"}
          """
     When I delete all tables from database
     Then I should find that the database is empty
