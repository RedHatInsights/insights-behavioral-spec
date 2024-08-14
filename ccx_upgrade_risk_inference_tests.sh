#!/bin/bash -xe

# Copyright 2022 Red Hat, Inc
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
PATH_TO_LOCAL_INFERENCE_SERVICE=${PATH_TO_LOCAL_INFERENCE_SERVICE:="../ccx-upgrades-inference/"}

#set NOVENV if current environment is not a python virtual env
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

function install_inference_service() {
    pip install -r "$PATH_TO_LOCAL_INFERENCE_SERVICE"/requirements.txt || exit 1
    pip install "$PATH_TO_LOCAL_INFERENCE_SERVICE"/. || exit 1
    # shellcheck disable=SC2016
    add_exit_trap 'pip uninstall -y ccx-upgrades-inference'
}

# mechanism to chain more trap commands added in different parts of this script
exit_trap_command=""
function cleanup {
    eval "$exit_trap_command"
}
trap cleanup EXIT

function add_exit_trap {
    local to_add=$1
    if [[ -z "$exit_trap_command" ]]
    then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
}

# prepare virtual environment if necessary
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv ;;
esac

# Copy the binary and configuration to this folder
install_inference_service

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 behave \
    --no-capture \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/upgrades_inference_service.txt "$@"

bddExecutionExitCode=$?

exit $bddExecutionExitCode
