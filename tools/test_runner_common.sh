# Common setup for BDD test runner scripts (*_tests.sh).
# Source after the license block (from script in repo root):
#   source "$(dirname "$(realpath "$0")")/tools/test_runner_common.sh"
# This file sets dir_path from $0 (caller's script path).
#
# Provides: dir_path, PATH update, NOVENV, exit trap chain (add_exit_trap, cleanup),
#           install_reqs(), prepare_venv(), ensure_venv()

# Script directory (repo root when scripts are in root) and PATH
dir_path=$(dirname "$(realpath "$0")")
export dir_path
export PATH=$PATH:$dir_path

# Set NOVENV if current environment is not a Python virtual env
[ "$VIRTUAL_ENV" != "" ] || NOVENV=1

# Mechanism to chain more trap commands added in different parts of the script
# shellcheck disable=SC2034
exit_trap_command=""
function cleanup {
    # shellcheck disable=SC2317
    eval "$exit_trap_command"
}
trap cleanup EXIT

function add_exit_trap {
    local to_add=$1
    if [[ -z "$exit_trap_command" ]]; then
        exit_trap_command="$to_add"
    else
        exit_trap_command="$exit_trap_command; $to_add"
    fi
}

function install_reqs() {
    pip install -r requirements.txt || exit 1
}

function prepare_venv() {
    echo "Preparing virtual environment for tests execution"
    # shellcheck disable=SC1091
    python3 -m venv venv && source venv/bin/activate && install_reqs
    echo "Environment ready"
}

# Prepare virtual environment if necessary (use after setting NOVENV).
# Usage: ensure_venv
function ensure_venv() {
    case "$NOVENV" in
        "") echo "using existing virtual env" && install_reqs ;;
        "1") prepare_venv ;;
    esac
}
