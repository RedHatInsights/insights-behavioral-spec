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

"""CSV-related code."""

import csv
from behave.runner import Context


def check_table_content(context: Context, buff, filename, column, column2=None, headers=True):
    """Check if CSV file or CSV object contains records specified in test context."""
    # CSV file object
    csvFile = csv.reader(buff)

    # skip the first row of the CSV file when we know in advance it contains column headers
    if headers:
        next(csvFile)

    # process rest of CSV file (without optinal header line)
    for line in csvFile:
        found = False
        # iterate over all records that needs to be stored in CSV
        for row in context.table:
            if column2 is None:
                # one column case
                record = row[context.table.headings[0]]

                # check if selected column contains the expected record
                if line[column] == record:
                    # we found the record -> we are done
                    found = True
                    break
            else:
                # two columns case
                record1 = row[context.table.headings[0]]
                record2 = row[context.table.headings[1]]

                # check if selected column contains the expected record
                if line[column] == record1 and line[column2] == record2:
                    # we found the record -> we are done
                    found = True
                    break

        if column2 is None:
            assert found, "Record {} not found in CSV file {}".format(record, filename)
        else:
            assert found, "Record {} not found in CSV file {}".format(
                [record1, record2], line
            )
