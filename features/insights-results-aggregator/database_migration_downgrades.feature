Feature: Database migration downgrades tests


  Background: System is in default state and database exist
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres
      And aggregator database is in initial state



  @database
  Scenario: Check database downgrade from version #2 to version #1
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #2
      And I read current migration number from database
     Then I should see that migration #2 is returned
      And I should see 4 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
     When I migrate aggregator database to version #1
      And I read current migration number from database
     Then I should see that migration #1 is returned
      And I should see 2 tables in the database
      And I should see these tables in the database
          | Table name     |
          | migration_info |
          | report         |



  @database
  Scenario: Check database downgrade from version #3 to version #2
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #3
      And I read current migration number from database
     Then I should see that migration #3 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
     When I migrate aggregator database to version #2
      And I read current migration number from database
     Then I should see that migration #2 is returned
      And I should see 4 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |


  @database
  Scenario: Check database downgrade from version #4 to version #3
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #4
      And I read current migration number from database
     Then I should see that migration #4 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
     When I migrate aggregator database to version #3
      And I read current migration number from database
     Then I should see that migration #3 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |


  @database
  Scenario: Check database downgrade from version #5 to version #4
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #5
      And I read current migration number from database
     Then I should see that migration #5 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
     When I migrate aggregator database to version #4
      And I read current migration number from database
     Then I should see that migration #4 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |


  @database
  Scenario: Check database downgrade from version #6 to version #5
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #6
      And I read current migration number from database
     Then I should see that migration #6 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
     When I migrate aggregator database to version #5
      And I read current migration number from database
     Then I should see that migration #5 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |



  @database
  Scenario: Check database downgrade from version #7 to version #6
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #7
      And I read current migration number from database
     Then I should see that migration #7 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |
     When I migrate aggregator database to version #6
      And I read current migration number from database
     Then I should see that migration #6 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |



  @database
  Scenario: Check database downgrade from version #8 to version #7
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #8
      And I read current migration number from database
     Then I should see that migration #8 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |
     When I migrate aggregator database to version #7
      And I read current migration number from database
     Then I should see that migration #7 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |



  @database
  Scenario: Check database downgrade from version #9 to version #8
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #9
      And I read current migration number from database
     Then I should see that migration #9 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |
     When I migrate aggregator database to version #8
      And I read current migration number from database
     Then I should see that migration #8 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |



  @database
  Scenario: Check database downgrade from version #10 to version #9
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #10
      And I read current migration number from database
     Then I should see that migration #10 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |
     When I migrate aggregator database to version #9
      And I read current migration number from database
     Then I should see that migration #9 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |



  @database
  Scenario: Check database downgrade from version #11 to version #10
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #11
      And I read current migration number from database
     Then I should see that migration #11 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |
     When I migrate aggregator database to version #10
      And I read current migration number from database
     Then I should see that migration #10 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | rule                       |
          | rule_error_key             |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |



  @database
  Scenario: Check database downgrade from version #12 to version #11
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #12
      And I read current migration number from database
     Then I should see that migration #12 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
     When I migrate aggregator database to version #11
      And I read current migration number from database
     Then I should see that migration #11 is returned
      And I should see 5 tables in the database
      And I should see these tables in the database
          | Table name                 |
          | migration_info             |
          | report                     |
          | cluster_rule_user_feedback |
          | consumer_error             |
          | cluster_rule_toggle        |



  @database
  Scenario: Check database downgrade from version #13 to version #12
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #13
      And I read current migration number from database
     Then I should see that migration #13 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
     When I migrate aggregator database to version #12
      And I read current migration number from database
     Then I should see that migration #12 is returned
      And I should see 6 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |



  @database
  Scenario: Check database downgrade from version #14 to version #13
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #14
      And I read current migration number from database
     Then I should see that migration #14 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
     When I migrate aggregator database to version #13
      And I read current migration number from database
     Then I should see that migration #13 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |



  @database
  Scenario: Check database downgrade from version #15 to version #14
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #15
      And I read current migration number from database
     Then I should see that migration #15 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
     When I migrate aggregator database to version #14
      And I read current migration number from database
     Then I should see that migration #14 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |



  @database
  Scenario: Check database downgrade from version #16 to version #15
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #16
      And I read current migration number from database
     Then I should see that migration #16 is returned
      And I should see 8 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
     When I migrate aggregator database to version #15
      And I read current migration number from database
     Then I should see that migration #15 is returned
      And I should see 7 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |



  @database
  Scenario: Check database downgrade from version #17 to version #16
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #17
      And I read current migration number from database
     Then I should see that migration #17 is returned
      And I should see 9 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
     When I migrate aggregator database to version #16
      And I read current migration number from database
     Then I should see that migration #16 is returned
      And I should see 8 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |



  @database
  Scenario: Check database downgrade from version #18 to version #17
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #18
      And I read current migration number from database
     Then I should see that migration #18 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
     When I migrate aggregator database to version #17
      And I read current migration number from database
     Then I should see that migration #17 is returned
      And I should see 9 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |



  @database
  Scenario: Check database downgrade from version #19 to version #18
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #19
      And I read current migration number from database
     Then I should see that migration #19 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
     When I migrate aggregator database to version #18
      And I read current migration number from database
     Then I should see that migration #18 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |



  @database
  Scenario: Check database downgrade from version #20 to version #19
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #20
      And I read current migration number from database
     Then I should see that migration #20 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
     When I migrate aggregator database to version #19
      And I read current migration number from database
     Then I should see that migration #19 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |



  @database
  Scenario: Check database downgrade from version #21 to version #20
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #21
      And I read current migration number from database
     Then I should see that migration #21 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
     When I migrate aggregator database to version #20
      And I read current migration number from database
     Then I should see that migration #20 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |



  @database
  Scenario: Check database downgrade from version #22 to version #21
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #22
      And I read current migration number from database
     Then I should see that migration #22 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
     When I migrate aggregator database to version #21
      And I read current migration number from database
     Then I should see that migration #21 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |



  @database
  Scenario: Check database downgrade from version #23 to version #22
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #23
      And I read current migration number from database
     Then I should see that migration #23 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #22
      And I read current migration number from database
     Then I should see that migration #22 is returned
      And I should see 10 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |



  @database
  Scenario: Check database downgrade from version #24 to version #23
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #24
      And I read current migration number from database
     Then I should see that migration #24 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #23
      And I read current migration number from database
     Then I should see that migration #23 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #25 to version #24
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #25
      And I read current migration number from database
     Then I should see that migration #25 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #24
      And I read current migration number from database
     Then I should see that migration #24 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #26 to version #25
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #26
      And I read current migration number from database
     Then I should see that migration #26 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #25
      And I read current migration number from database
     Then I should see that migration #25 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #27 to version #26
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #27
      And I read current migration number from database
     Then I should see that migration #27 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #26
      And I read current migration number from database
     Then I should see that migration #26 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #28 to version #27
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #28
      And I read current migration number from database
     Then I should see that migration #28 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #27
      And I read current migration number from database
     Then I should see that migration #27 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #29 to version #28
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #29
      And I read current migration number from database
     Then I should see that migration #29 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #28
      And I read current migration number from database
     Then I should see that migration #28 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #30 to version #29
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #30
      And I read current migration number from database
     Then I should see that migration #30 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #29
      And I read current migration number from database
     Then I should see that migration #29 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |



  @database
  Scenario: Check database downgrade from version #31 to version #30
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I migrate aggregator database to version #31
      And I read current migration number from database
     Then I should see that migration #31 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |
     When I migrate aggregator database to version #30
      And I read current migration number from database
     Then I should see that migration #30 is returned
      And I should see 11 tables in the database
      And I should see these tables in the database
          | Table name                         |
          | migration_info                     |
          | report                             |
          | cluster_rule_user_feedback         |
          | consumer_error                     |
          | cluster_rule_toggle                |
          | cluster_user_rule_disable_feedback |
          | rule_hit                           |
          | recommendation                     |
          | rule_disable                       |
          | advisor_ratings                    |
          | report_info                        |

