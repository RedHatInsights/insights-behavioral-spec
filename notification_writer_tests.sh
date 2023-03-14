#!/bin/bash -x

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

function prepare_venv() {
    echo "Preparing environment"
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && python3 "$(which pip3)" install -r requirements/notification_writer.txt || exit 1
    echo "Environment ready"
}

function set_env_vars(){
    export DB_NAME=notification CCX_NOTIFICATION_WRITER__STORAGE__DB_DRIVER=postgres CCX_NOTIFICATION_WRITER__STORAGE__PG_PARAMS=$DB_PARAMS CCX_NOTIFICATION_WRITER__STORAGE__PG_USERNAME=$DB_USER CCX_NOTIFICATION_WRITER__STORAGE__PG_PASSWORD=$DB_PASS CCX_NOTIFICATION_WRITER__STORAGE__PG_HOST=$DB_HOST CCX_NOTIFICATION_WRITER__STORAGE__PG_PORT=$DB_PORT CCX_NOTIFICATION_WRITER__STORAGE__PG_DB_NAME=notification CCX_NOTIFICATION_WRITER__BROKER__ADDRESS="$KAFKA_HOST:$KAFKA_PORT" CCX_NOTIFICATION_WRITER__BROKER__TOPIC=ccx.ocp.results CCX_NOTIFICATION_WRITER__BROKER__GROUP=test-consumer-group CCX_NOTIFICATION_WRITER__BROKER__ENABLED=true CCX_NOTIFICATION_WRITER__METRICS__NAMESPACE=notification-writer CCX_NOTIFICATION_WRITER__METRICS__ADDRESS=:8080
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
    set_env_vars
fi

PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @test_list/notification_writer.txt "$@"

