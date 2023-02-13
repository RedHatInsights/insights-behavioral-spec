# insights-behavioral-spec

[![GitHub Pages](https://img.shields.io/badge/%20-GitHub%20Pages-informational)](https://redhatinsights.github.io/insights-behavioral-spec/)
[![License](https://img.shields.io/badge/license-Apache-blue)](https://github.com/RedHatInsights/insights-behavioral-spec/blob/master/LICENSE)
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

Behavioral specifications for Insights pipelines and its integration into OCM, OCP, and ACM

## How to run the scenarios

Optional: Spin up the docker containers:

```
docker-compose up -d
```

If you don't want to spin up the containers, you'll need to locally run the required services (database, Kafka, etc.). You may need to add or remove the `managed` tag in the `${SERVICE}_tests.sh`.

If you want to run the real dependencies (content-service and service log), run `docker-compose --profile no-mock up -d` instead and `export WITHMOCK=0`.

Run the tests for your repository, for example:

```
make notification-service
```

## List of existing behavioral specifications (features)

All features are listed [on this page](https://redhatinsights.github.io/insights-behavioral-spec/feature_list.html)

## List of scenarios

List of scenarios can be seen [there](https://redhatinsights.github.io/insights-behavioral-spec/scenarios_list.html)
