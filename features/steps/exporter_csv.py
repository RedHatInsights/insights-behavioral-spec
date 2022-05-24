# Copyright © 2022 Pavel Tisnovsky, Red Hat, Inc.
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

"""Implementation of test steps that run Insights Aggregator Exporter and check its output."""

from os.path import exists
import csv


@then(u"I should see following number of records stored in CSV files")
def number_of_records_in_csv(context):
    """Check if number of records stored in CSV files match expected number."""
    # iterate over all items in feature table
    for row in context.table:
        filename = row["File name"]
        expected_records = int(row["Records"])

        # we need to make sure the CSV is readable
        with open(filename, "r") as fin:
            csvFile = csv.reader(fin)
            # skip the first row of the CSV file.
            next(csvFile)

            stored_records = 0
            for lines in csvFile:
                stored_records += 1

        # now check numbers
        assert (
            expected_records == stored_records
        ), "Expected number records in file {} is {} but {} was read".format(
            filename, expected_records, stored_records
        )


@then(u"I should see following records in exported file {filename} placed in column {column:d}")
def check_records_in_csv(context, filename, column):
    """Check if all records are really stored in given CSV file."""
    with open(filename, "r") as fin:
        csvFile = csv.reader(fin)
        # skip the first row of the CSV file.
        next(csvFile)

        for line in csvFile:
            found = False
            # iterate over all records that needs to be stored in CSV
            for row in context.table:
                record = row["Record"]

                # check if selected column contains the expected record
                if line[column] == record:
                    found = True
                    break

            assert found, "Record {} not found in CSV file {}".format(record, line[1])
