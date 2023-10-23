@parquet_service

Feature: Ability to generate parquet files correctly

    Background: Initial state is ready
      Given the system is in default state
        And Kafka broker is available
        And Kafka topic "incoming_features_topic" is empty and has 2 partitions
        And Kafka topic "incoming_rules_topic" is empty and has 2 partitions
        And S3 endpoint is set
        And S3 port is set
        And S3 access key is set
        And S3 secret access key is set
        And S3 bucket name is set to test
        And S3 connection is established
        And The S3 bucket is empty

    Scenario: Table generation: cluster_info
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
       When I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/cluster_info/hourly/date=2016-02-02/hour=05/cluster_info-0.parquet                                   |
        And The parquet file fleet_aggregations/cluster_info/hourly/date=2016-02-02/hour=05/cluster_info-0.parquet is exactly this one
        | cluster_id                           | cluster_version | platform | collected_at        | desired_version | initial_version | network_type | network_mtu | network_kind | network_size | network_host_prefix | channel    | archive_path                                                                        |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | AWS      | 2016-02-02 05:05:22 | 4.8.13          | 4.8.12          | OpenShiftSDN | 1450        | service      | /16          | 0                   | stable-4.8 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | AWS      | 2016-02-02 05:05:22 | 4.8.13          | 4.8.12          | OpenShiftSDN | 1450        | cluster      | /14          | 23                  | stable-4.8 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | AWS      | 2016-02-02 05:05:22 | 4.8.13          | 4.8.12          | OpenShiftSDN | 1450        | service      | /16          | 0                   | stable-4.8 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | AWS      | 2016-02-02 05:05:22 | 4.8.13          | 4.8.12          | OpenShiftSDN | 1450        | cluster      | /14          | 23                  | stable-4.8 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |

    Scenario: Table generation: available_updates
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
       When I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/available_updates/hourly/date=2016-02-02/hour=05/available_updates-0.parquet |
        And The parquet file fleet_aggregations/available_updates/hourly/date=2016-02-02/hour=05/available_updates-0.parquet is exactly this one
        | cluster_id                           | cluster_version | release     | collected_at        | archive_path                                                                        |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |

    Scenario: Table generation: conditional_update_conditions
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
       When I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/conditional_update_conditions/hourly/date=2016-02-02/hour=05/conditional_update_conditions-0.parquet |
        And The parquet file fleet_aggregations/conditional_update_conditions/hourly/date=2016-02-02/hour=05/conditional_update_conditions-0.parquet is exactly this one
        | cluster_id                           | cluster_version | release     | recommended | reason     | message                                                                                        | collected_at        | archive_path                                                                        |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | True        | AsExpected | The update is recommended, because none of the conditional update risks apply to this cluster. | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | Unknown     | AsExpected | The update is recommended, because none of the conditional update risks apply to this cluster. | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | True        | AsExpected | The update is recommended, because none of the conditional update risks apply to this cluster. | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | Unknown     | AsExpected | The update is recommended, because none of the conditional update risks apply to this cluster. | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |

    Scenario: Table generation: conditional_update_risks
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
       When I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        And I should see following objects generated in S3
        | File name                              |
        | fleet_aggregations/conditional_update_risks/hourly/date=2016-02-02/hour=05/conditional_update_risks-0.parquet |
        And The parquet file fleet_aggregations/conditional_update_risks/hourly/date=2016-02-02/hour=05/conditional_update_risks-0.parquet is exactly this one
        | cluster_id                           | cluster_version | release     | risk                     | collected_at        | archive_path                                                                        |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | AlibabaStorageDriverDemo | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 11111111-1111-1111-1111-111111111111 | 4.8.12          | 4.10.0-fc.4 | AlibabaStorageDriverDemo | 2016-02-02 05:05:22 | archives/compressed/35/11111111-1111-1111-1111-111111111111/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | AlibabaStorageDriverDemo | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |
        | 22222222-2222-2222-2222-222222222222 | 4.8.12          | 4.10.0-fc.4 | AlibabaStorageDriverDemo | 2016-02-02 05:05:22 | archives/compressed/35/22222222-2222-2222-2222-222222222222/201602/02/050522.tar.gz |

    Scenario: Table generation: cluster_thanos_info
       When I fill the topics with messages of the previous hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 11111111-1111-1111-1111-111111111111 |
        | incoming_features_topic | 1         | features message | 22222222-2222-2222-2222-222222222222 |
        | incoming_rules_topic    | 0         | rules message    | 33333333-3333-3333-3333-333333333333 |
        | incoming_rules_topic    | 1         | rules message    | 44444444-4444-4444-4444-444444444444 |
        And I fill the topics with messages of the current hour
        | topic                   | partition | type             | cluster                              |
        | incoming_features_topic | 0         | features message | 55555555-5555-5555-5555-555555555555 |
        | incoming_features_topic | 1         | features message | 66666666-6666-6666-6666-666666666666 |
        | incoming_rules_topic    | 0         | rules message    | 77777777-7777-7777-7777-777777777777 |
        | incoming_rules_topic    | 1         | rules message    | 88888888-8888-8888-8888-888888888888 |
       When I run Parquet Factory with a timeout of "10" seconds
       Then Parquet Factory should have finish
        And The logs should contain
        | topic                   | partition | offset | message           |
        | incoming_features_topic | 0         | 0      | message processed |
        | incoming_features_topic | 1         | 0      | message processed |
        | incoming_rules_topic    | 0         | 0      | message processed |
        | incoming_rules_topic    | 1         | 0      | message processed |
        | incoming_features_topic | 0         | 1      | FINISH            |
        | incoming_features_topic | 1         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        | incoming_rules_topic    | 0         | 1      | FINISH            |
        And I should not see following objects generated in S3
        | File name                              |
        | fleet_aggregations/cluster_thanos_info/hourly/date=2016-02-02/hour=05/cluster_thanos_info-0.parquet |
