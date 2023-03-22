.PHONY: default tests code-style update-scenarios before_commit cleaner-tests exporter-tests aggregator-tests aggregator-mock-tests notification-service-tests notification-writer-tests insights-content-service-tests inference-service-tests data-engineering-service-tests

default: tests

tests:	cleaner-tests exporter-tests aggregator-tests aggregator-mock-tests \
	notification-service-tests notification-writer-tests insights-content-service-tests \
	inference-service-tests data-engineering-service-tests

cleaner-tests: ## Run BDD tests for the CCX Cleaner service
	./cleaner_tests.sh

aggregator-tests: ## Run BDD tests for Insights Results Aggregator service
	./insights_results_aggregator_tests.sh

aggregator-code-coverage: ## Compute code coverage for Insights Results Aggregator service
	./insights_results_aggregator_tests.sh coverage

aggregator-mock-tests: ## Run BDD tests for Insights Results Aggregator Mock service
	./insights_results_aggregator_mock_tests.sh

exporter-tests: ## Run BDD tests for the CCX Exporter service
	./exporter_tests.sh

notification-service-tests: ## Run BDD tests for the CCX Notification Service
	./notification_service_tests.sh

notification-writer-tests: ## Run BDD tests for the CCX Notification Writer
	./notification_writer_tests.sh

inference-service-tests: ## Run BDD tests for the Inference Service
	./ccx_upgrade_risk_inference_tests.sh

data-engineering-service-tests: ## Run BDD tests for the Data Engineering Service
	./ccx_upgrade_risk_data_eng_tests.sh

insights-content-service-tests: ## Run BDD tests for the CCX Content Service
	./insights_content_service_test.sh

insights-sha-extractor-tests: ## Run BDD tests for the CCX SHA Extractor
	./insights_sha_extractor_test.sh

code-style: ## Check code style for all Python sources from this repository
	python3 tools/run_pycodestyle.py

shellcheck: ## Run shellcheck
	./shellcheck.sh

update-scenarios: ## Update list of scenarios for GitHub pages
	python3 tools/gen_scenario_list.py > docs/scenarios_list.md

before_commit: code-style update-scenarios

docker-build: ## Build Docker images that can be used for tests
	docker build -t insights-behavioral-spec:ci .

help: ## Show this help screen
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ''
