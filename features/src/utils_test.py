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
from utils import retrieve_set_of_clusters_from_table

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
