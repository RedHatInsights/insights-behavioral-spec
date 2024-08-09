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
export PATH_TO_LOCAL_SHA_EXTRACTOR=${PATH_TO_LOCAL_SHA_EXTRACTOR:="../insights-sha-extractor"}

# shellcheck disable=SC2034
exit_trap_command=""

function clone_service() {
    git clone --depth=1 git@github.com:RedHatInsights/insights-sha-extractor.git
}

#set NOVENV is current environment is not a python virtual env
# shellcheck disable=SC2034
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

function install_reqs() {
    pip install -r requirements.txt
}

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && install reqs
    echo "Environment ready"
}

function install_service() {
    cd "$PATH_TO_LOCAL_SHA_EXTRACTOR" || exit
    pip install --no-cache-dir -U pip setuptools wheel
    pip install --no-cache-dir -r requirements.txt
    pip install -e .
    cd "$dir_path" || exit
}

function run_kafka() {
    kafka_cid=$(docker run --add-host=kafka:127.0.0.1 \
        --detach \
        --env-file config/insights_sha_extractor.env \
        --hostname kafka \
        --name kafka \
        --rm \
        --publish 9092:9092 \
        --add-host kafka:127.0.0.1 \
        quay.io/ccxdev/kafka-no-zk:latest)

    while true
    do
        echo "starting up kafka ..."
        start_up_complete=$(docker logs "$kafka_cid" | grep "Startup complete")
        if [ -z "$start_up_complete" ]; then
            echo "kafka ready"
            break
        fi
        sleep 1
    done

    export kafka_cid
    add_trap "docker kill ${kafka_cid}"
}

function run_mock_s3() {
    uvicorn mocks.s3.s3:app &
    s3_pid=$!
    add_trap "kill -9 $s3_pid"
}

function cleanup {
    eval "$exit_trap_command"
}

function add_trap() {
    local to_add=$1
    if [ -z $exit_trap_command ] ; then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
    trap cleanup EXIT
}

if [ ! -d "$PATH_TO_LOCAL_SHA_EXTRACTOR" ]; then
    if [[ -z $ENV_DOCKER ]]
    then
        clone_service && \
        install_service
    else
        echo "insights-sha-extractor directory '$PATH_TO_LOCAL_SHA_EXTRACTOR' not found in working directory. Please add it."
        exit 1
    fi
else
    echo "insights-sha-extractor directory found in working directory"
fi

if ! [ "$ENV_DOCKER" ] ; then
    run_kafka
    run_mock_s3
fi

[ "$NOVENV" != "1" ] || prepare_venv || exit 1

# Copy the binary and configuration to this folder
install_service

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/insights_sha_extractor.txt "$@"

bddExecutionExitCode=$?

exit $bddExecutionExitCode
