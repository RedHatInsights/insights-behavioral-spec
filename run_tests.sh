#!/bin/bash -x

function install_reqs() {
    pip install -r requirements.txt || exit 1
    if [ -d "requirements" ]; then
        for f in requirements/*.txt; do
            echo "File -> $f" && pip install -r "$f" || exit 1
        done
    fi
}

function prepare_venv() {
    # shellcheck disable=SC1091
    virtualenv -p python3 venv && source venv/bin/activate && install_reqs
}

# prepare virtual environment if necessary
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1
case "$NOVENV" in
    "") echo "using existing virtual env" && install_reqs;;
    "1") prepare_venv;;
esac

for f in test_list/*.txt; do
    PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @"$f" "$@" || { echo "Tests in $f failed."; }
done
