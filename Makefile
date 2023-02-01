.PHONY: default tests code-style update-scenarios before_commit cleaner-tests exporter-tests notification-service notification-writer inference-service

default: tests

tests:	cleaner-tests exporter-tests inference-service

cleaner-tests:
	./cleaner_tests.sh

exporter-tests:
	./exporter_tests.sh

notification-service:
	./notification_service_tests.sh

notification-writer:
	./notification_writer_tests.sh

inference-service:
	./ccx_upgrade_risk_inference_tests.sh

data-engineering-service:
	./ccx_upgrade_risk_data_eng_tests.sh

code-style:
	python3 tools/run_pycodestyle.py

update-scenarios:
	python3 tools/gen_scenario_list.py > features/README.md

before_commit: code-style update-scenarios
