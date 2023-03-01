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
