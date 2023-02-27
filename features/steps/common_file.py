# Copyright © 2023  Pavel Tisnovsky, Red Hat, Inc.
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

"""Implementation of common test steps that handles file contents."""

from behave import given, then, when


@then("I should see following messages written into file {filename}")
def check_file_content(context, filename):
    """Check content (messages) written into specified file."""
    expected_content = context.text.strip()

    # read whole file
    with open(filename, "r") as fin:
        actual_content = fin.read().strip()

    assert expected_content == actual_content, \
        f"Content does not match:\nexpected:\n{expected_content}\n---\nactual:\n{actual_content}"
