@aggregator_exporter
Feature: Ability to export tables into S3


  Background: System is in default state, database exist and is empty, S3 is accessible
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
      And the database is empty
      And S3 endpoint is set
      And S3 port is set
      And S3 access key is set
      And S3 secret access key is set
      And S3 bucket name is set to test
      And S3 connection is established
      And S3 test bucket exists


  @database @s3 @export
  Scenario: Check export empty tables into S3/Minio
     When I prepare database schema
     Then I should find that all tables are empty
     When I run the exporter with the following command line flags: --output S3
     Then The process should finish with exit code 0
      And I should see following objects generated in S3
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
      And I should see following number of records stored in CSV objects in S3
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