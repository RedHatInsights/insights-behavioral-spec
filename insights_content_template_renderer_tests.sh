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
export PATH_TO_LOCAL_TEMPLATE_RENDERER=${PATH_TO_LOCAL_TEMPLATE_RENDERER:="../insights-content-template-renderer"}

function clone_service() {
    git clone --depth=1 https://github.com/RedHatInsights/insights-content-template-renderer.git
}

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

function install_service() {
    cd "$PATH_TO_LOCAL_TEMPLATE_RENDERER" || exit
    install_reqs
    cd "$dir_path" || exit
}

# prepare virtual environment if necessary
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv ;;
esac

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

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 behave \
    --no-capture \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/insights_content_template_renderer.txt "$@"

bddExecutionExitCode=$?

exit $bddExecutionExitCode
