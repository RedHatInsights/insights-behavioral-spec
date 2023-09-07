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

from csv_checks import check_table_content

class Table:

        """Mock for real table class from Behave."""

        def __init__(self):
            """Initialize Table instance."""
            self.headings = ["column1", "column2"]
            self.data = [{"column1": "column1 data",
                          "column2": "column2 data"}]

        def __iter__(self):
            return iter(self.data)


class Context:

        """Mock for real context class from Behave."""

        def __init__(self):
            """Initialize table attribute to be the same as in Behave.Context."""
            self.table = Table()


def test_check_table_context_none_buffer():
    """Test if the function check_table_content checks if buffer is None."""
    
    context = Context()
    with pytest.raises(AssertionError):
        check_table_content(context, None, "filename", "column")


def test_check_table_context_empty_csv():
    """Test if the function check_table_content checks if CSV is empty."""
    context = Context()

    # totally empty CSV
    buff = iter([])

    # it is expected that StopIteration will be raised because there's no header in CSV file
    with pytest.raises(StopIteration):
        check_table_content(context, buff, "filename", 0)


def test_check_table_context_empty_csv_no_headers():
    """Test if the function check_table_content checks if CSV is empty and header are disabled."""
    context = Context()

    # totally empty CSV
    buff = iter([])

    # it is NOT expected that StopIteration will be raised
    check_table_content(context, buff, "filename", 0, headers=False)


def test_check_table_context_csv_with_just_header():
    """Test if the function check_table_content check if CSV contains just column headers."""
    context = Context()

    # simple CSV with just column headers
    buff = iter(['"column1 header","column2 header"'])

    check_table_content(context, buff, "filename", "column")


def test_check_table_context_csv_with_data():
    """Test if the function check_table_content read and process CSV data."""
    context = Context()

    # simple CSV with just column headers
    buff = iter(['"column1","column2"', '"column1 data","column2 data"'])

    check_table_content(context, buff, "filename", 0)


def test_check_table_context_csv_multi_column_data():
    """Test if the function check_table_content read and process CSV data."""
    context = Context()

    # simple CSV with just column headers
    buff = iter(['"column1","column2"', '"column1 data","column2 data"'])

    check_table_content(context, buff, "filename", 0, column2=1)
