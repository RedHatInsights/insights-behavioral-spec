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

"""Unit tests for functions defined in utils.py source file."""

import pytest
from process_output import filter_coverage_message


inputs_and_outputs = (
       # input                                                               expected output
       ("",                                                                  ""),
       ("\n",                                                                "\n"),
       ("foo bar baz\n",                                                     "foo bar baz\n"),
       ("foo\nbar\nbaz\n",                                                   "foo\nbar\nbaz\n"),
       ("nwarning: GOCOVERDIR not set, no coverage data emitted",            ""),
       ("foo\nwarning: GOCOVERDIR not set, no coverage data emitted\nbaz\n", "foo\nbaz\n"),
)


@pytest.mark.parametrize("inputs_and_outputs", inputs_and_outputs)
def test_filter_coverage_message(inputs_and_outputs):
    # retrieve test data from parametrized input
    message = inputs_and_outputs[0]
    expected = inputs_and_outputs[1]
