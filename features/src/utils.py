# Copyright © 2023 Pavel Tisnovsky, Red Hat, Inc.
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

"""Unsorted utility functions to be used from other sources and test step definitions."""

import base64
from behave.runner import Context
from typing import Set


def get_array_from_json(context: Context, selector, subselector=None):
    """Read all items from an array stored in JSON returned by service."""
    # try to parse response body
    json = context.response.json()
    assert json is not None, "JSON response is missing in context object"

    # try to retrieve content of given array
    assert selector in json, \
        "attribute '{}' is not found in JSON response".format(selector)

    # return items from array is subselector is not specified
    if subselector is None:
        return json[selector]
    # return just one attribute from objects stored in an array
    else:
        return (item[subselector] for item in json[selector])


def construct_rh_token(org: int, account: str, user: str) -> bytes:
    """Construct RH identity token for provided user info."""
    # check the input
    assert org > 0, "Organization ID should be positive integer"
    assert account, "Account number should not be empty"
    assert user, "User ID should not be empty"

    # text token
    token = """
    {{
        "identity": {{
            "org_id": "{}",
            "account_number":"{}",
            "user": {{
                "user_id":"{}"
            }}
        }}
    }}
    """.format(
        org, account, user
    )

    # convert to base64 encoding
    return base64.b64encode(token.encode("ascii"))


def retrieve_set_of_clusters_from_table(context: Context) -> Set[str]:
    """Retrieve set of clusters from table specified in scenario or scenario outline."""
    return set(item["Cluster name"] for item in context.table)


def find_block(output, block_delimiter):
    """Try to find start of block in process output."""
    for i, line in enumerate(output):
        if line == block_delimiter:
            return i
    raise Exception("Block was not found")
