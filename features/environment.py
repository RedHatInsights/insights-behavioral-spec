# Copyright © 2023  Red Hat, Inc.
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

"""Code to be called before and after certain events during testing.

Currently four events have been registered:
1. before_all
2. before_feature
3. before_scenario
4. after_scenario
"""

import os
import psycopg2

# Mappings between supported features (like consuming message from Kafka) and
# tags specified in feature files

# Clean database before the first scenario in feature file
FEATURES_CLEAN_DB = ("aggregator", "aggregator_cleaner", "aggregator_exporter")

# Initialize database before the first scenario in feature file
FEATURES_INIT_DB = ("aggregator", "notification_service")

# Setup all environment variables needed to work with Kafka (local or remote)
FEATURES_WITH_KAFKA = ("aggregator", "notification_writer", "notification_service")

# Setup all environment variables needed to work with Minio (local or remote)
FEATURES_WITH_MINIO = ("aggregator_exporter",)

# Mapping between database name and script to cleanup such database.
CLEANUP_FILES = {
    "test": "setup/clean_aggregator_database.sql",
    "notification": "setup/clean_notification_database.sql",
}

# Mapping between database name and script to initialize such database.
DB_INIT_FILES = {
    "test": "setup/prepare_aggregator_database.sql",
    "notification": "setup/prepare_notification_database.sql",
}


def before_all(context):
    """Run before and after the whole shooting match."""
    context.database_host = os.getenv("DB_HOST", "localhost")
    context.database_port = os.getenv("DB_PORT", 5432)
    context.database_name = os.getenv("DB_NAME", "test")
    context.database_user = os.getenv("DB_USER", "postgres")
    context.database_password = os.getenv("DB_PASS", "postgres")
    context.local = os.getenv("ENV_DOCKER", False) in ["0", False]


def before_scenario(context, scenario):
    """Run before each scenario is run."""
    if "skip" in scenario.effective_tags:
        scenario.skip("Marked with @skip")
        return
    if "local" in scenario.effective_tags and not context.local:
        scenario.skip("Marked with @local")
        return


def after_scenario(context, scenario):
    """Run after each scenario is run."""
    if "database" in scenario.effective_tags:
        prepare_db(context, CLEANUP_FILES, context.database_name)
    if "sha_extractor" in scenario.effective_tags:
        # terminate the subprocess to have
        # one kafka consumer at a time
        context.sha_extractor.terminate()
        context.sha_extractor.kill()
        context.sha_extractor.wait()
        assert context.sha_extractor.poll() is not None, \
            f"sha extractor was not closed"


def prepare_db(context, setup_files=CLEANUP_FILES, database="test"):
    """Prepare database, including all default objects in DB."""
    connection_string = "host={} port={} dbname={} user={} password={}".format(
        context.database_host,
        context.database_port,
        database,
        context.database_user,
        context.database_password,
    )

    connection = psycopg2.connect(connection_string)
    assert connection is not None, "connection should be established"
    with open(setup_files[database]) as f:
        c = connection.cursor()
        for line in f:
            try:
                c.execute(line)
            except Exception:
                print(f"Couldn't execute '{line}'")
                connection.rollback()
                raise
        connection.commit()
        c.close()
    connection.close()


def setup_default_S3_context(context):
    """Prepare context variables to be used to connect to S3 or Minio."""
    context.S3_type = os.getenv("S3_TYPE", "minio")
    context.S3_endpoint = os.getenv("S3_HOST", "localhost")
    context.S3_port = os.getenv("S3_PORT", "9000")
    context.S3_access_key = os.getenv("S3_ACCESS_KEY_ID", "test_access_key")
    context.S3_secret_access_key = os.getenv(
        "S3_SECRET_ACCESS_KEY", "test_secret_access_key"
    )
    context.S3_bucket_name = os.getenv("S3_BUCKET", "test")
    context.S3_old_minio_compatibility = os.getenv("S3_OLDER_MINIO_COMPATIBILITY", None)


def setup_default_kafka_context(context):
    """Prepare context variables to be used to connect to Kafka broker."""
    context.kafka_hostname = os.getenv("KAFKA_HOST", "localhost")
    context.kafka_port = os.getenv("KAFKA_PORT", "9092")


def before_feature(context, feature):
    """Run before each feature file is exercised."""
    if any(f in feature.tags for f in FEATURES_CLEAN_DB):
        prepare_db(context, CLEANUP_FILES)

    if any(f in feature.tags for f in FEATURES_INIT_DB):
        prepare_db(context, DB_INIT_FILES, context.database_name)

    if any(f in feature.tags for f in FEATURES_WITH_MINIO):
        setup_default_S3_context(context)

    if any(f in feature.tags for f in FEATURES_WITH_KAFKA):
        setup_default_kafka_context(context)
