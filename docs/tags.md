---
layout: page
nav_order: 4
---

# List of tags used in scenarios

It is possible to filter test scenarios to be run not only by project name but
also by using tag or tags.

## Tags used across multiple tested services

* `@cli` - scenarios that test CLI flags handling
* `@database` - scenarios that perform database operations
* `@database-read` - database operations that just read data from storage
* `@database-write` - database operations that write data into storage (such tests might give different results when run multiple times)
* `@skip` - scenario that should be skipped
* `@file` - scenarios that handle files (create, read, write, delete)
* `@s3` - scenarios that handle objects stored in S3 (create, read, write, delete)
* `@rest-api` - scenarios that use REST API of tested service
* `@export` - scenarios that export data from S3/database/Kafka etc.
* `@local` - scenarios using locally deployed service
* `@managed` - scenarios using managed service
* `@metadata` - scenarios that work with metadata (list of table, list of topics etc.)
* `@json-check` - scenarios with test step that checks data (messages) for proper JSON format
* `@json-schema-check` - scenarios with test step that checks data (messages) against JSON schema
* `@message-producer` - scenarios that send messages to message broker (usually to Apache Kafka)

## Custom tags

* `@aggregator_cleaner` - scenario related to Insights Results Aggregator Cleaner service
* `@aggregator_exporter` - scenario related to Insights Results Aggregator Exporter service 
* `@notification_writer` - scenario related to CCX Notification Writer service
* `@notification_db_initialized` - scenario based on initialized CCX Notification service database
* `@sha-extractor` - scenario related to CCX SHA Extractor service

