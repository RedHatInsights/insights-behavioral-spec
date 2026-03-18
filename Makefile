.PHONY: default tests style code-style docs-style shellcheck update-scenarios before_commit \
	unit_tests coverage coverage-report ruff doc-check help \
	cleaner cleaner-tests cleaner-code-coverage \
	aggregator aggregator-tests aggregator-code-coverage \
	aggregator-mock aggregator-mock-tests aggregator-mock-code-coverage \
	exporter exporter-tests exporter-code-coverage \
	notification-service notification-service-tests notification-service-code-coverage \
	notification-writer notification-writer-tests notification-writer-code-coverage \
	inference-service inference-service-tests data-engineering-service data-engineering-service-tests \
	dvo-extractor dvo-extractor-tests dvo-writer dvo-writer-tests \
	content-service insights-content-service-tests \
	content-template-renderer insights-content-template-renderer-tests \
	sha-extractor insights-sha-extractor-tests \
	smart-proxy smart-proxy-tests smart-proxy-code-coverage \
	parquet-factory parquet-factory-tests parquet-factory-code-coverage \
	docker-build install-type-libraries type-checks strict-type-checks missing-types

default: tests

tests:	cleaner-tests exporter-tests aggregator-tests aggregator-mock-tests \
	notification-service-tests notification-writer-tests insights-content-service-tests \
	inference-service-tests data-engineering-service-tests

unit_tests: ## Run all unit tests defined in this project
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider

coverage: ## Calculate unit test code coverage for the whole repository
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider --cov features/

coverage-report: ## Generate HTML pages with unit test code coverage report
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider --cov features/ --cov-report=html

cleaner cleaner-tests: ## Run BDD tests for the CCX Cleaner service
	PATH_TO_LOCAL_CLEANER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_CLEANER} ./cleaner_tests.sh

cleaner-code-coverage: ## Compute code coverage for Insights Results Cleaner service
	PATH_TO_LOCAL_CLEANER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_CLEANER} ./cleaner_tests.sh coverage

aggregator aggregator-tests: ## Run BDD tests for Insights Results Aggregator service
	PATH_TO_LOCAL_AGGREGATOR=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_AGGREGATOR} ./insights_results_aggregator_tests.sh

aggregator-code-coverage: ## Compute code coverage for Insights Results Aggregator service
	PATH_TO_LOCAL_AGGREGATOR=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_AGGREGATOR} ./insights_results_aggregator_tests.sh coverage

aggregator-mock aggregator-mock-tests: ## Run BDD tests for Insights Results Aggregator Mock service
	./insights_results_aggregator_mock_tests.sh

aggregator-mock-code-coverage: ## Compute code coverage for Insights Results Aggregator Mock service
	./insights_results_aggregator_mock_tests.sh coverage

exporter exporter-tests: ## Run BDD tests for the CCX Exporter service
	PATH_TO_LOCAL_EXPORTER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_EXPORTER} ./exporter_tests.sh

exporter-code-coverage: ## Compute code coverage for Insights Results Exporter service
	PATH_TO_LOCAL_EXPORTER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_EXPORTER} /exporter_tests.sh coverage

notification-service notification-service-tests: ## Run BDD tests for the CCX Notification Service
	PATH_TO_LOCAL_NOTIFICATION_SERVICE=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_NOTIFICATION_SERVICE} ./notification_service_tests.sh

notification-service-code-coverage: ## Compute code coverage for the CCX Notification Service
	PATH_TO_LOCAL_NOTIFICATION_SERVICE=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_NOTIFICATION_SERVICE} ./notification_service_tests.sh coverage

notification-writer notification-writer-tests: ## Run BDD tests for the CCX Notification Writer
	PATH_TO_LOCAL_NOTIFICATION_WRITER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_NOTIFICATION_WRITER} ./notification_writer_tests.sh

notification-writer-code-coverage: ## Compute code coverage for the CCX Notification Writer
	PATH_TO_LOCAL_NOTIFICATION_WRITER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_NOTIFICATION_WRITER} ./notification_writer_tests.sh coverage

