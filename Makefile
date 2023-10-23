.PHONY: default tests style code-style update-scenarios before_commit cleaner-tests exporter-tests aggregator-tests aggregator-mock-tests notification-service-tests notification-writer-tests insights-content-service-tests inference-service-tests data-engineering-service-tests

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

cleaner-tests: ## Run BDD tests for the CCX Cleaner service
	./cleaner_tests.sh

cleaner-code-coverage: ## Compute code coverage for Insights Results Cleaner service
	./insights_results_cleaner_tests.sh coverage

aggregator-tests: ## Run BDD tests for Insights Results Aggregator service
	./insights_results_aggregator_tests.sh

aggregator-code-coverage: ## Compute code coverage for Insights Results Aggregator service
	./insights_results_aggregator_tests.sh coverage

aggregator-mock-tests: ## Run BDD tests for Insights Results Aggregator Mock service
	./insights_results_aggregator_mock_tests.sh

aggregator-mock-code-coverage: ## Compute code coverage for Insights Results Aggregator Mock service
	./insights_results_aggregator_mock_tests.sh coverage

exporter-tests: ## Run BDD tests for the CCX Exporter service
	./exporter_tests.sh

exporter-code-coverage: ## Compute code coverage for Insights Results Exporter service
	./insights_results_exporter_tests.sh coverage

notification-service-tests: ## Run BDD tests for the CCX Notification Service
	./notification_service_tests.sh

notification-service-code-coverage: ## Compute code coverage for the CCX Notification Service
	./notification_service_tests.sh coverage

notification-writer-tests: ## Run BDD tests for the CCX Notification Writer
	./notification_writer_tests.sh

notification-writer-code-coverage: ## Compute code coverage for the CCX Notification Writer
	./notification_writer_tests.sh coverage

inference-service-tests: ## Run BDD tests for the Inference Service
	./ccx_upgrade_risk_inference_tests.sh

data-engineering-service-tests: ## Run BDD tests for the Data Engineering Service
	./ccx_upgrade_risk_data_eng_tests.sh

insights-content-service-tests: ## Run BDD tests for the CCX Content Service
	./insights_content_service_test.sh

insights-content-template-renderer-tests: ## Run BDD tests for the CCX Template Renderer
	./insights_content_template_renderer_tests.sh

insights-sha-extractor-tests: ## Run BDD tests for the CCX SHA Extractor
	./insights_sha_extractor_test.sh

smart-proxy-tests: ## Run BDD tests for the Insights Results Smart Proxy service
	./smart_proxy_tests.sh

smart-proxy-code-coverage: ## Compute code coverage for Smart Proxy service
	./smart_proxy_tests.sh coverage

style:	code-style docs-style ## Perform all style checks

code-style: ## Check code style for all Python sources from this repository
	python3 tools/run_pycodestyle.py

ruff: ## Run Ruff linter
	ruff .

docs-style: ## Check documentation strings in all Python sources from this repository
	pydocstyle .

doc-check: ## Run gen_scenario_list.py to generate docs file and compare it to current one
	python3 tools/gen_scenario_list.py > tmp.md
	diff tmp.md docs/scenarios_list.md

shellcheck: ## Run shellcheck
	./shellcheck.sh

update-scenarios: ## Update list of scenarios for GitHub pages
	python3 tools/gen_scenario_list.py > docs/scenarios_list.md

before_commit: code-style update-scenarios ruff

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
