# insights-behavioral-spec

[![GitHub Pages](https://img.shields.io/badge/%20-GitHub%20Pages-informational)](https://redhatinsights.github.io/insights-behavioral-spec/)
[![License](https://img.shields.io/badge/license-Apache-blue)](https://github.com/RedHatInsights/insights-behavioral-spec/blob/master/LICENSE)
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

Behavioral specifications for Insights pipelines and its integration into OCM, OCP, ACM, Notification Service, and ServiceLog. Specifications are written in [Gherkin language](https://cucumber.io/docs/guides/overview/), test steps implementations are written in Python 3.x.

<!-- vim-markdown-toc GFM -->

* [How to run the scenarios](#how-to-run-the-scenarios)
    * [Spin up the docker containers](#spin-up-the-docker-containers)
    * [Example: run the notification service suite locally](#example-run-the-notification-service-suite-locally)
    * [Run the tests using the Makefile targets](#run-the-tests-using-the-makefile-targets)
* [List of existing behavioral specifications (features)](#list-of-existing-behavioral-specifications-features)
* [List of scenarios](#list-of-scenarios)
* [List of tags](#list-of-tags)
* [Makefile targets](#makefile-targets)
* [Additional tools](#additional-tools)

<!-- vim-markdown-toc -->

## How to run the scenarios

Local runs are usually not just `behave`. Scenarios live under `features/<service>/` (Gherkin), step implementations live under `features/steps/`. Docker Compose supplies shared infrastructure such as PostgreSQL and Kafka. Many service suites are driven by a root `*_tests.sh` or `*_test.sh` launcher, whose responsibilities vary. It may prepare the tested service, start mocks, initialize data, and invoke Behave.

For a separate containerized path, use the `run_in_docker.sh` script explained in the [additional tools documentation](https://redhatinsights.github.io/insights-behavioral-spec/tools.html#script-to-run-bdd-tests-in-docker-environment).

### Spin up the docker containers

Docker Compose provides shared infrastructure such as PostgreSQL, Kafka, and MinIO. Additional dependencies are grouped into service-specific profiles.

The following commands are examples, not a sequence required by every suite:

```bash
# Default services
docker compose up -d

# Default services plus exporter dependencies
docker compose --profile test-exporter up -d
```

A profile starts its services in addition to services without a profile. Compose does not run the Behave suite or replace the service-specific launcher.

Database requirements are launcher-specific. `POSTGRES_DB_NAME` controls the database initially created by the PostgreSQL container, but notification-related suites do not all use the same database name. The host-side notification-service path below uses the `test` database.

If you do not use Compose, provide the required services locally and export their connection settings. Tag selection and other setup are launcher-specific; inspect the corresponding launcher before running the suite.

> **_NOTE:_** Set up `PATH` correctly when running tests inside or outside containers. It must contain the tested executable, for example `insights-results-aggregator-cleaner`.

#### Running tests inside the test container

When running tests inside the Docker containers, put the tested executable in `$VIRTUAL_ENV_BIN` with the correct permissions. For example, after compiling `insights-results-aggregator`, first obtain the ID of the running `bddtests` container and then copy the executable:

```bash
cid=$(docker ps --filter name=bddtests --format '{{.ID}}' | head -n1)

docker cp insights-results-aggregator \
  "$cid:$(docker exec "$cid" bash -c 'echo "$VIRTUAL_ENV_BIN"')"

docker exec -u root "$cid" \
  /bin/bash -c 'chmod +x "$VIRTUAL_ENV_BIN/insights-results-aggregator"'
```

Tests for Python-based services need similar setup, but the service source code must be available inside the container. A volume matching the path expected by the launcher is generally more convenient than copying the project for every run.

The `no-mock` profile provides a separate path for running real HTTP dependencies instead of host-side mocks. Set `WITHMOCK=0` and verify the database name and environment required by the selected launcher before using that profile.

### Example: run the notification service suite locally

As a worked example of a host-side suite, the following path was verified on Fedora with Podman. It uses Compose for PostgreSQL and Kafka, while CCX Notification Service, its HTTP dependency mocks, and Behave run on the host. Other suites may require different Compose profiles, environment variables, or setup steps; inspect the corresponding launcher and test list.

#### Prerequisites

* Clone `ccx-notification-service` next to this repository, or set `SERVICE_UNDER_TEST` or `PATH_TO_LOCAL_NOTIFICATION_SERVICE` to its checkout.
* Install Go if the notification-service binary needs to be built.
* Ensure `lsof` is on `PATH` (used to stop host mocks). On a first run the launcher may also `git clone` and build `ccx-notification-writer` under `/tmp` for DB init (needs network and Go).
* Install Docker Compose, or Podman with a Docker-compatible CLI and Compose wrapper.
* Put a `kcat` build that supports JSON output (`-J`) on `PATH`. Use a team-provided build if the distribution package does not support `-J`.
* Ensure that Kafka's advertised hostname resolves locally, for example by adding this entry to `/etc/hosts`:

  ```text
  127.0.0.1 kafka
  ```

* Create and activate a Python virtual environment:

  ```bash
  python3 -m venv venv
  source venv/bin/activate
  pip install -r requirements.txt
  ```

#### Start the required infrastructure

From the repository root, run:

```bash
docker compose up -d
docker compose --profile test-notification-services up -d
```

PostgreSQL is published on host port `25432`; Kafka is published on `9092`.

The notification profile also starts Pushgateway and a one-shot database initializer configured for the `notification` database. This host-side suite uses the `test` database. If the initializer exits because the `notification` database does not exist, this path does not rely on it; the launcher initializes the `test` database itself.

The `WITHMOCK=1` launcher starts the HTTP mocks and performs the database initialization used by the tests.

The profile Pushgateway and the host-side Prometheus mock both use port `9091`. This path was verified with Podman; another container engine may need adjustment if that port is already bound.

#### Export the connection settings

```bash
export DB_HOST=localhost DB_PORT=25432 DB_USER=postgres DB_PASS=postgres \
  DB_NAME=test DB_PARAMS="sslmode=disable" \
  KAFKA_HOST=localhost KAFKA_PORT=9092
```

Compose exposes PostgreSQL on host port `25432`. Behave defaults to `5432` when `DB_PORT` is unset and would therefore connect to the wrong port.

#### Reset the database before a rerun

The current notification database initialization and migration path is not cleanly repeatable against a database left by an earlier full run. Before rerunning the full launcher, reset the `test` database schema:

```bash
docker compose exec database \
  psql -U postgres -d test \
  -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
```

This deletes all objects in the `public` schema of the local `test` database. It is not needed for the first run against an empty database.

#### Run the suite

```bash
source venv/bin/activate
WITHMOCK=1 make notification-service
```

The `make notification-service` target does not enable mocks by itself.

The launcher starts the HTTP mocks, prepares the notification-service binary, initializes and migrates the database, runs the configured Behave test list (`test_list/notification_service.txt`), and stops the mocks when it exits.

The launcher forwards additional options to Behave. To select one feature while retaining the launcher setup, invoke the script directly:

```bash
WITHMOCK=1 ./notification_service_tests.sh \
  --include 'service_log\.feature$'
```

The launcher still performs its complete setup and cleanup when a feature is selected this way.

### Run the tests using the Makefile targets

Makefile targets invoke the corresponding service launchers. They do not generally start Compose or enable mocked dependencies automatically. Inspect the relevant launcher, Compose profile, and test-list file for the suite being run.

For example, after completing the notification-service setup above:

```bash
WITHMOCK=1 make notification-service
```

To list the available targets, run:

```bash
make help
```

The targets are also listed in the
[Makefile targets documentation](https://redhatinsights.github.io/insights-behavioral-spec/makefile_targets.html).

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
