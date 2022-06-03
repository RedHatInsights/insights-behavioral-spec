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

from minio import Minio, ResponseError
from io import StringIO


def minio_client(context):
    """Construct new Minio client."""
    # brand new Minio client
    client = Minio(
        "{}:{}".format(context.minio_endpoint, context.minio_port),
        context.minio_access_key,
        context.minio_secret_access_key,
        secure=False
    )

    assert client is not None, "Minio client constructor issue"
    return client


def bucket_check(context, client):
    """Check bucket existence."""
    found = client.bucket_exists(context.minio_bucket_name)
    assert found, "Bucket can't be accessed"


def read_object_into_buffer(context, client, object_name):
    """Read object from pre-selected bucket into a buffer."""
    # retrieve object
    response = client.get_object(context.minio_bucket_name, object_name)
    assert response is not None, "No response from storage."

    # convert into buffer
    buff = StringIO(response.read().decode())
    assert buff is not None, "Decoding/read error"

    return buff
