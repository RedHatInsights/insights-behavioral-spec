---
layout: page
nav_order: 7
---

## Makefile targets

```
Usage: make <OPTIONS> ... <TARGETS>

Available targets are:

unit_tests                          Run all unit tests defined in this project
coverage                            Calculate unit test code coverage for the whole repository
coverage-report                     Generate HTML pages with unit test code coverage report
cleaner-tests                       Run BDD tests for the CCX Cleaner service
cleaner-code-coverage               Compute code coverage for Insights Results Cleaner service
aggregator-tests                    Run BDD tests for Insights Results Aggregator service
aggregator-code-coverage            Compute code coverage for Insights Results Aggregator service
aggregator-mock-tests               Run BDD tests for Insights Results Aggregator Mock service
aggregator-mock-code-coverage       Compute code coverage for Insights Results Aggregator Mock service
exporter-tests                      Run BDD tests for the CCX Exporter service
exporter-code-coverage              Compute code coverage for Insights Results Exporter service
notification-service-tests          Run BDD tests for the CCX Notification Service
notification-service-code-coverage  Compute code coverage for the CCX Notification Service
notification-writer-tests           Run BDD tests for the CCX Notification Writer
notification-writer-code-coverage   Compute code coverage for the CCX Notification Writer
inference-service-tests             Run BDD tests for the Inference Service
data-engineering-service-tests      Run BDD tests for the Data Engineering Service
insights-content-service-tests      Run BDD tests for the CCX Content Service
insights-content-template-renderer-tests Run BDD tests for the CCX Template Renderer
insights-sha-extractor-tests        Run BDD tests for the CCX SHA Extractor
smart-proxy-tests                   Run BDD tests for the Insights Results Smart Proxy service
smart-proxy-code-coverage           Compute code coverage for Smart Proxy service
parquet-factory-tests               Run BDD tests for the Parquet Factory
parquet-factory-code-coverage       Compute code coverage for Parquet Factory
style                               Perform all style checks
code-style                          Check code style for all Python sources from this repository
ruff                                Run Ruff linter
docs-style                          Check documentation strings in all Python sources from this repository
shellcheck                          Run shellcheck
update-scenarios                    Update list of scenarios for GitHub pages
docker-build                        Build Docker images that can be used for tests
install-type-libraries              Install libraries with type definitions
type-checks                         Perform type checks for all sources
strict-type-checks                  Strict type checks for all sources
missing-types                       Find all missing types in Python sources
help                                Show this help screen
```
