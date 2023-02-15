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

# prepare virtual environment if necessary
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1
case "$NOVENV" in
    "") echo "using existing virtual env";;
    "1") prepare_venv;;
esac

PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @test_list/notification_writer.txt "$@"

