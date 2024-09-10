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

"""Unit tests for functions defined in sql.py source file."""

import pytest
from sql import construct_insert_statement

inputs_and_outputs = (
        # input                  expected output
        (["foo"],                "INSERT into table1 (foo) VALUES (%s)"),
        (["foo", "bar"],         "INSERT into table1 (foo, bar) VALUES (%s, %s)"),
        (["foo", "bar", "baz"],  "INSERT into table1 (foo, bar, baz) VALUES (%s, %s, %s)"),
)

wrong_inputs = (
        [""],
        ["foo", "", "baz"],
        ["", "", ""],
)


@pytest.mark.parametrize("inputs_and_outputs", inputs_and_outputs)
def test_construct_insert_statement_proper_input(inputs_and_outputs):
    """Check the behaviour of construct_insert_statement function for correct input."""
    # retrieve test data from parametrized input
    columns = inputs_and_outputs[0]
    expected_statement = inputs_and_outputs[1]

    # check the tested function behaviour
    assert construct_insert_statement("table1", columns) == expected_statement


@pytest.mark.parametrize("wrong_input", wrong_inputs)
def test_construct_insert_statement_improper_input(wrong_input):
    """Check the behaviour of construct_insert_statement function for incorrect input."""
    # exception is expected in such cases
    with pytest.raises(AssertionError):
        construct_insert_statement("table1", wrong_input)


def test_construct_insert_statement_improper_table_name():
    """Check the behaviour of construct_insert_statement function for improper table name."""
    # exception is expected in such cases
    with pytest.raises(AssertionError):
        construct_insert_statement("", ["foo", "bar", "baz"])
