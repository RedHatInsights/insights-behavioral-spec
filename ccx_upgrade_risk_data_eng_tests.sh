#!/bin/bash -ex

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


dir_path=$(dirname $(realpath $0))
export PATH=$PATH:$dir_path
PATH_TO_LOCAL_DATA_ENG_SERVICE=${PATH_TO_LOCAL_DATA_ENG_SERVICE:="../ccx-inference-service"}

#set NOVENV is current environment is not a python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

function install_reqs() {
    python3 $(which pip3) install -r requirements.txt
}

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && python3 "$(which pip3)" install -r requirements/upgrades_data_eng_service.txt
    echo "Environment ready"
}

function install_inference_service() {
    python3 "$(which pip3)" install $PATH_TO_LOCAL_DATA_ENG_SERVICE
    add_exit_trap 'python3 "$(which pip3)" uninstall -y ccx-upgrades-data-eng'
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

[ "$NOVENV" != "1" ] && install_reqs || prepare_venv || exit 1

# Copy the binary and configuration to this folder
install_inference_service

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 "$(which behave)" \
    --no-capture \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/upgrades_data_eng_service.txt "$@"