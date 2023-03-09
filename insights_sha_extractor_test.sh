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

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv 
    source venv/bin/activate 
    python3 "$(which pip3)" install --no-cache -r requirements.in || exit 1
    echo "Environment ready"
}

function run_kafka() {
    kafka_cid=$(docker run --add-host=kafka:127.0.0.1 \
        --detach \
        --env-file config/insights_sha_extractor.env \
        --hostname kafka \
        --name kafka \
        --rm \
        --publish 9092:29092 \
        quay.io/ccxdev/kafka-no-zk:latest)
    
    while true
    do
        echo "starting up kafka ..."
        start_up_complete=`docker logs $kafka_cid | grep "Startup complete"`
        if [ ! -n "$start_up_complete" ]; then
            echo "kafka ready"
            break
        fi
        sleep 1
    done
}

run_kafka