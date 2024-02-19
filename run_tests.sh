#!/bin/bash -x

function prepare_venv() {
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate
    pip install -r requirements.txt
    for f in requirements/*.txt; do
        echo "File -> $f" && pip install -r "$f" || exit 1
    done
}

# prepare virtual environment if necessary
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1
case "$NOVENV" in
    "") echo "using existing virtual env";;
    "1") prepare_venv;;
esac

for f in test_list/*.txt; do
    PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @"$f" "$@" || { echo "Tests in $f failed."; }
done
