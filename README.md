# insights-behavioral-spec

[![GitHub Pages](https://img.shields.io/badge/%20-GitHub%20Pages-informational)](https://redhatinsights.github.io/insights-behavioral-spec/)
[![License](https://img.shields.io/badge/license-Apache-blue)](https://github.com/RedHatInsights/insights-behavioral-spec/blob/master/LICENSE)
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

Behavioral specifications for Insights pipelines and its integration into OCM, OCP, ACM, Notification Service, and ServiceLog. Specifications are written in [Gherkin language](https://cucumber.io/docs/guides/overview/), test steps implementations are written in Python 3.x.

<!-- vim-markdown-toc GFM -->

* [How to run the scenarios](#how-to-run-the-scenarios)
    * [Spin up the docker containers](#spin-up-the-docker-containers)
    * [Run the tests using the Makefile targets](#run-the-tests-using-the-makefile-targets)
* [List of existing behavioral specifications (features)](#list-of-existing-behavioral-specifications-features)
* [List of scenarios](#list-of-scenarios)
* [List of tags](#list-of-tags)
* [Makefile targets](#makefile-targets)
* [Additional tools](#additional-tools)

<!-- vim-markdown-toc -->

## How to run the scenarios

Optional: Use the `run_in_docker.sh` script explained in the [additional tools documentation](https://redhatinsights.github.io/insights-behavioral-spec/tools.html#script-to-run-bdd-tests-in-docker-environment).

### Spin up the docker containers

```
docker-compose up -d
docker-compose --profile test-exporter up -d
POSTGRES_DB_NAME=notification docker-compose --profile test-notification-services up -d
```

The `POSTGRES_DB_NAME` environment variable, which defaults to the value `test`, is mandatory when starting tests related to the notification services.
This is because the different services expect different database names: `notification` is used by services related with notification service, and `test` for the rest.

If you don't want to spin up the containers, you'll need to locally run the required services (database, Kafka, etc.). You may need to add or remove the `managed` tag in the `${SERVICE}_tests.sh`.

> **_NOTE:_**  Don't forget to set up `PATH` environment variable correctly when running tests both within and outside containers. That environment variable needs to contain the path with tested executable files (for example `insights-results-aggregator-cleaner` etc.).

When running the tests within the docker containers, it is necessary to have said executable under the `$VIRTUAL_ENV_BIN` folder with the right permissions. For example, after compiling `insights-results-aggregator`:

```
docker cp insights-results-aggregator $cid:`docker exec $cid bash -c 'echo "$VIRTUAL_ENV_BIN"'`
docker exec -u root $cid /bin/bash -c 'chmod +x $VIRTUAL_ENV_BIN/insights-results-aggregator'
```

The tests for our Python-based services need a similar setup, but the whole source code of the service would need to be copied inside the container. It is more useful to setup a volume that matches the path where the service is expected to be found.

If you want to run the real dependencies (content-service and service log), run `POSTGRES_DB_NAME=<test|notification> docker-compose --profile no-mock up -d` instead and `export WITHMOCK=0`.

### Run the tests using the Makefile targets

A simple example:

```
make notification-service
```

The targets that can be used are listed in the [makefile targets documentation](https://redhatinsights.github.io/insights-behavioral-spec/makefile_targets.html)

## List of existing behavioral specifications (features)

All features are listed [on this page](https://redhatinsights.github.io/insights-behavioral-spec/feature_list.html)

## List of scenarios

List of scenarios can be seen [there](https://redhatinsights.github.io/insights-behavioral-spec/scenarios_list.html)

## List of tags

It is possible to filter test scenarios to be run not only by project name but also by using tag or tags. List of all tags used in test scenarios are listed on [this page](https://redhatinsights.github.io/insights-behavioral-spec/tags.html)

## Makefile targets

Please look at [this page](https://redhatinsights.github.io/insights-behavioral-spec/makefile_targets.html)

## Additional tools

This repository contains additional tools and helpers. Description of such tools can be found on [this page](https://redhatinsights.github.io/insights-behavioral-spec/tools.html)
