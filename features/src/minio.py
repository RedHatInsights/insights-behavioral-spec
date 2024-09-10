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

"""Minio/S3-related functions that can be called from other sources and test step definitions."""

from io import BytesIO, StringIO
from typing import List

from behave.runner import Context
from minio import Minio


def minio_client(context: Context):
    """Construct new Minio client."""
    # TODO: secure option might need to be specified via context attribute
    if not hasattr(context, "minio_client"):
        # brand new Minio client
        endpoint, port, access_key, secret_access_key = (
            context.S3_endpoint,
            context.S3_port,
            context.S3_access_key,
            context.S3_secret_access_key,
        )
        client = Minio(
            f"{endpoint}:{port}",
            access_key,
            secret_access_key,
            secure=False,
        )

        assert client is not None, "Minio client constructor issue"
        context.minio_client = client


def create_bucket(context: Context):
    """Remove the bucket if exists and re-create again."""
    bucket_name = context.S3_bucket_name
    found = context.minio_client.bucket_exists(bucket_name)

    if found:
        clean_bucket(context)
        context.minio_client.remove_bucket(bucket_name)

    context.minio_client.make_bucket(bucket_name)


def bucket_check(context: Context):
    """Check bucket existence."""
    bucket_name = context.S3_bucket_name
    found = context.minio_client.bucket_exists(bucket_name)
    assert found, f"Bucket {bucket_name} can't be accessed"


def read_object_into_buffer(context: Context, object_name):
    """Read object from pre-selected bucket into a buffer."""
    # retrieve object
    bucket_name = context.S3_bucket_name
    response = context.minio_client.get_object(bucket_name, object_name)
    assert response is not None, "No response from storage."

    # convert into buffer
    buff = StringIO(response.read().decode())
    assert buff is not None, "Decoding/read error"

    return buff


def read_object_into_bytes_buffer(context: Context, object_name: str) -> BytesIO:
    """Retrieve ibject from pre-selected bucket into a bytes buffer."""
    bucket_name = context.S3_bucket_name
    response = context.minio_client.get_object(bucket_name, object_name)
    assert response is not None, "No response from storage."

    # convert into buffer
    buff = BytesIO(response.read())
    assert buff is not None, "Read error"

    return buff


def get_object_name(context: Context, filename):
    """Retrieve object name compatible with S3 and Minio, including older versions."""
    if context.S3_old_minio_compatibility:
        return filename
    else:
        return f"{context.S3_bucket_name}/{filename}"


def clean_bucket(context: Context):
    """Remove all the objects from the bucket."""
    objects = context.minio_client.list_objects(context.S3_bucket_name, recursive=True)
    object_names = [o.object_name for o in objects]
    remove_objects_by_name(context, object_names)


def remove_objects_by_name(context: Context, object_names: List[str]):
    """Remove the objects from the list in the configured bucket."""
    for object_name in object_names:
        context.minio_client.remove_object(context.S3_bucket_name, object_name)
