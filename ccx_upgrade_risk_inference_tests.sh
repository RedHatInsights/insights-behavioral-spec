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

# shellcheck source=tools/test_runner_common.sh disable=SC1091
source "$(dirname "$(realpath "$0")")/tools/test_runner_common.sh"

PATH_TO_LOCAL_INFERENCE_SERVICE=${PATH_TO_LOCAL_INFERENCE_SERVICE:-"../ccx-upgrades-inference/"}

function install_inference_service() {
    if [ -f "$PATH_TO_LOCAL_INFERENCE_SERVICE"/requirements.txt ]; then
        pip install -r "$PATH_TO_LOCAL_INFERENCE_SERVICE"/requirements.txt || exit 1
    fi
    pip install "$PATH_TO_LOCAL_INFERENCE_SERVICE"/. || exit 1
    # shellcheck disable=SC2016
    add_exit_trap 'pip uninstall -y ccx-upgrades-inference'
}

ensure_venv

# Copy the binary and configuration to this folder
install_inference_service

run_behave_tests "@test_list/upgrades_inference_service.txt" "$@"
bddExecutionExitCode=$?

exit $bddExecutionExitCode
