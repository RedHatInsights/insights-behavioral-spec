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
import base64
from utils import retrieve_set_of_clusters_from_table, construct_rh_token, get_array_from_json
from utils import find_block

inputs_and_outputs = (
        # input                        expected output            comment
        ([],                           set()),                  # empty set
        (["foo"],                      {"foo"}),                # set with one item
        (["foo", "bar", "baz"],        {"foo", "bar", "baz"}),  # unique items
        (["baz", "bar", "foo"],        {"foo", "bar", "baz"}),  # order does not matter
        (["foo", "bar", "baz", "foo"], {"foo", "bar", "baz"}),  # non-unique items
        (["foo", "foo", "foo", "foo"], {"foo"}),                # non-unique items
)


@pytest.mark.parametrize("inputs_and_outputs", inputs_and_outputs)
def test_retrieve_list_of_clusters(inputs_and_outputs):
    """Check the behaviour of function to retrieve set of clusters from context table."""
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


def test_get_array_from_json():
    """Test the function get_array_from_json."""
    class Context:

        """Mock for real context class from Behave."""

        def __init__(self, items):
            """Initialize response attribute to be the same as in Behave.Context."""
            class Response:
                def __init__(self, items):
                    self._items = items

                def json(self):
                    return {"foo": self._items}

            # dictionary having some array
            self.response = Response(items)

    # scenario without subselector
    context = Context([1, 2, 3])
    array = get_array_from_json(context, "foo", None)
    assert array == [1, 2, 3]

    # scenario with unknown subselector
    with pytest.raises(AssertionError):
        context = Context([1, 2, 3])
        get_array_from_json(context, "this-does-not-exists", None)

    # scenario with subselector
    context = Context([{"bar": 1}, {"bar": 2}, {"bar": 3}])
    array = get_array_from_json(context, "foo", "bar")
    assert list(array) == [1, 2, 3]


def test_construct_rh_token_positive_test_case():
    """Test the function construct_rh_token."""
    token = construct_rh_token(42, "ACCOUNT", "USER")
    assert token is not None

    # try to decode token
    decoded = base64.b64decode(token)
    assert decoded is not None
    assert isinstance(decoded, bytes)

    # convert it from bytes to string
    text = decoded.decode("ascii")
    assert text is not None
    assert isinstance(text, str)

    # and check the actual token content
    assert text == """
    {
        "identity": {
            "org_id": "42",
            "account_number":"ACCOUNT",
            "user": {
                "user_id":"USER"
            }
        }
    }
    """


def test_construct_rh_token_negative_org_id():
    """Test the function construct_rh_token when negative organization ID is used."""
    with pytest.raises(AssertionError):
        construct_rh_token(-42, "ACCOUNT", "USER")


def test_construct_rh_token_missing_account_number():
    """Test the function construct_rh_token when no account number is provided."""
    with pytest.raises(AssertionError):
        construct_rh_token(42, "", "USER")


def test_construct_rh_token_missing_user_id():
    """Test the function construct_rh_token when no user ID is provided."""
    with pytest.raises(AssertionError):
        construct_rh_token(42, "ACCOUNT", "")


def test_find_block_positive_cases():
    """Test the function find_block."""
    i = find_block(["foo", "bar", "baz"], "foo")
    assert i == 0

    i = find_block(["foo", "bar", "baz"], "bar")
    assert i == 1


def test_find_block_negative_case():
    """Test the function find_block."""
    with pytest.raises(Exception):
        i = find_block(["foo", "bar", "baz"], "dunno")
