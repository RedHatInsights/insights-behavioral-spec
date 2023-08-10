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

"""Unit tests for functions defined in asserts.py source file."""

import pytest
from asserts import assert_sets_equality


def test_asserts_sets_equality_equal_sets():
    """Test the behaviour or assert_sets_equality function for equal sets."""
    # equal sets
    assert_sets_equality("something", set(), set())
    assert_sets_equality("something", {1}, {1})
    assert_sets_equality("something", {1, 2}, {1, 2})
    assert_sets_equality("something", {1, 2}, {2, 1})
    assert_sets_equality("something", {1, 2, 3}, {3, 2, 1})


sets = (
        {2},
        {2, 3},
        {1, 3},
        {1, 2, 3},
)

@pytest.mark.parametrize("second_set", sets)
def test_asserts_sets_equality_inequal_sets(second_set):
    """Test the behaviour or assert_sets_equality function for inequal sets."""
    # inequal sets
    # exception is expected in such cases
    with pytest.raises(AssertionError):
        assert_sets_equality("something", {1, 2}, second_set)


@pytest.mark.parametrize("second_set", sets)
def test_asserts_sets_equality_empty_set(second_set):
    """Test the behaviour or assert_sets_equality function for inequal sets (one is empty)."""
    # inequal sets - one is empty
    # exception is expected in such cases
    with pytest.raises(AssertionError):
        assert_sets_equality("something", set(), second_set)
