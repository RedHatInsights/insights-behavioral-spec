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

if [ -z "$ENV_DOCKER" ]; then
    PATH_TO_LOCAL_CONTENT_SERVICE=${PATH_TO_LOCAL_CONTENT_SERVICE:="../content-service"}
else
    PATH_TO_LOCAL_CONTENT_SERVICE=${PATH_TO_LOCAL_CONTENT_SERVICE:="content-service"}
fi

#set NOVENV is current environment is not a python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    python3 -m venv venv
    # shellcheck disable=SC1091
    source venv/bin/activate
    pip install --no-cache -r requirements.txt || exit 1
    echo "Environment ready"
}

function clone_service() {
    git clone --depth=1 git@gitlab.cee.redhat.com:ccx/content-service.git "${PATH_TO_LOCAL_CONTENT_SERVICE}"
}

function install_service() {
    cd "${PATH_TO_LOCAL_CONTENT_SERVICE}" || exit
    ./update_rules_content.sh
    ./build.sh
    cd ..
}

function run_service() {
    pushd "${PATH_TO_LOCAL_CONTENT_SERVICE}" || exit
    ./insights-content-service > /dev/null &
    popd || exit
}

# prepare virtual environment if necessary
case "$NOVENV" in
    "") echo "using existing virtual env";;
    "1") prepare_venv;;
esac

if [ ! -d "${PATH_TO_LOCAL_CONTENT_SERVICE}" ]; then
    if [[ -z $ENV_DOCKER ]]
    then
        clone_service && \
        install_service
        REMOVE_CONTENT_SERVICE_DIRECTORY=1
    else
        echo "content-service directory not found in working directory. Please add it (with the compiled executable)!"
        exit 1
    fi
else
    echo "content-service directory found in working directory"
fi

run_service
content_service_pid=$!

sleep 2
# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave --no-capture \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/insights_content_service.txt "$@"

exitCode=$?

kill -9 $content_service_pid
$REMOVE_CONTENT_SERVICE_DIRECTORY || rm -rf ./insights-content-service
exit $exitCode
