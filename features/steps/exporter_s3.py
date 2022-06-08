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

"""Implementation of test steps that check or access S3/Minio service."""

from src.minio import minio_client, bucket_check, read_object_into_buffer
import csv


@given(u"Minio endpoint is set to {endpoint}")
def set_minio_endpoing(context, endpoint):
    """Set Minio endpoint value."""
    assert endpoint is not None, "Endpoint needs to be specified"
    context.minio_endpoint = endpoint


@given(u"Minio port is set to {port:d}")
def set_minio_port(context, port):
    """Set Minio port value."""
    context.minio_port = port


@given(u"Minio access key is set to {value}")
def set_minio_access_key(context, value):
    """Set Minio access key."""
    assert value is not None, "Access key needs to be specified"
    context.minio_access_key = value


@given(u"Minio secret access key is set to {value}")
def set_minio_secret_access_key(context, value):
    """Set Minio secret access key."""
    assert value is not None, "Secret access key needs to be specified"
    context.minio_secret_access_key = value


@given(u"Minio bucket name is set to {value}")
def set_minio_bucket_name(context, value):
    """Set Minio bucket name."""
    assert value is not None, "Bucket name needs to be specified"
    context.minio_bucket_name = value


@then(u"I should see following objects generated in S3")
def check_objects_in_s3(context):
    """Check that all specified objects was generated."""
    # construct new Minio client
    client = minio_client(context)

    # check if bucket used by exporter exists
    bucket_check(context, client)

    # retrieve all objects stored in bucket
    objects = client.list_objects(context.minio_bucket_name, recursive=False)

    # retrieve object names only
    names = [o.object_name for o in objects]

    # iterate over all items in feature table
    for row in context.table:
        object_name = row["File name"]
        assert object_name in names, \
            "Can not find object {} in bucket {}".format(object_name, context.minio_bucket_name)


@then(u"I should see following number of records stored in CSV objects in S3")
def check_csv_content_in_s3(context):
    """Check content of objects stored in S3."""
    # construct new Minio client
    client = minio_client(context)

    # check if bucket used by exporter exists
    bucket_check(context, client)

    # iterate over all items in feature table
    for row in context.table:
        object_name = row["File name"]
        expected_records = int(row["Records"])

        # read object content
        buff = read_object_into_buffer(context, client, object_name)

        # read CVS from buffer
        csvFile = csv.reader(buff)

        # skip the first row of the CSV file.
        next(csvFile)

        stored_records = 0
        for lines in csvFile:
            stored_records += 1

        # now check numbers
        assert (
            expected_records == stored_records
        ), "Expected number records in object {} is {} but {} was read".format(
            object_name, expected_records, stored_records
        )


@then(u"I should see following records in exported object {object_name} placed in column {column:d}") # noqa: E501
@then(u"I should see following records in exported object {object_name} placed in columns {column:d} and {column2:d}")   # noqa: E501
def check_records_in_csv_object(context, object_name, column, column2=None):
    """Check if all records are really stored in given CSV file/object in S3/Minio."""
    # construct new Minio client
    client = minio_client(context)

    # read object content
    buff = read_object_into_buffer(context, client, object_name)

    # read CVS from buffer
    csvFile = csv.reader(buff)

    # skip the first row of the CSV file.
    next(csvFile)

    for line in csvFile:
        found = False
        # iterate over all records that needs to be stored in CSV
        for row in context.table:
            if column2 is None:
                # one column case
                record = row[context.table.headings[0]]

                # check if selected column contains the expected record
                if line[column] == record:
                    found = True
                    break
            else:
                # two columns case
                record1 = row[context.table.headings[0]]
                record2 = row[context.table.headings[1]]

                # check if selected column contains the expected record
                if line[column] == record1 and line[column2] == record2:
                    found = True
                    break

        if column2 is None:
            assert found, "Record {} not found in CSV file {}".format(record, line[1])
        else:
            assert found, "Record {} not found in CSV file {}".format([record1, record2], line)
