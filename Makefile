.PHONY: tests

default: tests

tests:	cleaner-tests exporter-tests

cleaner-tests:
	./cleaner_tests.sh

exporter-tests:
	./exporter_tests.sh

code-style:
	python3 tools/run_pycodestyle.py

before_commit: code-style
