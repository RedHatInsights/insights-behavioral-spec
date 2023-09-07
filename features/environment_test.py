#!/usr/bin/env python3
# vim: set fileencoding=utf-8

# Copyright © 2023  Pavel Tisnovsky
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

"""Unit tests for functions defined in environment.py source file."""

import os
from environment import before_all, setup_default_kafka_context, setup_default_S3_context


class Context:

    """Mock for real context class from Behave."""

    def __init__(self):
        """Initialize all required attributes."""
        self.database_host = None
        self.database_port = None
        self.database_name = None
        self.database_user = None
        self.database_password = None
        self.local = None
        self.S3_type = None
        self.S3_endpoint = None
        self.S3_port = None
        self.S3_access_key = None
        self.S3_secret_access_key = None
        self.S3_bucket_name = None
        self.S3_old_minio_compatibility = None
        self.kafka_hostname = None
        self.kafka_port = None


def test_before_all_no_variables():
    """Test the function before_all when no relevant environment variables are set."""
    os.unsetenv("DB_HOST")
    os.unsetenv("DB_PORT")
    os.unsetenv("DB_NAME")
    os.unsetenv("DB_USER")
    os.unsetenv("DB_PASS")
    os.unsetenv("ENV_DOCKER")

    context = Context()
    before_all(context)

    assert context.database_host == "localhost"
    assert context.database_port == 5432
    assert context.database_name == "test"
    assert context.database_user == "postgres"
    assert context.database_password == "postgres"
    assert context.local


def test_before_all_set_variables():
    """Test the function before_all when all relevant environment variables are set."""
    os.environ["DB_HOST"] = "*host"
    os.environ["DB_PORT"] = "*port"
    os.environ["DB_NAME"] = "*name"
    os.environ["DB_USER"] = "*user"
    os.environ["DB_PASS"] = "*pass"
    os.environ["ENV_DOCKER"] = "0"

    context = Context()
    before_all(context)

    assert context.database_host == "*host"
    assert context.database_port == "*port"
    assert context.database_name == "*name"
    assert context.database_user == "*user"
    assert context.database_password == "*pass"
    assert context.local


def test_setup_default_kafka_context_no_variables():
    """Test the function setup_default_kafka_context."""
    os.unsetenv("KAFKA_HOST")
    os.unsetenv("KAFKA_PORT")

    context = Context()
    setup_default_kafka_context(context)

    assert context.kafka_hostname == "localhost"
    assert context.kafka_port == "9092"


def test_setup_default_kafka_context_set_variables():
    """Test the function setup_default_kafka_context."""
    os.environ["KAFKA_HOST"] = "*host"
    os.environ["KAFKA_PORT"] = "*port"

    context = Context()
    setup_default_kafka_context(context)

    assert context.kafka_hostname == "*host"
    assert context.kafka_port == "*port"


def test_setup_default_S3_context_no_variables():
    """Test the function setup_default_S3_context."""
    os.unsetenv("S3_TYPE")
    os.unsetenv("S3_HOST")
    os.unsetenv("S3_PORT")
    os.unsetenv("S3_ACCESS_KEY_ID")
    os.unsetenv("S3_SECRET_ACCESS_KEY")
    os.unsetenv("S3_BUCKET")
    os.unsetenv("S3_OLDER_MINIO_COMPATIBILITY")

    context = Context()
    setup_default_S3_context(context)

    assert context.S3_type == "minio"
    assert context.S3_endpoint == "localhost"
    assert context.S3_port == "9000"
    assert context.S3_access_key == "test_access_key"
    assert context.S3_secret_access_key == "test_secret_access_key"
    assert context.S3_bucket_name == "test"
    assert context.S3_old_minio_compatibility is None


def test_setup_default_S3_context_set_variables():
    """Test the function setup_default_S3_context."""
    os.environ["S3_TYPE"] = "*type"
    os.environ["S3_HOST"] = "*host"
    os.environ["S3_PORT"] = "*port"
    os.environ["S3_ACCESS_KEY_ID"] = "*access_key"
    os.environ["S3_SECRET_ACCESS_KEY"] = "*secret_access_key"
    os.environ["S3_BUCKET"] = "*bucket"
    os.environ["S3_OLDER_MINIO_COMPATIBILITY"] = "true"

    context = Context()
    setup_default_S3_context(context)

    assert context.S3_type == "*type"
    assert context.S3_endpoint == "*host"
    assert context.S3_port == "*port"
    assert context.S3_access_key == "*access_key"
    assert context.S3_secret_access_key == "*secret_access_key"
    assert context.S3_bucket_name == "*bucket"
    assert context.S3_old_minio_compatibility == "true"
