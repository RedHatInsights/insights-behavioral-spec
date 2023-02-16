import os
import psycopg2


FEATURES_CLEAN_DB = ["aggregator_cleaner", "aggregator_exporter"]
FEATURES_WITH_KAFKA = ["notification_writer", "notification_service"]
FEATURES_WITH_MINIO = ["aggregator_exporter"]
FEATURES_NOTIFICATION = ["notification_writer", "notification_service", "service_log"]


def before_all(context):
    context.database_host = os.getenv("DB_HOST", "localhost")
    context.database_port = os.getenv("DB_PORT", 5432)
    context.database_name = os.getenv("DB_NAME", "postgres")
    context.database_user = os.getenv("DB_USER", "postgres")
    context.database_password = os.getenv("DB_PASS", "postgres")
    context.local = os.getenv("ENV_DOCKER", False) == 1


def before_scenario(context, scenario):
    if "skip" in scenario.effective_tags:
        scenario.skip("Marked with @skip")
        return
    if "local" in scenario.effective_tags and not context.local:
        scenario.skip("Marked with @local")
        return


def clean_db(context):
    connection_string = "host={} port={} dbname={} user={} password={}".format(
        context.database_host,
        context.database_port,
        "test",
        context.database_user,
        context.database_password,
    )
    connection = psycopg2.connect(connection_string)
    assert connection is not None, "connection should be established"
    print(f"connected to {connection.info.dsn_parameters}")
    with open("setup/clean_database.sql") as f:
        c = connection.cursor()
        for line in f:
            print("Line to execute: ", line)
            try:
                c.execute(line)
            except Exception:
                print(f"Couldn't execute '{line}'")
                context.connection.rollback()
                raise
        connection.commit()
        c.close()
    connection.close()


def create_notification_db(context):
    connection_string = "host={} port={} dbname={} user={} password={}".format(
        context.database_host,
        context.database_port,
        "test",
        context.database_user,
        context.database_password,
    )
    connection = psycopg2.connect(connection_string)
    assert connection is not None, "connection should be established"
    connection.autocommit = True
    cursor = connection.cursor()

    try:
        cursor.execute("CREATE DATABASE notification")
    except psycopg2.Error as err:
        if (
            err.pgerror != 'ERROR: database "notification" already exists'
            and err.pgcode != "42P04"
        ):
            print("Couldn't create database notification")
            connection.rollback()
            raise
    cursor.close()
    connection.close()


def setup_default_S3_context(context):
    context.S3_type = os.getenv("S3_TYPE", "minio")
    context.S3_endpoint = os.getenv("S3_HOST", "localhost")
    context.S3_port = os.getenv("S3_PORT", "9000")
    context.S3_access_key = os.getenv("S3_ACCESS_KEY_ID", "test_access_key")
    context.S3_secret_access_key = os.getenv(
        "S3_SECRET_ACCESS_KEY", "test_secret_access_key"
    )
    context.S3_bucket_name = os.getenv("S3_BUCKET", "test")


def setup_default_kafka_context(context):
    context.kafka_hostname = os.getenv("KAFKA_HOST", "localhost")
    context.kafka_port = os.getenv("KAFKA_PORT", "9092")


def before_feature(context, feature):
    if any(f in feature.tags for f in FEATURES_CLEAN_DB):
        clean_db(context)

    if any(f in feature.tags for f in FEATURES_WITH_MINIO):
        setup_default_S3_context(context)

    if any(f in feature.tags for f in FEATURES_WITH_KAFKA):
        setup_default_kafka_context(context)

    if any(f in feature.tags for f in FEATURES_NOTIFICATION):
        create_notification_db(context)
