#!/bin/bash -x

# Copyright 2023 Red Hat, Inc
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

PATH_TO_LOCAL_PARQUET_FACTORY=${PATH_TO_LOCAL_PARQUET_FACTORY:-"../parquet-factory"}

function get_binary() {
    (
        cd "$PATH_TO_LOCAL_PARQUET_FACTORY" || exit
        make build
    )
    cp "$PATH_TO_LOCAL_PARQUET_FACTORY/parquet-factory" .
    cp "$PATH_TO_LOCAL_PARQUET_FACTORY/config.toml" .
    add_exit_trap 'rm -f parquet-factory config.toml'
}

function set_env_vars(){
    export S3_OLDER_MINIO_COMPATIBILITY=1 \
        PARQUET_FACTORY__S3__ENDPOINT=minio:9000 \
        PARQUET_FACTORY__S3__BUCKET=test \
        PARQUET_FACTORY__S3__ACCESS_KEY=test_access_key \
        PARQUET_FACTORY__S3__SECRET_KEY=test_secret_access_key
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
    | Copy that file into Smart Proxy project                      |
    | directory and run the following command to get report        |
    | in readable form:                                            |
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

set_env_vars
get_binary

run_behave_tests "@test_list/parquet_factory.txt" "$@"

bddExecutionExitCode=$?

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
