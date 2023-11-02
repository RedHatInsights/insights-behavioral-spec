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

export PATH_TO_LOCAL_SHA_EXTRACTOR=${PATH_TO_LOCAL_SHA_EXTRACTOR:="../ccx-sha-extractor"}
exit_trap_command=""

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv 
    # shellcheck disable=SC1091
    source venv/bin/activate 
    python3 "$(which pip3)" install --no-cache -r requirements.in || exit 1
    python3 "$(which pip3)" install --no-cache -r requirements/insights_sha_extractor.txt || exit 1

    if [[ ! -d $PATH_TO_LOCAL_SHA_EXTRACTOR ]] ; then
    	git clone --depth=1 git@gitlab.cee.redhat.com:ccx/ccx-sha-extractor.git $PATH_TO_LOCAL_SHA_EXTRACTOR
	add_trap "rm -rf ./ccx-sha-extractor"
    fi
    cwd=$(pwd)
    cd $PATH_TO_LOCAL_SHA_EXTRACTOR || exit
    pip install --no-cache-dir -U pip setuptools wheel
    pip install --no-cache-dir -r requirements.txt
    pip install -e .
    cd "$cwd" || exit 1

    echo "Environment ready"
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

if ! [ "$ENV_DOCKER" ] ; then
    run_kafka
    run_mock_s3
fi

prepare_venv

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave --no-capture \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/insights_sha_extractor.txt "$@"
