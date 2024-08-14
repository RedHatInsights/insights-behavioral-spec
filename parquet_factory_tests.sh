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

dir_path=$(dirname "$(realpath "$0")")
export PATH=$PATH:$dir_path
PATH_TO_LOCAL_PARQUET_FACTORY=${PATH_TO_LOCAL_PARQUET_FACTORY:="../parquet-factory"}

#set NOVENV is current environment is not a python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

function install_reqs() {
    pip install -r requirements.txt || exit 1
}

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && install_reqs
    echo "Environment ready"
}

function get_binary() {
    (
        cd "$PATH_TO_LOCAL_PARQUET_FACTORY" || exit
        make build
    )
    cp "$PATH_TO_LOCAL_PARQUET_FACTORY/parquet-factory" .
    cp "$PATH_TO_LOCAL_PARQUET_FACTORY/config.toml" .
    add_exit_trap 'rm parquet-factory; config.toml'
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

function add_exit_trap {
    local to_add=$1
    if [[ -z "$exit_trap_command" ]]
    then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
}

flag=${1:-""}

if [[ "${flag}" = "coverage" ]]
then
    shift
    prepare_code_coverage
fi

# prepare virtual environment if necessary
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv ;;
esac

set_env_vars
get_binary

PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @test_list/parquet_factory.txt "$@"

bddExecutionExitCode=$?

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
