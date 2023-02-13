# insights-behavioral-spec
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


List of scenarios can be seen [there](features/README.md)
