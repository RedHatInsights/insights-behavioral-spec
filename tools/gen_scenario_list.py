#!/usr/bin/env python3

# Copyright © 2022, 2023 Pavel Tisnovsky
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
# python3 tools/gen_scenario_list.py > docs/scenarios_list.md

import os

# URL prefix to create links to feature files
FEATURES_URL_PREFIX = "https://github.com/RedHatInsights/insights-behavioral-spec/blob/main/features"  # noqa E501

# list of prefixes for scenarios or scenario outlines
PREFIXES = ("Scenario: ", "Scenario Outline: ")

# sub-directory where feature files are stored
FEATURE_DIRECTORY = "features"

# list of subdirectories with feature files with specified order
# (order is important to make sure the resulting scenario list will have stable structure)
SUBDIRECTORIES = (
    "OCM",
    "OCP_WebConsole",
    "ACM",
    "Insights_Advisor",
    "DVO_Recommendations",
    "SHA_Extractor",
    "smart-proxy",
    "insights-content-service",
    "insights-content-template-renderer",
    "insights-results-aggregator",
    "insights-results-aggregator-cleaner",
    "insights-results-aggregator-exporter",
    "insights-results-aggregator-mock",
    "ccx-notification-service",
    "ccx-notification-writer",
    "ccx-upgrades-inference",
    "ccx-upgrades-data-eng",
    "parquet-factory",
)

# generate page header
print("---")
print("layout: page")
print("nav_order: 3")
print("---")
print()
print("# List of scenarios")
print()

# generage list of scenarios
for subdirectory in SUBDIRECTORIES:
    directory = os.path.join(FEATURE_DIRECTORY, subdirectory)
    # files within one subdirectory needs to be sorted so the
    # resulting scenario list will have stable structure across versions
    files = sorted(os.listdir(directory))
    for filename in files:
        # grep all .feature files
        if filename.endswith(".feature"):
            # feature file header
            print("## [`{}/{}`]({}/{}/{})\n".format(
                subdirectory, filename, FEATURES_URL_PREFIX, subdirectory, filename))
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
