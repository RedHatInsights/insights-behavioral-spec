#!/bin/bash -ex

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


dir_path=$(dirname $(realpath $0))
export PATH=$PATH:$dir_path

#set NOVENV is current environment is not a python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

function install_reqs() {
	python3 $(which pip3) install -r requirements.txt
}

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && python3 "$(which pip3)" install -r requirements/notification_service.txt
    echo "Environment ready"
}

function start_mocked_dependencies() {
    python3 $(which pip3) install -r requirements_mocks.txt
    pushd $dir_path/mocks/insights-content-service && uvicorn content_server:app --port 8082 &
    pushd $dir_path/mocks/prometheus && uvicorn push_gateway:app --port 9091 &
    trap 'kill $(lsof -ti:8082); kill $(lsof -ti:9091);' EXIT
    pushd $dir_path
}

[ "$NOVENV" != "1" ] && install_reqs || prepare_venv || exit 1

#launch mocked services if WITHMOCK is provided
[ "$WITHMOCK" == "1" ] && start_mocked_dependencies

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 "$(which behave)" --tags=-skip -D dump_errors=true @test_list/notification_service.txt "$@"
