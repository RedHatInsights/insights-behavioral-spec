# Copyright © 2021, 2022 Pavel Tisnovsky, Red Hat, Inc.
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

from shutil import which
import psycopg2
from psycopg2.errors import UndefinedTable


from behave import given, then, when


@given(u"the system is in default state")
def system_in_default_state(context):
    """Check the default system state."""
    pass


@when(u"I look for executable file {filename}")
def look_for_executable_file(context, filename):
    """Try to find given executable file on PATH."""
    context.filename = filename
    context.found = which(filename)


@then(u"I should find that file on PATH")
def file_was_found(context):
    """Check if the file was found on PATH."""
    assert context.found is not None, "executable filaname '{}' is not on PATH".format(
        context.filename
    )


@then(u"The process should finish with exit code {exit_code:d}")
def check_process_exit_code(context, exit_code):
    """Check exit code of process."""
    assert context.return_code == exit_code, "Unexpected exit code {}".format(
        context.return_code
    )

@then("I should see help messages displayed by {service} on standard output")
def check_help_message(context, service):
    """Check if help is displayed by the service."""
    if service == "ccx-notification-service":
        from notification_service import check_help_from_ccx_notification_service
        check_help_from_ccx_notification_service(context)
    elif service == "ccx-notification-writer":
        from notification_writer import check_help_from_ccx_notification_writer
        check_help_from_ccx_notification_writer(context)
    elif service == "cleaner":
        from cleaner_main import check_help_from_cleaner
        check_help_from_cleaner(context)
    elif service == "exporter":
        from exporter_main import check_help_from_exporter
        check_help_from_exporter(context)
    else:
        raise ValueError(f"Unknown service '{service}'.")

@then(u"I should see version info displayed by {service} on standard output")
def check_version_info(context, service):
    """Check if version info is displayed by the service."""
    if service == "ccx-notification-service":
        from notification_service import check_version_from_ccx_notification_service
        check_version_from_ccx_notification_service(context)
    elif service == "ccx-notification-writer":
        from notification_writer import check_version_from_ccx_notification_writer
        check_version_from_ccx_notification_service(context)
    elif service == "cleaner":
        from cleaner_main import check_version_from_cleaner
        check_version_from_cleaner(context)
    elif service == "exporter":
        from exporter_main import check_version_from_exporter
        check_version_from_exporter(context)
    else:
        raise ValueError(f"Unknown service '{service}'.")

@then("I should see info about authors displayed by {service} on standard output")
def check_authors_info(context, service):
    """Check if information about authors is displayed by the service."""
    if service == "ccx-notification-service":
        from notification_service import check_authors_info_from_ccx_notification_service
        check_authors_info_from_ccx_notification_service(context)
    elif service == "ccx-notification-writer":
        from notification_writer import check_authors_info_from_ccx_notification_writer
        check_authors_info_from_ccx_notification_writer(context)
    elif service == "cleaner":
        from cleaner_main import check_authors_info_from_cleaner
        check_authors_info_from_cleaner(context)
    elif service == "exporter":
        from exporter_main import check_authors_info_from_exporter
        check_authors_info_from_exporter(context)
    else:
        raise ValueError(f"Unknown service '{service}'.")
