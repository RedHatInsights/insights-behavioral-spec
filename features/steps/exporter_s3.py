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

"""Implementation of test steps that check or access S3/S3 service."""


import csv
from behave import given, then
from src.csv_checks import check_table_content
from src.minio import (
    bucket_check,
    clean_bucket,
    create_bucket,
    get_object_name,
    minio_client,
    read_object_into_buffer,
)


@given("S3 endpoint is set")
def assert_s3_endpoint_is_set(context):
    """Set S3 endpoint value."""
    assert context.S3_endpoint is not None, "S3 endpoint not found in context"


@given("S3 endpoint is set to {endpoint}")
def set_s3_endpoint(context, endpoint):
    """Set S3 endpoint value."""
    assert endpoint is not None, "Endpoint needs to be specified"
    context.S3_endpoint = endpoint


@given("S3 port is set")
def assert_s3_port_is_set(context):
    """Set S3 port value."""
    assert context.S3_port is not None, "S3 port not found in context"


@given("S3 port is set to {port:d}")
def set_s3_port(context, port):
    """Set S3 port value."""
    context.S3_port = port


@given("S3 access key is set")
def assert_s3_access_key_is_set(context):
    """Set S3 access key."""
    assert context.S3_access_key is not None, "S3 Access key not found in context"


@given("S3 access key is set to {value}")
def set_s3_access_key(context, value):
    """Set S3 access key."""
    assert value is not None, "Access key needs to be specified"
    context.S3_access_key = value


@given("S3 secret access key is set")
def assert_s3_secret_access_key_is_set(context):
    """Set S3 secret access key."""
    assert (
        context.S3_secret_access_key is not None
    ), "S3 Secret access key not found in context"


@given("S3 secret access key is set to {value}")
def set_s3_secret_access_key(context, value):
    """Set S3 secret access key."""
    assert value is not None, "Secret access key needs to be specified"
    context.S3_secret_access_key = value


@given("S3 bucket name is set to {value}")
def assert_s3_bucket_name_is_set(context, value):
    """Set S3 bucket name."""
    assert value is not None, "Bucket name needs to be specified"
    context.S3_bucket_name = value


@given("S3 connection is established")
def establish_s3_connection(context):
    """Establish connection to S3."""
    minio_client(context)


@given("I should see no objects in S3")
@then("I should see no objects in S3")
def assert_s3_bucket_is_empty(context):
    """Check that the bucket is empty."""
    bucket_check(context)

    # retrieve all objects stored in bucket
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    # retrieve object names only
    names = [o.object_name for o in objects]
    print("S3 objects: ", names)

    assert len(names) == 0


@given("The S3 bucket is empty")
def ensure_s3_bucket_is_empty(context):
    """Ensure that the bucket is empty."""
    create_bucket(context)


@then("The S3 bucket is empty")
def check_bucket_is_empty(context):
    """Check if the bucket is empty."""
    bucket_check(context)
    # retrieve all objects stored in bucket
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    names = [o.object_name for o in objects]
    assert len(names) == 0


@then("The S3 bucket is not empty")
def check_bucket_contains_files(context):
    """Check that the S3 bucket has, at least, 1 file."""
    bucket_check(context)
    # retrieve all objects stored in bucket
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    names = [o.object_name for o in objects]
    assert len(names) > 0


@then("I should see following objects generated in S3")
def check_objects_in_s3(context):
    """Check that all specified objects was generated."""
    # check if bucket used by exporter exists
    bucket_check(context)

    # retrieve all objects stored in bucket
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    # retrieve object names only
    names = [o.object_name for o in objects]
    print("S3 objects: ", names)

    # iterate over all items in feature table
    for row in context.table:
        object_name = get_object_name(context, row["File name"])
        print(object_name)
        assert object_name in names, "Can not find object {} in bucket {}".format(
            object_name, context.S3_bucket_name
        )


@then("I should not see following objects generated in S3")
def check_objects_not_in_s3(context):
    """Check that all specified objects were not generated."""
    bucket_check(context)

    # retrieve all objects stored in bucket
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    # retrieve object names only
    names = [o.object_name for o in objects]
    print("S3 objects: ", names)

    # iterate over all items in feature table
    for row in context.table:
        object_name = get_object_name(context, row["File name"])
        assert object_name not in names, "object {} found in bucket {}".format(
            object_name, context.S3_bucket_name
        )


@then("I should see following number of records stored in CSV objects in S3")
def check_csv_content_in_s3(context):
    """Check content of objects stored in S3."""
    # check if bucket used by exporter exists
    bucket_check(context)

    # iterate over all items in feature table
    for row in context.table:
        object_name = get_object_name(context, row["File name"])
        expected_records = int(row["Records"])

        # read object content
        buff = read_object_into_buffer(context, object_name)

        # read CVS from buffer
        csv_file = csv.reader(buff)

        stored_records = len(list(csv_file)) - 1

        # now check numbers
        assert (
            expected_records == stored_records
        ), "Expected number records in object {} is {} but {} was read".format(
            object_name, expected_records, stored_records
        )


@then(
    "I should see following records in exported object {object_name} placed in column {column:d}"
)  # noqa: E501
@then(
    "I should see following records in exported object {object_name} "
    "placed in columns {column:d} and {column2:d}"
)  # noqa: E501
def check_records_in_csv_object(context, object_name, column, column2=None):
    """Check if all records are really stored in given CSV file/object in S3/S3."""
    # read object content
    object_name = get_object_name(context, object_name)
    buff = read_object_into_buffer(context, object_name)

    check_table_content(context, buff, object_name, column, column2)
