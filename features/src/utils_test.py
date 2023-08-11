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
from utils import get_array_from_json, construct_rh_token, retrieve_set_of_clusters_from_table

inputs_and_outputs = (
        # input                        expected output           comment
        ([],                           set()),                 # empty set
        (["foo"],                      {"foo"}),               # set with one item
        (["foo", "bar", "baz"],        {"foo", "bar", "baz"}), # unique items
        (["baz", "bar", "foo"],        {"foo", "bar", "baz"}), # order does not matter
        (["foo", "bar", "baz", "foo"], {"foo", "bar", "baz"}), # non-unique items
        (["foo", "foo", "foo", "foo"], {"foo"}),               # non-unique items
)


@pytest.mark.parametrize("inputs_and_outputs", inputs_and_outputs)
def test_retrieve_list_of_clusters(inputs_and_outputs):
    # just check the function to retrieve set of clusters from table
    class Context:

        """Mock for real context class from Behave."""

        def __init__(self, items):
            """Initialize table attribute to be the same as in Behave.Context."""
            self.table = [{"Cluster name": item} for item in items]

    # retrieve test data from parametrized input
    context_table_content = inputs_and_outputs[0]
    expected_set = inputs_and_outputs[1]

    # prepare mocked class
    context = Context(context_table_content)

    # and check the tested function behaviour
    assert retrieve_set_of_clusters_from_table(context) == expected_set
