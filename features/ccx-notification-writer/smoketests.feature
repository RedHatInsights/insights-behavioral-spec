@notification_writer
Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Scenario: Check if CCX Notification Writer application is available
    Given the system is in default state
     When I look for executable file ccx-notification-writer
     Then I should find that file on PATH


  Scenario: Check if kcat utility is available
    Given the system is in default state
     When I look for executable file kcat
     Then I should find that file on PATH


  Scenario: Check if jps utility is available
    Given the system is in default state
     When I look for executable file jps
     Then I should find that file on PATH


  Scenario: Check if Postgres database is available
    Given the system is in default state
     When I connect to database named test as user postgres with password postgres
     Then I should be able to connect to such database
     When I close database connection
     Then I should be disconnected


  Scenario: Check if CCX Notification Writer database can be reached
     Given the system is in default state
     When I connect to database named notification as user postgres with password postgres
     Then I should be able to connect to such database
     When I close database connection
     Then I should be disconnected


  @managed @local
  Scenario: Check if ZooKeeper is running locally
    Given the system is in default state
     When I retrieve a list of all applications running under JVM
     Then I should find the following application org.apache.zookeeper.server.quorum.QuorumPeerMain


  @managed @local
  Scenario: Check if Kafka broker is running locally
    Given the system is in default state
     When I retrieve a list of all applications running under JVM
     Then I should find the following application kafka.Kafka


  @managed @local
  Scenario: Check if Kafka broker is running on expected port
    Given the system is in default state
     When I retrieve metadata from Kafka broker
     Then I should find at least one available broker
