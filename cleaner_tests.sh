#!/bin/bash -x

# Copyright 2021, 2022, 2023 Red Hat, Inc
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

function install_reqs() {
    pip install -r requirements.txt || exit 1
}

function prepare_venv() {
    echo "preparing virtual environment for tests execution"
    # shellcheck disable=SC1091
    python3 -m venv venv && source venv/bin/activate && install_reqs
    echo "Environment ready"
}

function set_env_vars(){
    export INSIGHTS_RESULTS_CLEANER__STORAGE__PG_DB_NAME=test \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__PG_HOST=$DB_HOST \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PORT=$DB_PORT \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__PG_USERNAME=$DB_USER \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PASSWORD=$DB_PASS \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__DB_DRIVER=postgres \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PARAMS="sslmode=disable" \
	   INSIGHTS_RESULTS_CLEANER__STORAGE__SCHEMA="ocp_recommendations"
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
    | Copy that file into Clenaer project directory and run the    |
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

# prepare virtual environment if necessary
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv;;
esac


if [[ -n $ENV_DOCKER ]]
then
    #set env vars
    set_env_vars
fi

PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @test_list/cleaner.txt "$@"

bddExecutionExitCode=$?

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