inference-service inference-service-tests: ## Run BDD tests for the Inference Service
	PATH_TO_LOCAL_INFERENCE_SERVICE=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_INFERENCE_SERVICE} ./ccx_upgrade_risk_inference_tests.sh

data-engineering-service data-engineering-service-tests: ## Run BDD tests for the Data Engineering Service
	PATH_TO_LOCAL_DATA_ENG_SERVICE=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_DATA_ENG_SERVICE} ./ccx_upgrade_risk_data_eng_tests.sh

dvo-extractor dvo-extractor-tests: ## Run BDD tests for the DVO Extractor
	./dvo_extractor_tests.sh

dvo-writer dvo-writer-tests: ## Run BDD tests for the DVO Writer
	PATH_TO_LOCAL_DVO_WRITER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_DVO_WRITER} ./dvo_writer_tests.sh

content-service insights-content-service-tests: ## Run BDD tests for the CCX Content Service
	PATH_TO_LOCAL_CONTENT_SERVICE=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_CONTENT_SERVICE} ./insights_content_service_test.sh

content-template-renderer insights-content-template-renderer-tests: ## Run BDD tests for the CCX Template Renderer
	PATH_TO_LOCAL_TEMPLATE_RENDERER=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_TEMPLATE_RENDERER} ./insights_content_template_renderer_tests.sh

sha-extractor insights-sha-extractor-tests: ## Run BDD tests for the CCX SHA Extractor
	./insights_sha_extractor_test.sh

smart-proxy smart-proxy-tests: ## Run BDD tests for the Insights Results Smart Proxy service
	PATH_TO_LOCAL_SMART_PROXY=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_SMART_PROXY} ./smart_proxy_tests.sh

smart-proxy-code-coverage: ## Compute code coverage for Smart Proxy service
	PATH_TO_LOCAL_SMART_PROXY=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_SMART_PROXY} ./smart_proxy_tests.sh coverage

parquet-factory parquet-factory-tests: ## Run BDD tests for the Parquet Factory
	PATH_TO_LOCAL_PARQUET_FACTORY=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_PARQUET_FACTORY} ./parquet_factory_tests.sh

parquet-factory-code-coverage: ## Compute code coverage for Parquet Factory
	PATH_TO_LOCAL_PARQUET_FACTORY=$${SERVICE_UNDER_TEST:-$$PATH_TO_LOCAL_PARQUET_FACTORY} ./parquet_factory_tests.sh coverage

style: code-style docs-style shellcheck ## Perform all style checks

code-style: ruff ## Check code style for all Python sources from this repository

ruff: ## Run Ruff linter
	pre-commit run --all-files ruff-check
	pre-commit run --all-files ruff-format

docs-style: ruff ## Check documentation strings in all Python sources from this repository

doc-check: ## Run gen_scenario_list.py to generate docs file and compare it to current one
	python3 tools/gen_scenario_list.py > tmp.md
	diff tmp.md docs/scenarios_list.md

shellcheck: ## Run shellcheck
	pre-commit run --all-files shellcheck

update-scenarios: ## Update list of scenarios for GitHub pages
	python3 tools/gen_scenario_list.py > docs/scenarios_list.md

before_commit:
	pre-commit run --all-files

docker-build: ## Build Docker images that can be used for tests
	docker build -t insights-behavioral-spec:ci .

install-type-libraries: ## Install libraries with type definitions
	pip3 install requirements/mypy.txt

type-checks: ## Perform type checks for all sources
	MYPYPATH=features/: mypy --explicit-package-bases features

strict-type-checks: ## Strict type checks for all sources
	MYPYPATH=features/: mypy --strict --explicit-package-bases features

missing-types: ## Find all missing types in Python sources
	MYPYPATH=features/: mypy --explicit-package-bases --disallow-untyped-calls --disallow-untyped-defs --disallow-incomplete-defs features

help: ## Show this help screen
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}'
	@echo ''
