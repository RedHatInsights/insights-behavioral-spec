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

"""Minio/S3-related code."""

from minio import Minio
from io import StringIO


def minio_client(context):
    """Construct new Minio client."""
    if not hasattr(context, "minio_client"):
        # brand new Minio client
        endpoint, port, access_key, secret_access_key = (
            context.S3_endpoint,
            context.S3_port,
            context.S3_access_key,
            context.S3_secret_access_key,
        )
        client = Minio(
            "{}:{}".format(endpoint, port),
            access_key,
            secret_access_key,
            secure=False,
        )

        assert client is not None, "Minio client constructor issue"
        context.minio_client = client


def bucket_check(context):
    """Check bucket existence."""
    bucket_name = context.S3_bucket_name
    found = context.minio_client.bucket_exists(bucket_name)
    assert found, "Bucket can't be accessed"


def read_object_into_buffer(context, object_name):
    """Read object from pre-selected bucket into a buffer."""
    # retrieve object
    bucket_name = context.S3_bucket_name
    response = context.minio_client.get_object(bucket_name, object_name)
    assert response is not None, "No response from storage."

    # convert into buffer
    buff = StringIO(response.read().decode())
    assert buff is not None, "Decoding/read error"

    return buff


def get_object_name(context, filename):
    """Retrieve object name compatible with S3 and Minio, including older versions."""
    if context.S3_old_minio_compatibility:
        return filename
    else:
        return f"{context.S3_bucket_name}/{filename}"
