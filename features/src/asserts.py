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

from typing import Any, Set


def assert_sets_equality(what: str, expected: Set[Any], actual: Set[Any]) -> None:
    """Compare two sets of values, displays correct set difference when inequal."""
    assert expected == actual, f"Difference found in sets of {what}: {expected ^ actual}"
