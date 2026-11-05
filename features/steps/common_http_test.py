#!/usr/bin/env python3

# Copyright © 2026 Red Hat, Inc.
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

"""Unit tests for HTTP schema validation step in common_http.py."""

import json
import os
import sys
from unittest.mock import MagicMock

import pytest

# same path hack as jps_test.py
# needed so Python can import common_http and its src.utils
_STEPS_DIR = os.path.realpath(os.path.dirname(__file__))
_FEATURES_DIR = os.path.realpath(os.path.join(_STEPS_DIR, ".."))
sys.path.append(_STEPS_DIR)
sys.path.append(_FEATURES_DIR)

from common_http import check_response_body_schema  # noqa: E402


def test_check_response_body_schema_accepts_valid_body():
    """Valid response body must pass the schema step."""
    schema = {
        "type": "object",
        "required": ["answer"],
        "properties": {"answer": {"type": "integer"}},
        "additionalProperties": False,
    }
    body = {"answer": 42}

    context = MagicMock()
    context.text = json.dumps(schema)
    context.response.json.return_value = body

    check_response_body_schema(context)  # must not raise


def test_check_response_body_schema_rejects_invalid_body():
    """Invalid response body must fail the schema step (guards swapped validate_json args)."""
    schema = {
        "type": "object",
        "required": ["answer"],
        "properties": {"answer": {"type": "integer"}},
        "additionalProperties": False,
    }
    body = {"answer": "not-an-integer"}

    context = MagicMock()
    context.text = json.dumps(schema)
    context.response.json.return_value = body

    with pytest.raises(AssertionError):
        check_response_body_schema(context)
