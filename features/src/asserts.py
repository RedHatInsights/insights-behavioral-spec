# Copyright © 2023 Pavel Tisnovsky, Red Hat, Inc.
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

"""Custom asserts that can be imported into other source files and steps definitions."""


def assert_sets_equality(what, expected, actual):
    """Compare two sets of values, displays correct set difference when inequal."""
    assert expected == actual, "Difference found in sets of {}: {}".format(
        what, expected ^ actual
    )


if __name__ == "__main__":
    # just check the function to compare to sets
    assert_sets_equality("something", set(), set())
    assert_sets_equality("something", {1}, {1})
    assert_sets_equality("something", {1, 2}, {1, 2})
    assert_sets_equality("something", {1, 2}, {2, 1})

    try:
        assert_sets_equality("something", {1, 2}, {2})
    except AssertionError as e:
        print(e)

    try:
        assert_sets_equality("something", {1, 2}, {2, 3})
    except AssertionError as e:
        print(e)

    try:
        assert_sets_equality("something", set(), {1})
    except AssertionError as e:
        print(e)

    try:
        assert_sets_equality("something", set(), {1, 2})
    except AssertionError as e:
        print(e)
