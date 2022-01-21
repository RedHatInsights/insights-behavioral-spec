#!/bin/bash -ex

# Copyright 2021, 2022 Red Hat, Inc
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


export PATH=$PATH:/tmp/ramdisk/
export NOVENV=1

function prepare_venv() {
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && python3 "$(which pip3)" install -r requirements.txt
}

[ "$NOVENV" == "1" ] || prepare_venv || exit 1

# shellcheck disable=SC2068
PYTHONDONTWRITEBYTECODE=1 python3 "$(which behave)" --tags=-skip -D dump_errors=true @cleaner_list.txt $@

