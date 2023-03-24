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


def get_array_from_json(context, selector, subselector=None):
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


def construct_rh_token(org, account, user):
    """Construct RH identity token for provided user info."""
    # text token
    token = '''
    {{
        "identity": {{
            "org_id": "{0}",
            "account_number":"{1}",
            "user": {{
                "user_id":"{2}"
            }}
        }}
    }}
    '''.format(org, account, user)

    # convert to base64 encoding
    return base64.b64encode(token.encode('ascii'))
