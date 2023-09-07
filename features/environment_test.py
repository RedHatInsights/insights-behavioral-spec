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

