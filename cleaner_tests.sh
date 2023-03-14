#!/bin/bash -x

# Copyright 2021, 2022, 2023 Red Hat, Inc
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
    echo "preparing virtual environment for tests execution"
    # shellcheck disable=SC1091
    python3 -m venv venv && source venv/bin/activate && python3 "$(which pip3)" install -r requirements.txt || exit 1
    echo "Environment ready"
}

# prepare virtual environment if necessary
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1
case "$NOVENV" in
    "") echo "using existing virtual env";;
    "1") prepare_venv;;
esac

if [[ ! -z $ENV_DOCKER ]]
then
    #set env vars
    export INSIGHTS_RESULTS_CLEANER__STORAGE__PG_DB_NAME=test INSIGHTS_RESULTS_CLEANER__STORAGE__PG_HOST=$DB_HOST INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PORT=$DB_PORT INSIGHTS_RESULTS_CLEANER__STORAGE__PG_USERNAME=$DB_USER INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PASSWORD=$DB_PASS INSIGHTS_RESULTS_CLEANER__STORAGE__DB_DRIVER=postgres INSIGHTS_RESULTS_CLEANER__STORAGE__PG_PARAMS="sslmode=disable"
fi

PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @test_list/cleaner.txt "$@"

