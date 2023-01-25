.PHONY: tests

default: tests

tests:	cleaner-tests exporter-tests

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

code-style:
	python3 tools/run_pycodestyle.py

update-scenarios:
	python3 tools/gen_scenario_list.py > features/README.md

before_commit: code-style update-scenarios
