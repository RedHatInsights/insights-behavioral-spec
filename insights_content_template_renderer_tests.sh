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

export PATH_TO_LOCAL_TEMPLATE_RENDERER=${PATH_TO_LOCAL_TEMPLATE_RENDERER:-"../insights-content-template-renderer"}

function clone_service() {
    git clone --depth=1 https://github.com/RedHatInsights/insights-content-template-renderer.git
}

function install_service() {
    pip install "$PATH_TO_LOCAL_TEMPLATE_RENDERER" || exit 1
    # shellcheck disable=SC2016
    add_exit_trap 'pip uninstall -y insights-content-template-renderer'
}

ensure_logs_dir
ensure_venv

if [ ! -d "$PATH_TO_LOCAL_TEMPLATE_RENDERER" ]; then
    if [[ -z $ENV_DOCKER ]]
    then
        clone_service && \
        install_service
    else
        echo "insights-content-template-renderer directory '$PATH_TO_LOCAL_TEMPLATE_RENDERER' not found in working directory. Please add it."
        exit 1
    fi
else
    echo "insights-content-template-renderer directory found in working directory"
fi


# Copy the binary and configuration to this folder
install_service
run_behave_tests "@test_list/insights_content_template_renderer.txt" --tags=-managed "$@"

bddExecutionExitCode=$?

exit $bddExecutionExitCode
