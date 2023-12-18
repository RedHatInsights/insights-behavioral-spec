# Copyright © 2023, Jiří Papoušek, Red Hat, Inc.
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

"""Implementation of logic behind usage of S3 and Kafka in SHA extractor tests."""

import logging
import os

import json
from behave import when
from src import kafka_util

try:
    import boto3
    from botocore.exceptions import ClientError
except ImportError as e:
    print("Warning: unable to import module:", e)


def create_presigned_url(s3_client, bucket_name, object_name, expiration=3600):
    """Generate a presigned URL to share an S3 object."""
    try:
        response = s3_client.generate_presigned_url("get_object",
                                                    Params={"Bucket": bucket_name,
                                                            "Key": object_name},
                                                    ExpiresIn=expiration)
    except ClientError as e:
        logging.error(e)
        return None

    # The response contains the presigned URL
    return response


def use_real_storage(context, archive_key, msg_path):
    """Load data to real S3 storage and publish the JSON message to Kafka."""
    s3_host = os.getenv("S3_HOST", default="localhost")
    s3_port = os.getenv("S3_PORT", default="9000")
    s3_access_key = os.getenv("S3_ACCESS_KEY")
    s3_secret_access_key = os.getenv("S3_SECRET_ACCESS_KEY")

    s3_client = boto3.client("s3",
                             endpoint_url=f"http://{s3_host}:{s3_port}",
                             aws_access_key_id=s3_access_key,
                             aws_secret_access_key=s3_secret_access_key)

    try:
        s3_client.head_bucket(Bucket="test")
    except ClientError:
        s3_client.create_bucket(Bucket="test")

    with open(f"test_data/{archive_key}.tar.gz", "rb") as archive:
        s3_client.put_object(Body=archive, Bucket="test", Key=archive_key)

    topic_name = context.__dict__["_stack"][0]["incoming_topic"]
    presigned_url = create_presigned_url(s3_client, "test", archive_key)

    with open(msg_path, "r") as f:
        msg = f.read().encode("utf-8")
        event_data = json.loads(msg)
        event_data["url"] = presigned_url
        event_data = json.dumps(event_data).encode("utf-8")
        headers = [("service", b"testareno")]
        kafka_util.send_event(context.hostname, topic_name, event_data, headers)


def use_mock_storage(context, archive_key, msg_path):
    """Publish JSON messages to Kafka with URLs for mock storage."""
    topic_name = context.__dict__["_stack"][0]["incoming_topic"]

    with open(msg_path, "r") as f:
        event_data = f.read().encode("utf-8")
        headers = [("service", b"testareno")]
        kafka_util.send_event(context.hostname, topic_name, event_data, headers)


@when("S3 and Kafka are populated with an archive {with_or_without} workload_info")
def populate_s3(context, with_or_without):
    """Try to load archive to real S3 storage and publish JSON message to Kafka."""
    if with_or_without == "with":
        archive_key = "archive"
        msg_path = "test_data/upload.json"
    else:
        archive_key = "archive_no_workloadinfo"
        msg_path = "test_data/upload_no_workloadinfo.json"

    # use real storage and in case of failure, use mock s3 instead
    try:
        use_real_storage(context, archive_key, msg_path)
    except Exception:
        use_mock_storage(context, archive_key, msg_path)
