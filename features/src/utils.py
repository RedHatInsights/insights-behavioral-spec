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
    # text token
    token = """
    {{
        "identity": {{
            "org_id": "{0}",
            "account_number":"{1}",
            "user": {{
                "user_id":"{2}"
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


if __name__ == "__main__":
    # just check the function to retrieve set of clusters from table
    class Context:
        """Mock for real context class from Behave."""
        def __init__(self, items):
            """Initializes table attribute to be the same as in Behave.Context."""
            self.table = [{"Cluster name": item} for item in items]


    context = Context([])
    assert retrieve_set_of_clusters_from_table(context) == set()

    context = Context(["foo", "bar", "baz"])
    assert retrieve_set_of_clusters_from_table(context) == {"foo", "bar", "baz"}

    context = Context(["foo", "bar", "baz", "foo"])
    assert retrieve_set_of_clusters_from_table(context) == {"foo", "bar", "baz"}

    context = Context(["foo", "foo", "foo", "foo"])
    assert retrieve_set_of_clusters_from_table(context) == {"foo"}
