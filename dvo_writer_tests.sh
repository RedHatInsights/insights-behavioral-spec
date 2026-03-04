#!/bin/bash -x

# Copyright 2024 Red Hat, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# shellcheck source=tools/test_runner_common.sh disable=SC1091
source "$(dirname "$(realpath "$0")")/tools/test_runner_common.sh"

PATH_TO_LOCAL_DVO_WRITER=${PATH_TO_LOCAL_DVO_WRITER:-"../insights-results-aggregator"}

function get_binary() {
    [[ -d "$PATH_TO_LOCAL_DVO_WRITER" ]] || exit 1
    if [[ ! -f "$PATH_TO_LOCAL_DVO_WRITER/insights-results-aggregator" ]]; then
        (
            cd "$PATH_TO_LOCAL_DVO_WRITER" || exit
            make build || exit 1
        ) || exit 1
    fi
    cp "$PATH_TO_LOCAL_DVO_WRITER/insights-results-aggregator" . || exit 1
    cp "$PATH_TO_LOCAL_DVO_WRITER/openapi.json" . || exit 1
    add_exit_trap 'rm -f insights-results-aggregator openapi.json'
}

function set_env_vars(){
    export INSIGHTS_RESULTS_AGGREGATOR_CONFIG_FILE="config/dvo_writer_docker_env.toml" \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__PG_USERNAME=$DB_USER \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__PG_PASSWORD=$DB_PASS \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__PG_HOST=$DB_HOST \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__PG_PORT=$DB_PORT \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__PG_DB_NAME=$DB_NAME \
    INSIGHTS_RESULTS_AGGREGATOR__DVO_RECOMMENDATIONS_STORAGE__TYPE="sql" \
    INSIGHTS_RESULTS_AGGREGATOR__STORAGE_BACKEND__USE="dvo_recommendations"
}

function prepare_code_coverage() {
    echo "Preparing code coverage environment"
    rm -rf coverage
    mkdir coverage
    export GOCOVERDIR=coverage/
}

function code_coverage_report() {
    echo "Preparing code coverage report"
    go tool covdata merge -i=coverage/ -o=.
    go tool covdata textfmt -i=. -o=coverage.txt
    cat << EOF
    +--------------------------------------------------------------+
    | Coverage report is stored in file named 'coverage.txt'.      |
    | Copy that file into Aggregator project directory and run the |
    | following command to get report in readable form:            |
    |                                                              |
    | go tool cover -func=coverage.txt                             |
    |                                                              |
    +--------------------------------------------------------------+
EOF
}

flag=${1:-""}

if [[ "${flag}" = "coverage" ]]
then
    shift
    prepare_code_coverage
fi

ensure_venv

if [[ -n $ENV_DOCKER ]]
then
    #set env vars
    set_env_vars
fi

echo "Getting binary from $PATH_TO_LOCAL_DVO_WRITER"
get_binary

run_behave_tests "@test_list/dvo_writer.txt" "$@"

bddExecutionExitCode=$?

# time to disconnect from Kafka and from PostgreSQL
sleep 2

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
