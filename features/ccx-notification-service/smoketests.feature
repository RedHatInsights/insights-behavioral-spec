@notification_service
Feature: Basic set of smoke tests - checks if all required tools are available and all services are running.


  Background:
    Given the system is in default state


  Scenario: Check if CCX Notification Service application is available
     When I look for executable file ccx-notification-service
     Then I should find that file on PATH


  Scenario: Check if kcat utility is available
     When I look for executable file kcat
     Then I should find that file on PATH

  @managed @local
  Scenario: Check if jps utility is available
     When I look for executable file jps
     Then I should find that file on PATH


  Scenario: Check if CCX Notification database can be reached
    Given the database is named notification
      And database user is set to postgres
      And database password is set to postgres
      And database connection is established
     When I close database connection
     Then I should be disconnected

  @managed @local
  Scenario: Check if ZooKeeper is running locally
     When I retrieve a list of all applications running under JVM
     Then I should find the following application org.apache.zookeeper.server.quorum.QuorumPeerMain

  @managed @local
  Scenario: Check if Kafka broker is running locally
     When I retrieve a list of all applications running under JVM
     Then I should find the following application kafka.Kafka


  Scenario: Check if Kafka broker is running on expected port
     When I retrieve metadata from Kafka broker
     Then I should find at least one available broker


  Scenario: Check if content-service dependency is available on expected port
     When I retrieve data from insights-content-service on localhost:8082
     Then I should get data from insights-content-service


  Scenario: Check if prometheus push gateway dependency is available on expected port
     When I retrieve metrics from the gateway on localhost:9091
     Then I should get data from the gateway
