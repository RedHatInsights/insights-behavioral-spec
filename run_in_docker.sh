#!/bin/bash -x

# This script assumes that a Go service is already built, and the Python service can be interpreted without errors

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Check if Podman is installed
if command_exists podman; then
  CONTAINER_TOOL="podman"
# Check if Docker is installed
elif command_exists docker; then
  CONTAINER_TOOL="docker"
else
  echo "Neither Docker nor Podman is installed on this system."
  exit 1
fi

# shellcheck disable=SC2016
REMOTE_PATH_FOR_SERVICE="$cid:$("$CONTAINER_TOOL" exec "$cid" bash -c 'echo "$HOME"')"

# Function to get the correct profile to add based on service name specified by the user
with_profile() {
  local target="$1"
  case "$target" in
    "aggregator-tests") echo "--profile test-aggregator" ;;
    "aggregator-mock-tests") echo "" ;;
    "cleaner-tests") echo "" ;;
    "data-engineering-service-tests") echo "--profile test-upgrades-data-eng" ;;
    "dvo-extractor-tests") echo "--profile test-dvo-extractor" ;;
    "dvo-writer-tests") echo "--profile test-dvo-writer" ;;
    "exporter-tests") echo "--profile test-exporter" ;;
    "inference-service-tests") echo "" ;;
    "insights-content-service-tests") echo "" ;;
    "insights-content-template-renderer-tests") echo "" ;;
    "insights-sha-extractor-tests") echo "--profile test-sha-extractor" ;;
    "notification-service-tests") echo "--profile test-notification-services" ;;
    "notification-writer-tests") echo "--profile test-notification-services" ;;
    "smart-proxy-tests") echo "" ;;
    "parquet-factory-tests") echo "--profile test-parquet-factory" ;;
    *)
      echo "Unexpected target: $target. Does it exist in Makefile?"
      exit 2
      ;;
  esac
}

# Function to add the WITHMOCK=1 environment variable to the tests that span mocked dependencies
# Some services depend on other services, so if no_mock profile is not used, we set WITHMOCK=1 by default
with_mocked_dependencies() {
  [[ -n "$1" ]] && echo "" || echo "WITHMOCK=1 "
}

# Function to add the no-mock profile if specified by the user
with_no_mock() {
  [[ -n "$1" ]] && echo "--profile no-mock" || echo ""
}

copy_go_executable() {
  local cid="$1"
  local path_to_service="$2"
  local executable_name="$3"
  # shellcheck disable=SC2016
  "$CONTAINER_TOOL" cp "$path_to_service/$executable_name" "$cid:$("$CONTAINER_TOOL" exec "$cid" bash -c 'echo "$VIRTUAL_ENV_BIN"')"
  "$CONTAINER_TOOL" exec -u root "$cid" /bin/bash -c "chmod +x \$VIRTUAL_ENV_BIN/$executable_name"
}

copy_python_project() {
  local cid="$1"
  local path_to_service="$2"
  "$CONTAINER_TOOL" cp "$path_to_service" "$cid:/."
  # service will be pip-installed and executed, so user will need write and exec permissions
  "$CONTAINER_TOOL" exec -u root "$cid" /bin/bash -c "chmod -R 777 /$(basename "$path_to_service")"
}

copy_openapi_spec() {
  local cid="$1"
  local path_to_service="$2"
  "$CONTAINER_TOOL" cp "$path_to_service/openapi.json" "$REMOTE_PATH_FOR_SERVICE"
}

# Function to copy files based on the make target
copy_files() {
  local cid="$1"
  local target="$2"
  local path_to_service="$3"

  case "$target" in
    "aggregator-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-aggregator"
      "$CONTAINER_TOOL" cp "$path_to_service/openapi.json" "$REMOTE_PATH_FOR_SERVICE"
      ;;
    "aggregator-mock-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-aggregator-mock"
      "$CONTAINER_TOOL" cp "$path_to_service" "$REMOTE_PATH_FOR_SERVICE/mock_server"
      ;;
    "cleaner-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-aggregator-cleaner"
      ;;
    "data-engineering-service-tests")
      copy_python_project "$cid" "$path_to_service"
      ;;
    "dvo-extractor-tests")
      copy_python_project "$cid" "$path_to_service"
      ;;
    "dvo-writer-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-aggregator"
      copy_openapi_spec "$cid" "$path_to_service"
      ;;
    "exporter-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-aggregator-exporter"
      ;;
    "inference-service-tests")
      copy_python_project "$cid" "$path_to_service"
      ;;
    "insights-content-service-tests")
      echo -e "\033[33mWARNING! Content service should include test-rules for these tests to run properly.\033[0m"
      echo -e "\033[33mPlease build using './build.sh --test-rules-only' or './build.sh --include-test-rules'\033[0m"
      "$CONTAINER_TOOL" cp "$path_to_service" "$REMOTE_PATH_FOR_SERVICE"
      ;;
    "insights-content-template-renderer-tests")
      copy_python_project "$cid" "$path_to_service"
      ;;
    "insights-sha-extractor-tests")
      copy_python_project "$cid" "$path_to_service"
      ;;
    "notification-service-tests")
      copy_go_executable "$cid" "$path_to_service" "ccx-notification-service"
      ;;
    "notification-writer-tests")
      copy_go_executable "$cid" "$path_to_service" "ccx-notification-writer"
      ;;
    "smart-proxy-tests")
      copy_go_executable "$cid" "$path_to_service" "insights-results-smart-proxy"
      ;;
    "parquet-factory-tests")
      copy_go_executable "$cid" "$path_to_service" "parquet-factory"
      "$CONTAINER_TOOL" cp "$path_to_service"/config.toml "$REMOTE_PATH_FOR_SERVICE"
      ;;
    *)
      echo "Unexpected target: $target. Does it exist in Makefile?"
      exit 2
      ;;
  esac
}

# Step 1: Specify the make target for tests to run
tests_target="$1"

# Step 2: Specify the path to the compiled executable or or Python service
path_to_service=$(realpath "$2")

# Step 3: Start the Docker containers with Docker Compose
if [[ "$tests_target" == *"notification"* ]]; then
  db_name="notification"
else
  db_name="test"
fi

# Step 4: Launch containers
# shellcheck disable=SC2046
POSTGRES_DB_NAME="$db_name" "$CONTAINER_TOOL compose" $(with_profile "$1") $(with_no_mock "$3") up -d

# Step 5: Find the container ID of the insights-behavioral-spec container
cid=$("$CONTAINER_TOOL" ps | grep 'insights-behavioral-spec:latest' | cut -d ' ' -f 1)

# Step 6: Copy the executable and needed dependencies or Python service into the container
# TODO: Discuss including archives in compiled Go executables for testing
copy_files "$cid" "$tests_target" "$path_to_service"

# Step 7: Execute the specified make target
"$CONTAINER_TOOL" exec "$cid" /bin/bash -c "source \$VIRTUAL_ENV/bin/activate && env && $(with_mocked_dependencies "$3") make $tests_target"
