Feature: Database migration tests


  Background: System is in default state and database exist
    Given the system is in default state
      And the database is named test
      And database user is set to postgres
      And database password is set to postgres


  @database
  Scenario: Check that default migration is set to 0
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I read current migration number from database
     Then I should see that migration #0 is returned
      And I should see 1 table in the database
      And I should see these tables in the database
          | Table name     |
          | migration_info |


  @database
  Scenario: Check database migration from version #0 to version #1
     When database connection is established
      And I look for the table migration_info in database
     Then I should be able to find it
     When I read current migration number from database
     Then I should see that migration #0 is returned
      And I should see 1 table in the database
      And I should see these tables in the database
          | Table name     |
          | migration_info |
     When I migrate aggregator database to version #1
      And I read current migration number from database
     Then I should see that migration #1 is returned
      And I should see 2 tables in the database
      And I should see these tables in the database
          | Table name     |
          | migration_info |
          | report         |
