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


dir_path=$(dirname "$(realpath "$0")")
export PATH=$PATH:$dir_path
PATH_TO_LOCAL_NOTIFICATION_SERVICE="../ccx-notification-service"
PATH_TO_LOCAL_NOTIFICATION_WRITER="../ccx-notification-writer"

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

function start_mocked_dependencies() {
    pip install -r requirements/mocks.txt
    pushd "$dir_path"/mocks/insights-content-service && uvicorn content_server:app --port 8082 &
    pushd "$dir_path"/mocks/prometheus && uvicorn push_gateway:app --port 9091 &
    pushd "$dir_path"/mocks/service-log && uvicorn service_log:app --port 8000 &
    pushd "$dir_path"/mocks/content-template-renderer && uvicorn content_template_renderer:app --port 8083 &
    pushd "$dir_path"/mocks/token-refreshment && uvicorn token_refreshment:app --port 8001 &

    # shellcheck disable=SC2016
    add_exit_trap 'kill $(lsof -ti:8082); kill $(lsof -ti:9091); kill $(lsof -ti:8000); kill $(lsof -ti:8083); kill $(lsof -ti:8001)'
    pushd "$dir_path" || exit
    sleep 2  # wait for the mocks to be up
}

function get_binary() {
    (
        cd "$PATH_TO_LOCAL_NOTIFICATION_SERVICE" || exit
        make build
    )
    cp "$PATH_TO_LOCAL_NOTIFICATION_SERVICE/ccx-notification-service" .
    # cp "$PATH_TO_LOCAL_NOTIFICATION_SERVICE/config.toml" .
    cp config/notification_service.toml config.toml
    add_exit_trap 'rm ccx-notification-service; rm config.toml'
}

function init_db() {
    (
        cd "$PATH_TO_LOCAL_NOTIFICATION_WRITER" || exit
        make build
    )
    cp "$PATH_TO_LOCAL_NOTIFICATION_WRITER/ccx-notification-writer" .
    cp "$PATH_TO_LOCAL_NOTIFICATION_WRITER/config.toml" .
    ./ccx-notification-writer -db-init
    ./ccx-notification-writer -db-init-migration
    ./ccx-notification-writer -migrate latest
    rm ccx-notification-writer
    rm config.toml
}

function set_env_vars() {
    export DB_NAME=notification \
	   CCX_NOTIFICATION_SERVICE__STORAGE__DB_DRIVER=postgres \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_PARAMS=$DB_PARAMS \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_USERNAME=$DB_USER \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_PASSWORD=$DB_PASS \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_HOST=$DB_HOST \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_PORT=$DB_PORT \
	   CCX_NOTIFICATION_SERVICE__STORAGE__PG_DB_NAME=notification \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ADDRESSES="$KAFKA_HOST:$KAFKA_PORT" \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__TOPIC=platform.notifications.ingress \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__ENABLED=true \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__ENABLED=false \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__TOTAL_RISK_THRESHOLD=2 \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__TOTAL_RISK_THRESHOLD=2 \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__TAG_FILTER_ENABLED=true \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__TAGS=["osd_customer"] \
	   CCX_NOTIFICATION_SERVICE__METRICS__NAMESPACE=ccx_notification_service \
	   CCX_NOTIFICATION_SERVICE__METRICS__ADDRESS=":8080" \
	   CCX_NOTIFICATION_SERVICE__METRICS__JOB_NAME=ccx_notification_service \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__COOLDOWN=24h \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__COOLDOWN=24h \
	   CCX_NOTIFICATION_SERVICE__METRICS__GATEWAY_URL=pushgateway:9091 \
	   CCX_NOTIFICATION_SERVICE__METRICS__RETRIES=1 \
	   CCX_NOTIFICATION_SERVICE__METRICS__RETRY_AFTER=10s \
	   CCX_NOTIFICATION_SERVICE__METRICS__GATEWAY_TIME_BETWEEN_PUSH=30s \
	   CCX_NOTIFICATION_SERVICE__CLEANER__MAX_AGE="90 days" \
	   CCX_NOTIFICATION_SERVICE__DEPENDENCIES__CONTENT_SERVER="http://localhost:8082/api/v1/" \
	   CCX_NOTIFICATION_SERVICE__DEPENDENCIES__CONTENT_ENDPOINT=content \
	   CCX_NOTIFICATION_SERVICE__DEPENDENCIES__TEMPLATE_RENDERER_SERVER="http://localhost:8083/" \
	   CCX_NOTIFICATION_SERVICE__DEPENDENCIES__TEMPLATE_RENDERER_ENDPOINT="rendered_reports"  \
	   CCX_NOTIFICATION_SERVICE__KAFKA_BROKER__EVENT_FILTER="totalRisk >= totalRiskThreshold" \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__EVENT_FILTER="totalRisk >= totalRiskThreshold" \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__URL="http://localhost:8000/api/service_logs/v1/cluster_logs" \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__TOKEN_URL="http://localhost:8001/auth/realms/redhat-external/protocol/openid-connect/token" \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__CLIENT_ID=CLIENT_ID \
	   CCX_NOTIFICATION_SERVICE__SERVICE_LOG__CLIENT_SECRET=CLIENT_SECRET
}

function prepare_code_coverage() {
    echo "Preparing code coverage environment"
    rm -rf coverage
    mkdir coverage
    export GOCOVERDIR=coverage/
}

function code_coverage_report() {
    echo "Preparing code coverage report"
    go tool covdata merge -i=coverage/ -o=.
    go tool covdata textfmt -i=. -o=coverage.txt
    cat << EOF
    +--------------------------------------------------------------+
    | Coverage report is stored in file named 'coverage.txt'.      |
    | Copy that file into CCX Notification Service project         |
    | directory and run the following command to get report        |
    | in readable form:                                            |
    |                                                              |
    | go tool cover -func=coverage.txt                             |
    |                                                              |
    +--------------------------------------------------------------+
EOF
}

# mechanism to chain more trap commands added in different parts of this script
exit_trap_command=""
function cleanup {
    eval "$exit_trap_command"
}
trap cleanup EXIT

function add_exit_trap {
    local to_add=$1
    if [[ -z "$exit_trap_command" ]]
    then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
}

flag=${1:-""}

if [[ "${flag}" = "coverage" ]]
then
    shift
    prepare_code_coverage
fi

# prepare virtual environment if necessary
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv ;;
esac

#launch mocked services if WITHMOCK is provided
[ "$WITHMOCK" == "1" ] && start_mocked_dependencies

if [[ -z $ENV_DOCKER ]]
then
    # Create all the tables
    init_db
    # Copy the binary and configuration to this folder
    get_binary
else
    # set environment variables
    set_env_vars
fi

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 -m behave \
    --format=progress2 \
    --tags=-skip --tags=-managed \
    -D dump_errors=true @test_list/notification_service.txt "$@"

bddExecutionExitCode=$?

if [[ "${flag}" == "coverage" ]]
then
    code_coverage_report
fi

exit $bddExecutionExitCode
