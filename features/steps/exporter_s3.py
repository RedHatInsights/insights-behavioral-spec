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

from src.minio import minio_client, bucket_check


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

    # retrieve all obejcts stored in bucket
    objects = client.list_objects(context.minio_bucket_name, recursive=False)

    # retrieve object names only
    names = [o.object_name for o in objects]

    # iterate over all items in feature table
    for row in context.table:
        object_name = row["File name"]
        assert object_name in names, \
            "Can not find object {} in bucket {}".format(object_name, context.minio_bucket_name)
