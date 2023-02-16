@aggregator_cleaner
Feature: Basic set of smoke tests


  Scenario: Check if cleaner application is available
    Given the system is in default state
     When I look for executable file insights-results-aggregator-cleaner
     Then I should find that file on PATH


  Scenario: Check if cleaner displays help message
    Given the system is in default state
     When I run the cleaner with the --help command line flag
     Then I should see help messages displayed by cleaner on standard output


  Scenario: Check if cleaner displays version info
    Given the system is in default state
     When I run the cleaner with the --version command line flag
     Then I should see version info displayed by cleaner on standard output


  Scenario: Check if cleaner displays authors
    Given the system is in default state
     When I run the cleaner with the --authors command line flag
     Then I should see info about authors displayed by cleaner on standard output


  @database
  Scenario: Check if Postgres database is available
    Given the system is in default state
     When I connect to database named test as user postgres with password postgres
     Then I should be able to connect to such database
     When I close database connection
     Then I should be disconnected


# I think we don't need this test
#  @database0
#  Scenario Outline: Check if the test database does not contain tables to be created by tests
#    Given the system is in default state
#     When I connect to database named test as user postgres with password postgres
#     Then I should be able to connect to such database
#     When I look for the table <table> in database
#     Then I should not be able to find it
#
#        Examples: tables in database
#            | table                              |
#            | report                             |
#            | cluster     _rule_toggle                |
#            | cluster     _rule_user_feedback         |
#            | cluster     _user_rule_disable_feedback |
#            | rule_hit                           |