#!/bin/bash -x

# shellcheck source=tools/test_runner_common.sh disable=SC1091
source "$(dirname "$(realpath "$0")")/tools/test_runner_common.sh"

ensure_venv

for f in test_list/*.txt; do
    PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @"$f" "$@" || { echo "Tests in $f failed."; }
done
