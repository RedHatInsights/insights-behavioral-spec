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

PATH_TO_LOCAL_SMART_PROXY=${PATH_TO_LOCAL_SMART_PROXY:-"../insights-results-smart-proxy"}

function get_binary() {
    [[ -d "$PATH_TO_LOCAL_SMART_PROXY" ]] || exit 1
    if [[ ! -f "$PATH_TO_LOCAL_SMART_PROXY/insights-results-smart-proxy" ]]; then
        (
            cd "$PATH_TO_LOCAL_SMART_PROXY" || exit
            make build || exit 1
        ) || exit 1
    fi
    cp "$PATH_TO_LOCAL_SMART_PROXY/insights-results-smart-proxy" . || exit 1
    cp "$PATH_TO_LOCAL_SMART_PROXY/config.toml" . || exit 1
    add_exit_trap 'rm -f insights-results-smart-proxy config.toml'
}

function set_env_vars(){
    :
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

if [[ -n $ENV_DOCKER ]]
then
    # set environment variables
    set_env_vars
fi

echo "Getting binary from $PATH_TO_LOCAL_SMART_PROXY"
get_binary

run_behave_tests "@test_list/smart_proxy.txt" "$@"

bddExecutionExitCode=$?

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
