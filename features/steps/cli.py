# Copyright © 2022 Red Hat, Inc.
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

"""
Common steps for CLI related operations.

Will raise a ValueError in case the service is not among:
- ccx-notification-service
- ccx-notification-writer
- cleaner
- exporter
"""

from behave import then


@then("I should see help messages displayed by {service} on standard output")
def check_help_message(context, service):
    """Check if help is displayed by the service."""
    if service == "ccx-notification-service":
        from steps.notification_service import check_help_from_ccx_notification_service

        check_help_from_ccx_notification_service(context)
    elif service == "ccx-notification-writer":
        from steps.notification_writer import check_help_from_ccx_notification_writer

        check_help_from_ccx_notification_writer(context)
    elif service == "cleaner":
        from steps.cleaner_main import check_help_from_cleaner

        check_help_from_cleaner(context)
    elif service == "exporter":
        from steps.exporter_main import check_help_from_exporter

        check_help_from_exporter(context)
    elif service == "Insights Results Aggregator Mock":
        from steps.insights_results_aggregator_mock import check_help_from_mock

        check_help_from_mock(context)
    elif service == "Insights Results Aggregator":
        from steps.insights_results_aggregator import check_help_from_aggregator

        check_help_from_aggregator(context)
    else:
        raise ValueError(f"Unknown service '{service}'.")


@then("I should see version info displayed by {service} on standard output")
def check_version_info(context, service):
    """Check if version info is displayed by the service."""
    if service == "ccx-notification-service":
        from steps.notification_service import (
            check_version_from_ccx_notification_service,
        )

        check_version_from_ccx_notification_service(context)

    elif service == "ccx-notification-writer":
        from steps.notification_writer import check_version_from_ccx_notification_writer

        check_version_from_ccx_notification_writer(context)

    elif service == "cleaner":
        from steps.cleaner_main import check_version_from_cleaner

        check_version_from_cleaner(context)

    elif service == "exporter":
        from steps.exporter_main import check_version_from_exporter

        check_version_from_exporter(context)

    elif service == "Insights Results Aggregator Mock":
        from steps.insights_results_aggregator_mock import check_version_from_mock

        check_version_from_mock(context)

    else:
        raise ValueError(f"Unknown service '{service}'.")


@then("I should see info about authors displayed by {service} on standard output")
def check_authors_info(context, service):
    """Check if information about authors is displayed by the service."""
    if service == "ccx-notification-service":
        from steps.notification_service import (
            check_authors_info_from_ccx_notification_service,
        )

        check_authors_info_from_ccx_notification_service(context)
    elif service == "ccx-notification-writer":
        from steps.notification_writer import (
            check_authors_info_from_ccx_notification_writer,
        )

        check_authors_info_from_ccx_notification_writer(context)
    elif service == "cleaner":
        from steps.cleaner_main import check_authors_info_from_cleaner

        check_authors_info_from_cleaner(context)
    elif service == "exporter":
        from steps.exporter_main import check_authors_info_from_exporter

        check_authors_info_from_exporter(context)
    elif service == "Insights Results Aggregator Mock":
        from steps.insights_results_aggregator_mock import check_authors_info_from_mock

        check_authors_info_from_mock(context)
    else:
        raise ValueError(f"Unknown service '{service}'.")
