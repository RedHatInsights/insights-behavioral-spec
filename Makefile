.PHONY: default tests code-style update-scenarios before_commit cleaner-tests exporter-tests notification-service notification-writer inference-service

default: tests

tests:	cleaner-tests exporter-tests aggregator-tests aggregator-mock-tests \
	notification-service-tests notification-writer-tests insights-content-service-tests \
	inference-service-tests data-engineering-service-tests

cleaner-tests:
	./cleaner_tests.sh

aggregator-tests:
	./insights_results_aggregator_tests.sh

aggregator-code-coverage:
	./insights_results_aggregator_tests.sh coverage

aggregator-mock-tests:
	./insights_results_aggregator_mock_tests.sh

exporter-tests:
	./exporter_tests.sh

notification-service-tests:
	./notification_service_tests.sh

notification-writer-tests:
	./notification_writer_tests.sh

inference-service-tests:
	./ccx_upgrade_risk_inference_tests.sh

data-engineering-service-tests:
	./ccx_upgrade_risk_data_eng_tests.sh

insights-content-service-tests:
	./insights_content_service_test.sh

code-style:
	python3 tools/run_pycodestyle.py

update-scenarios:
	python3 tools/gen_scenario_list.py > docs/scenarios_list.md

before_commit: code-style update-scenarios

docker-build:
	docker build -t insights-behavioral-spec:ci .
