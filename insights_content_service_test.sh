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
    python3 "$(which pip3)" install --no-cache -r requirements/insights-content-service.txt || exit 1
    echo "Environment ready"
}

function run_service() {
    git clone --depth=1 git@github.com:RedHatInsights/insights-content-service.git
    cd insights-content-service
    ./update_rules_content.sh
    ./build.sh
    ./insights-content-service > /dev/null &
    cd ..
}

prepare_venv
run_service
content_service_pid=$!

sleep 2
# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/insights_content_service.txt "$@"

kill -9 $content_service_pid
rm -rf ./insights-content-service

