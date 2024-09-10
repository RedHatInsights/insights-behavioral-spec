---
layout: page
nav_order: 8
---

## Additional tools

### Script to generate list of scenarion

#### Description

Tool to generate list of scenarios that can be added onto GitHub pages

#### Usage

```
python3 tools/gen_scenario_list.py > docs/scenarios_list.md
```

#### Source code

This tool is available on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/tools/gen_scenario_list.py


### Script to check code style for Python sources

#### Description

Simple checker of all Python sources in the given directory (usually for the whole repository).

#### Source code

This tool is available on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/tools/run_pycodestyle.py

### Script to run BDD tests in docker environment

#### Description

In order to run the tests within the docker-compose environment prepared for such, the `run_in_docker.sh`
script can be used. It expects the following arguments:
- one of the [makefile targets](https://redhatinsights.github.io/insights-behavioral-spec/makefile_targets.html)
- the local path to the service you want to run the BDD scenarios against.

The script will take care of starting all the required containers, copying the necessary files into the
docker container, and starting the corresponding tests.

#### Usage

Example command:

`./run_in_docker.sh aggregator-mock-tests $PATH_TO_CLONED_REPOS/insights-results-aggregator-mock`

As of today, not all the makefile targets are supported. The script can be run using the following targets:

```
aggregator-tests
aggregator-mock-tests
cleaner-tests
data-engineering-service-tests
exporter-tests
inference-service-tests
insights-content-service-tests
insights-content-template-renderer-tests
insights-sha-extractor-tests
notification-service-tests
notification-writer-tests
smart-proxy-tests
```

#### Source code

This tool is available on https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/run_in_docker.sh

