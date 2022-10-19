#!/usr/bin/env python3

# Copyright © 2020, 2021, 2022 Pavel Tisnovsky
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

"""Simple checker of all Python sources in the given directory (usually repository)."""

from pathlib import Path
from sys import exit
import pycodestyle


def main():
    """Run pydocstyle checker against all Python sources in the given directory."""
    # Find all files in current directory and subdirectories with '*.py' extension.
    # Files are found recursivelly in all subdirectories as well.
    files = list(Path(".").rglob("*.py"))
    files = [f for f in files if not str(f).startswith("venv/")]
    print("Files to check:")
    print("\n".join(str(f) for f in files))
    print("\nChecks:")

    # Setup the module to check style of Python sources. We (usually) already
    # have global configuration file 'setup.cfg' that can be used. Also verbose
    # mode would be useful for our purposes, so we set `quiet` to `False` to
    # enable verbose output.
    style = pycodestyle.StyleGuide(quiet=False, config_file="setup.cfg")

    # Check the style for all Python sources found in current directory and all
    # subdirectories too. All detected issues are displayed in the meantime.
    result = style.check_files(files)

    # Print number of errors found at the end of check.
    print("Total errors:", result.total_errors)

    # If any error is found, return with exit code check to non-zero value.
    if result.total_errors > 0:
        exit(1)
    # Default exit code is 0 == success


# If this script is started from command line, run the `main` function which
# represents entry point to the processing.
if __name__ == "__main__":
    main()
