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

"""Unit tests for functions defined in jps.py source file."""

import pytest


# this is ugly hack, but we need to update include/import path
# we need to do this hack before importing jps
import sys
import os
sys.path.append(os.path.realpath(os.path.dirname(__file__)))

from jps import find_jvm_application, get_all_jvm_based_applications  # noqa E402


def test_find_jvm_application_positive_case():
    """Test for function find_jvm_application."""
    class Context:
        def __init__(self):
            self.output = None
            self.stdout = None
            self.stderr = None

    # mock the context
    context = Context()
    context.output = ["21088 sun.tools.jps.Jps"]

    # check the expected output
    find_jvm_application(context, "sun.tools.jps.Jps")

    with pytest.raises(AssertionError):
        find_jvm_application(context, "this.does.not.run")


def test_find_jvm_application_negative_case():
    """Test for function find_jvm_application."""
    class Context:
        def __init__(self):
            self.output = None
            self.stdout = None
            self.stderr = None

    # mock the context
    context = Context()
    context.output = ["21088 sun.tools.jps.Jps"]

    with pytest.raises(AssertionError):
        find_jvm_application(context, "this.does.not.run")


def test_get_all_jvm_based_application():
    """Test for function get_all_jvm_based_applications."""
    class Context:
        def __init__(self):
            self.output = None
            self.stdout = None
            self.stderr = None

    context = Context()
    get_all_jvm_based_applications(context)

    assert context.output is not None
    assert context.stdout is not None
    assert context.stderr is None

    find_jvm_application(context, "sun.tools.jps.Jps")
