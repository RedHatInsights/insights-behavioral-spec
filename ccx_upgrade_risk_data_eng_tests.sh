#!/bin/bash -x

# Copyright 2022, 2023 Red Hat, Inc
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

PATH_TO_LOCAL_DATA_ENG_SERVICE=${PATH_TO_LOCAL_DATA_ENG_SERVICE:-"../ccx-upgrades-data-eng"}

function install_data_eng_service() {
    pip install "$PATH_TO_LOCAL_DATA_ENG_SERVICE" || exit 1
    # shellcheck disable=SC2016
    add_exit_trap 'pip uninstall -y ccx-upgrades-data-eng'
}

function start_mocked_dependencies() {
    # dir_path is set by test_runner_common.sh
    # shellcheck disable=SC2154
    start_mock mocks/inference-service "uvicorn inference_service:app --port 8001"
    start_mock mocks/rhobs "uvicorn rhobs_service:app --port 8002"

    # shellcheck disable=SC2016
    add_exit_trap 'kill $(lsof -ti:8001); kill $(lsof -ti:8002); kill $(lsof -ti:9090); kill $(lsof -ti:9091);'
    sleep 2  # wait for the mocks to be up
}

ensure_logs_dir
ensure_venv

# Copy the binary and configuration to this folder
install_data_eng_service

[ "$WITHMOCK" == "1" ] && start_mocked_dependencies

run_behave_tests "@test_list/upgrades_data_eng_service.txt" "$@"
bddExecutionExitCode=$?

exit $bddExecutionExitCode
