---
layout: page
nav_order: 7
---

## Makefile targets

```
Usage: make <OPTIONS> ... <TARGETS>

Available targets are:

cleaner-tests                       Run BDD tests for the CCX Cleaner service
aggregator-tests                    Run BDD tests for Insights Results Aggregator service
aggregator-code-coverage            Compute code coverage for Insights Results Aggregator service
aggregator-mock-tests               Run BDD tests for Insights Results Aggregator Mock service
aggregator-mock-code-coverage       Compute code coverage for Insights Results Aggregator Mock service
exporter-tests                      Run BDD tests for the CCX Exporter service
notification-service-tests          Run BDD tests for the CCX Notification Service
notification-service-code-coverage  Compute code coverage for the CCX Notification Service
notification-writer-tests           Run BDD tests for the CCX Notification Writer
notification-writer-code-coverage   Compute code coverage for the CCX Notification Writer
inference-service-tests             Run BDD tests for the Inference Service
data-engineering-service-tests      Run BDD tests for the Data Engineering Service
insights-content-service-tests      Run BDD tests for the CCX Content Service
insights-sha-extractor-tests        Run BDD tests for the CCX SHA Extractor
style                               Perform all style checks
code-style                          Check code style for all Python sources from this repository
docs-style                          Check documentation strings in all Python sources from this repository
shellcheck                          Run shellcheck
update-scenarios                    Update list of scenarios for GitHub pages
docker-build                        Build Docker images that can be used for tests
help                                Show this help screen
```

