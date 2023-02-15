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

"""Common steps for DB related operations."""

from behave import then, when, given

import subprocess
import psycopg2


CREATE_TABLE_ADVISOR_RATINGS = """
CREATE TABLE advisor_ratings (
                                user_id         VARCHAR NOT NULL,
                                org_id          VARCHAR NOT NULL,
                                rule_fqdn       VARCHAR NOT NULL,
                                error_key       VARCHAR NOT NULL,
                                rated_at        TIMESTAMP,
                                last_updated_at TIMESTAMP,
                                rating          SMALLINT,
                                rule_id         VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_REPORT = """
CREATE TABLE report (
                                org_id          INTEGER NOT NULL,
                                cluster         VARCHAR NOT NULL UNIQUE,
                                report          VARCHAR NOT NULL,
                                reported_at     TIMESTAMP,
                                last_checked_at TIMESTAMP,
                                kafka_offset    BIGINT NOT NULL DEFAULT 0,
                                gathered_at     TIMESTAMP,
                                PRIMARY KEY(org_id, cluster)
                        );

"""

CREATE_TABLE_CLUSTER_RULE_TOGGLE = """
CREATE TABLE cluster_rule_toggle (
                                cluster_id  VARCHAR NOT NULL,
                                rule_id     VARCHAR NOT NULL,
                                user_id     VARCHAR NOT NULL,
                                disabled    SMALLINT NOT NULL,
                                disabled_at TIMESTAMP NULL,
                                enabled_at  TIMESTAMP NULL,
                                updated_at  TIMESTAMP NOT NULL,
                                error_key   VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_CLUSTER_RULE_USER_FEEDBACK = """
CREATE TABLE cluster_rule_user_feedback (
                                        cluster_id VARCHAR NOT NULL,
                                        rule_id    VARCHAR NOT NULL,
                                        user_id    VARCHAR NOT NULL,
                                        message    VARCHAR NOT NULL,
                                        user_vote  SMALLINT NOT NULL,
                                        added_at   TIMESTAMP NOT NULL,
                                        updated_at TIMESTAMP NOT NULL,
                                        error_key  VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_CLUSTER_USER_RULE_DISABLE_FEEDBACK = """
CREATE TABLE cluster_user_rule_disable_feedback (
                                cluster_id VARCHAR NOT NULL,
                                user_id    VARCHAR NOT NULL,
                                rule_id    VARCHAR NOT NULL,
                                message    VARCHAR NOT NULL,
                                added_at   TIMESTAMP NOT NULL,
                                updated_at TIMESTAMP NOT NULL,
                                error_key  VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_RULE_HIT = """
CREATE TABLE rule_hit (
                        org_id          INTEGER NOT NULL,
                        cluster_id      VARCHAR NOT NULL,
                        rule_fqdn       VARCHAR NOT NULL,
                        error_key       VARCHAR NOT NULL,
                        template_data   VARCHAR NOT NULL,
                        PRIMARY KEY(cluster_id, org_id, rule_fqdn, error_key)
                        );
"""

CREATE_TABLE_CONSUMER_ERROR = """
CREATE TABLE consumer_error (
                        topic        VARCHAR NOT NULL,
                        partition    INTEGER NOT NULL,
                        topic_offset INTEGER NOT NULL,
                        key          VARCHAR,
                        produced_at  TIMESTAMP NOT NULL,
                        consumed_at  TIMESTAMP NOT NULL,
                        message      VARCHAR,
                        error        VARCHAR NOT NULL
                        );
"""

CREATE_TABLE_MIGRATION_INFO = """
CREATE TABLE migration_info (
                        version INTEGER NOT NULL
);
"""

CREATE_TABLE_RECOMMENDATION = """
CREATE TABLE recommendation (
                        org_id     INTEGER NOT NULL,
                        cluster_id VARCHAR NOT NULL,
                        rule_fqdn  TEXT NOT NULL,
                        error_key  VARCHAR NOT NULL,
                        rule_id    VARCHAR NOT NULL,
                        created_at TIMESTAMP
);
"""

CREATE_TABLE_REPORT_INFO = """
CREATE TABLE report_info (
                        org_id       INTEGER NOT NULL,
                        cluster_id   VARCHAR NOT NULL,
                        version_info VARCHAR NOT NULL
);
"""

CREATE_TABLE_RULE_DISABLE = """
CREATE TABLE rule_disable (
                        org_id        VARCHAR NOT NULL,
                        user_id       VARCHAR NOT NULL,
                        rule_id       VARCHAR NOT NULL,
                        error_key     VARCHAR NOT NULL,
                        justification VARCHAR,
                        created_at    TIMESTAMP,
                        updated_at    TIMESTAMP
);
"""

# all commands to create tables
CREATE_TABLE_COMMANDS = (
    CREATE_TABLE_ADVISOR_RATINGS,
    CREATE_TABLE_REPORT,
    CREATE_TABLE_CLUSTER_RULE_TOGGLE,
    CREATE_TABLE_CLUSTER_RULE_USER_FEEDBACK,
    CREATE_TABLE_CLUSTER_USER_RULE_DISABLE_FEEDBACK,
    CREATE_TABLE_RULE_HIT,
    CREATE_TABLE_CONSUMER_ERROR,
    CREATE_TABLE_MIGRATION_INFO,
    CREATE_TABLE_RECOMMENDATION,
    CREATE_TABLE_REPORT_INFO,
    CREATE_TABLE_RULE_DISABLE,
)

# following tables should be processed
DB_TABLES = (
    "advisor_ratings",
    "report",
    "cluster_rule_toggle",
    "cluster_rule_user_feedback",
    "cluster_user_rule_disable_feedback",
    "rule_hit",
    "consumer_error",
    "migration_info",
    "recommendation",
    "report_info",
    "rule_disable",
)


@when(u"I prepare database schema")
def prepare_database_schema(context):
    """Prepare database schema."""
    cursor = context.connection.cursor()
    try:
        for createTableCommand in CREATE_TABLE_COMMANDS:
            cursor.execute(createTableCommand)
            context.connection.commit()
    except Exception as e:
        context.connection.rollback()
        raise e
