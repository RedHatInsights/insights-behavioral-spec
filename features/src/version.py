# Copyright 2023 Red Hat, Inc.
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

"""Version checks."""

import semver
import re


def version(output: list):
    """Check the version in longer program output."""
    exceptionMessage = "Improper or missing version {} found in {}"
    # check the output, line by line
    for line in output:
        if '"Version:' in line:
            version = line.split("Version: ")[-1][:-2]
            if version.startswith('v'):
                try:
                    semver.parse(version[1:])
                    print(f"{version} is a valid semantic version.")
                    break
                except ValueError:
                    raise Exception(exceptionMessage.format(version, context.output))
            else:
                # version should be a commit SHA1
                if not re.match(r"[a-f0-9]{40}", version):
                    raise Exception(exceptionMessage.format(version, context.output))
                break
    else:
        raise Exception(exceptionMessage.format("", context.output))
