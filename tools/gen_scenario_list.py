#!/usr/bin/env python3

# Copyright © 2022 Pavel Tisnovsky
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

"""Scenario list generator."""

# Usage
# python3 tools/gen_scenario_list.py > feature/new_README.md

import os

# list of prefixes for scenarios or scenario outlines
PREFIXES = ("Scenario: ", "Scenario Outline: ")

# directory where feature files are stored
FEATURE_DIRECTORY = "features"

# list of subdirectories with feature files with specified order
SUBDIRECTORIES = (
    "OCM",
    "OCP_WebConsole",
    "ACM",
    "Insights_Advisor",
    "Notification_Service",
    "SHA_Extractor",
    "insights-results-aggregator-cleaner",
    "insights-results-aggregator-exporter",
    "ccx-notification-service",
    "ccx-notification-writer",
)

# page header
print("# Description")
print("Directory where feature files with scenarios and scenario outlines are stored.")  # noqa
print()
print("# List of scenarios")
print()

for subdirectory in SUBDIRECTORIES:
    directory = os.path.join(FEATURE_DIRECTORY, subdirectory)
    files = sorted(os.listdir(directory))
    for filename in files:
        # grep all .feature files
        if filename.endswith(".feature"):
            # feature file header
            print("## `{}/{}`\n".format(subdirectory, filename))
            with open(os.path.join(directory, filename), "r") as fin:
                for line in fin.readlines():
                    line = line.strip()
                    # process all scenarios and scenario outlines
                    for prefix in PREFIXES:
                        if line.startswith(prefix):
                            line = line[len(prefix):]
                            print("* {}".format(line))
            # vertical space between subsections in generated file
            print()
