.PHONY: tests

SCHEMA_DIR=schemas
DATA_DIR=data

default: tests

code-style:
	python3 tools/run_pycodestyle.py

before_commit: code-style
