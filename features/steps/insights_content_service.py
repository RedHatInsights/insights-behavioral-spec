# Copyright © 2023 Red Hat, Inc.
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

"""Implementation of test steps for testing CCX Insights Content Service."""

import re
from behave import then


@then("BuildCommit is a proper sha1")
def check_build_commit(context):
    """Check build commit SHA1 stamp taken from service output."""
    pattern = re.compile(r"\b[0-9a-f]{40}\b")
    match = re.match(pattern, context.response.json()["info"]["BuildCommit"])
    assert match.group(0), "BuildCommit is not a sha1"


@then("BuildTime is a proper date")
def check_build_time(context):
    """Check build timestamp taken from service output."""
    buildTime = context.response.json()["info"]["BuildTime"]
    pattern = re.compile(
        r".{3} .{3}[ ]{1,2}[0-9]{1,2} [0-9]{2}:[0-9]{2}:[0-9]{2} ([AP]M )?[A-Z]{1,5} [0-9]{4}"
    )
    match = re.match(pattern, buildTime)
    assert match.group(0), "BuildTime is not a date time: {}".format(buildTime)


@then("BuildVersion is in the proper format")
def check_build_version(context):
    """Check build version taken from service output."""
    pattern = re.compile(r"[0-9].[0-9]*")
    match = re.match(pattern, context.response.json()["info"]["BuildVersion"])
    assert match.group(0), "BuildVersion is in the wrong format"


@then("OCPRulesVersion is in the proper format")
def check_ocprules_version(context):
    """Check OCP rules version taken from service output."""
    pattern = re.compile(r"[0-9]{4}.[0-9]{2}.[0-9]{2}")
    match = re.match(pattern, context.response.json()["info"]["OCPRulesVersion"])
    assert match.group(0), "OCPRulesVersion is in the wrong format"


@then("UtilsVersion is in the proper format")
def check_utils_version(context):
    """Check utils version taken from service output."""
    pattern = re.compile(r"v[0-9]{1}.[0-9]*.[0-9]*")
    match = re.match(pattern, context.response.json()["info"]["UtilsVersion"])
    assert match.group(0), "UtilsVersion is in the wrong format"


@then("all the groups are present")
def check_groups(context):
    """Check if groups attribute contains all expected group names."""
    groups = context.response.json()["groups"]
    assert len(groups) == 4, f"groups number is {len(groups)}"

    expected = ["Performance", "Service Availability", "Security", "Fault Tolerance"]
    for i, group in enumerate(groups):
        err_msg = f"{groups[i]['title']} not in {expected}"
        assert group["title"] in expected, err_msg


@then("tags and groups match")
def check_tags_and_groups(context):
    """Check if tags attribute contains all expected tag names."""
    groups = context.response.json()["groups"]
    for group in groups:
        title = group["title"].lower()
        title = title.replace(" ", "_")
        err_msg = f"expected tag {title} but got {group['tags'][0]}"
        assert title == group["tags"][0], err_msg


@then("rules are properly loaded")
def check_rules_status(context):
    """Check if rules are loaded properly by Content Service."""
    rules = context.response.json()["rules"]
    for rule_name in rules:
        rule = rules[rule_name]
        err_msg = f"{rule} failed, error: {rule['error']}, loaded: {rule['loaded']}"
        assert rule["loaded"] == (not rule["error"]), err_msg
