#!/bin/bash -ex

function prepare_venv() {
    virtualenv -p python3 venv && source venv/bin/activate
    python3 "$(which pip3)" install -r requirements.txt
    for f in requirements/*.txt; do
        echo "File -> $f" && python3 "$(which pip3)" install -r "$f" || exit 1
    done
}

# prepare virtual environment if necessary
case "$NOVENV" in
    "0") echo "using existing virtual env";;
    "1") prepare_venv;;
esac

for f in test_list/*.txt; do
    PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip -D dump_errors=true @"$f" "$@" || { echo "Tests in $f failed."; }
done

