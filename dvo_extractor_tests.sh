#!/bin/bash -x

# Copyright 2024 Red Hat, Inc
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

export PATH_TO_LOCAL_DVO_EXTRACTOR=${PATH_TO_LOCAL_DVO_EXTRACTOR:="../dvo-extractor"}
#set NOVENV is current environment is not a python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

exit_trap_command=""

function install_certificates() {
    if [ -z "$ENV_DOCKER" ]; then
        return
    fi

    curl -ksL https://certs.corp.redhat.com/certs/2022-IT-Root-CA.pem -o /etc/pki/ca-trust/source/anchors/2022-IT-Root-CA.pem
    curl -ksL https://certs.corp.redhat.com/certs/Current-IT-Root-CAs.pem -o /etc/pki/ca-trust/source/anchors/Current-IT-Root-CAs.pem
    update-ca-trust
}

function install_reqs() {
    pip install -r requirements.txt || exit 1
}

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && install_reqs
    echo "Environment ready"
}

function install_extractor() {
    if [[ ! -d $PATH_TO_LOCAL_DVO_EXTRACTOR ]] ; then
    	git clone --depth=1 git@gitlab.cee.redhat.com:ccx/ccx-data-pipeline.git "$PATH_TO_LOCAL_DVO_EXTRACTOR"
    fi
    cwd=$(pwd)
    cd "$PATH_TO_LOCAL_DVO_EXTRACTOR" || exit
    pip install --no-cache-dir -U pip setuptools wheel
    pip install --no-cache-dir -r requirements.txt
    cd "$cwd" || exit 1
}

function run_kafka() {
    kafka_cid=$(docker run --add-host=kafka:127.0.0.1 \
        --detach \
        --env-file config/dvo_extractor.env \
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
    if [ -z "$exit_trap_command" ] ; then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
    trap cleanup EXIT
}

install_certificates
if ! [ "$ENV_DOCKER" ] ; then
    run_kafka
    run_mock_s3
fi

if [ "$NOVENV" ] ; then
    prepare_venv
else
    install_reqs
fi

install_extractor

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    --no-capture \
    -D dump_errors=true @test_list/dvo_extractor.txt "$@"
