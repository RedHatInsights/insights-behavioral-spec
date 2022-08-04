Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Scenario: Check if CCX Notification Writer application is available
    Given the system is in default state
     When I look for executable file ccx-notification-writer
     Then I should find that file on PATH


  Scenario: Check if Kafkacat utility is available
    Given the system is in default state
     When I look for executable file kafkacat
     Then I should find that file on PATH


  Scenario: Check if jps utility is available
    Given the system is in default state
     When I look for executable file jps
     Then I should find that file on PATH


  Scenario: Check if Postgres database is available
    Given Postgres is running
     When I connect to database named postgres as user postgres with password postgres
     Then I should be able to connect to such database
     When I close database connection
     Then I should be disconnected


  Scenario: Check if CCX Notification Writer database can be reached
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
     When I close database connection
     Then I should be disconnected


  Scenario: Check if ZooKeeper is running locally
    Given the system is in default state
     When I retrieve a list of all applications running under JVM
     Then I should find the following application org.apache.zookeeper.server.quorum.QuorumPeerMain


  Scenario: Check if Kafka broker is running locally
    Given the system is in default state
     When I retrieve a list of all applications running under JVM
     Then I should find the following application kafka.Kafka


  Scenario: Check if Kafka broker is running on expected port
    Given the system is in default state
     When I retrieve metadata from Kafka broker running on localhost:9092
     Then I should find at least one available broker
