# Copyright © 2022, 2023 Pavel Tisnovsky, Red Hat, Inc.
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

"""SQL-related helper functions."""


def construct_insert_statement(table_name, headings):
    """Construct INSERT statement from specified table name and column headings."""
    # preliminary checks
    assert table_name, "Table name must be specified and should not be empty string"
    assert headings is not None, "Column headings needs to be specified"
    assert len(headings) > 0, "At least one column name needs to be specified"

    # just check that resulting INSERT will have proper syntax
    for heading in headings:
        assert heading, "Column heading should not be empty"

    template = "INSERT into {table_name} ({column_names}) VALUES ({placeholders})"

    # list of columns that will be put into parenthesis in resulting INSERT statement
    # before VALUES clausule
    column_names = ", ".join(headings)

    # list of placeholders that will be put into parenthesis in resulting INSERT statement
    # after VALUES clausule
    placeholder_marks = ("%s",) * len(headings)
    placeholders = ", ".join(placeholder_marks)

    # apply template
    return template.format(
        table_name=table_name, column_names=column_names, placeholders=placeholders
    )


if __name__ == "__main__":
    # just check the function to construct INSERT statement
    print(construct_insert_statement("table1", ["foo", "bar", "baz"]))
    print(construct_insert_statement("table1", ["foo"]))

    try:
        print(construct_insert_statement("table1", ["foo", "", "baz"]))
    except AssertionError as e:
        print(e)

    try:
        print(construct_insert_statement("table1", ["", "", ""]))
    except AssertionError as e:
        print(e)

    try:
        print(construct_insert_statement("table1", []))
    except AssertionError as e:
        print(e)

    try:
        print(construct_insert_statement("", ["foo", "bar", "baz"]))
    except AssertionError as e:
        print(e)
