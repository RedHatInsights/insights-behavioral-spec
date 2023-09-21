#!/bin/bash -x

# This script assumes that a Go service is already built, and the Python service can be interpreted without errors
#
# Step 1: Define a map of makefile targets to corresponding profiles and a map of files to copy in the DBB container for each target
declare -A docker_compose_profiles

docker_compose_profiles["cleaner-tests"]=""
docker_compose_profiles["aggregator-tests"]="test-aggregator"
docker_compose_profiles["aggregator-mock-tests"]=""
docker_compose_profiles["exporter-tests"]="test-exporter"
docker_compose_profiles["notification-service-tests"]="test-notification-services"
docker_compose_profiles["notification-writer-tests"]="test-notification-services"
docker_compose_profiles["inference-service-tests"]=""
docker_compose_profiles["data-engineering-service-tests"]="test-upgrades-data-eng"
docker_compose_profiles["insights-content-service-tests"]=""
docker_compose_profiles["insights-content-template-renderer-tests"]=""
docker_compose_profiles["insights-sha-extractor-tests"]=""
docker_compose_profiles["smart-proxy-tests"]=""

# Function to get docker compose profile to add based on service name specified by the user
with_profile() {
  local profile="${docker_compose_profiles[$1]}"
  [[ -n "$profile" ]] && echo "--profile $profile" || echo ""
}

# Function to add the no-mock profile if specified by the user
with_no_mock() {
  [[ -n "$1" ]] && echo "--profile no-mock" || echo ""
}

# Function to copy files based on the make target
copy_files() {
  local cid="$1"
  local target="$2"
  local path_to_service="$3"

  case "$target" in
    "aggregator-tests")
      executable_name="insights-results-aggregator"
      docker cp "$path_to_service/$executable_name" "$cid:$(docker exec $cid bash -c 'echo "$VIRTUAL_ENV_BIN"')"
      docker exec -u root "$cid" /bin/bash -c "chmod +x \$VIRTUAL_ENV_BIN/$executable_name"
      docker cp "$path_to_service/openapi.json" "$cid":$(docker exec "$cid" bash -c 'echo "$HOME"')
      ;;
    "cleaner-tests")
      # Copy files for other-target
      executable_name="insights-results-aggregator-cleaner"
      docker cp "$path_to_service/$executable_name" "$cid:$(docker exec $cid bash -c 'echo "$VIRTUAL_ENV_BIN"')"
      docker exec -u root "$cid" /bin/bash -c "chmod +x \$VIRTUAL_ENV_BIN/$executable_name"
      ;;
    *)
      echo "No specific files to copy for target: $target"
      ;;
  esac
}
# Step 2: Specify the make target for tests to run
tests_target="$1"

# Step 3: Specify the path to the compiled executable or or Python service
path_to_service=$(realpath "$2")

# Step 4: Start the Docker containers with Docker Compose
test_profile=$(with_profile "$1")
echo "profile -- $test_profile"
POSTGRES_DB_NAME=test docker-compose $(with_profile "$1") $(with_no_mock "$3") up -d

# Step 5: Find the container ID of the insights-behavioral-spec container
cid=$(docker ps | grep 'insights-behavioral-spec:latest' | cut -d ' ' -f 1)

# Step 6: Copy the executable and needed dependencies or Python service into the container
# TODO: Discuss including archives in compiled Go executables for testing
copy_files "$cid" "$tests_target" "$path_to_service"

# Step 9: Execute the specified make target
docker exec -it "$cid" /bin/bash -c "env && make $tests_target"

