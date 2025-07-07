# Copyright © 2024 Jiri Papousek, Pavel Tisnovsky, Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Implementation of step for loading service configuration."""

import toml
import yaml
from behave import given
from kafka.cluster import ClusterMetadata

SERVICE_CONFIGS = {
    "SHA extractor": "insights_sha_extractor.yaml",
    "SHA extractor (compressed)": "insights_sha_extractor_compressed.yaml",
    "DVO extractor": "dvo_extractor.yaml",
    "DVO writer": "dvo_writer_docker_env.toml",
}


@given("Kafka broker is started on host and port specified in {service} configuration")
def kafka_broker_running(context, service):
    """Check if the configuration is valid and Kafka broker is running."""
    config = None
    config_name = f"config/{SERVICE_CONFIGS[service]}"

    with open(config_name, "r") as file:
        if config_name.endswith(".yaml"):
            config = yaml.safe_load(file)
            hostname = config["service"]["consumer"]["kwargs"]["bootstrap.servers"]
        else:
            config = toml.load(file)
            hostname = config["broker"]["addresses"]

    context.service_config = config
    context.hostname = hostname
    context.kafka_hostname = hostname.split(":")[0]
    context.kafka_port = hostname.split(":")[1]

    metadata = ClusterMetadata(bootstrap_servers=hostname)
    context.metadata = metadata
    assert len(metadata.brokers()) > 0
