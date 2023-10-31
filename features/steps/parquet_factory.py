"""Module with steps implementation related to parquet-factory tests."""

import json
import logging
import os
import subprocess
import tempfile
import time
from threading import Timer
from typing import Dict

from behave import then, when

from src import kafka_util


# parquet-factory binary file name
PARQUET_FACTORY_BINARY = "parquet-factory"

# path do directory with rules results templates to be used
DATA_DIRECTORY = "test_data"


@when('I set the environment variable "{env_name}" to "{env_value}"')
def set_environment(context, env_name: str, env_value: str) -> None:
    """Set an environment variable for next executions."""
    if not hasattr(context, "parquet_environment"):
        context.parquet_environment = {}

    context.parquet_environment[env_name] = env_value


@when('I run Parquet Factory with a timeout of "{timeout_sec:d}" seconds')
def run_parquet_factory(context, timeout_sec: int) -> None:
    """Run Parquet Factory.

    This function waits for {timeout_sec} to save its result in context.
    """
    context.parquet_factory_timed_out = False

    environ = os.environ.copy()
    if hasattr(context, "parquet_environment"):
        environ.update(context.parquet_environment)
    environ["PARQUET_FACTORY__LOGGING__DEBUG"] = "false"

    proc = subprocess.Popen(
        [PARQUET_FACTORY_BINARY],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        env=environ
    )

    print(f"timer will run for {timeout_sec}")
    timer = Timer(timeout_sec, proc.kill)
    try:
        timer.start()
        stdout, stderr = proc.communicate()

    finally:
        if timer.is_alive():
            print("Timer was still alive")
            timed_out = False
        else:
            print("Timer wasn't alive")
            timed_out = True
        timer.cancel()

    output = f"""----------------- STDOUT -----------------
{stdout.decode("utf-8")}
----------------- STDERR -----------------
{stderr.decode("utf-8") if stderr else ""}
"""
    context.parquet_factory_logs = output
    context.parquet_factory_timed_out = timed_out

    save_logs_to_tempfile(output)

    print("-v-" * 10)
    print(output)


@then("Parquet Factory should have finish")
def check_has_finished(context):
    """Make sure Parquet Factory finished gracefully."""
    assert not context.parquet_factory_timed_out, "PF was still running"


@then("Parquet Factory shouldn't have finish")
def check_hasnt_finished(context):
    """Make sure Parquet Factory was still running when quited."""
    assert context.parquet_factory_timed_out, "PF already finished"


@when("I fill the topics with messages of the {moment} hour")
def send_rules_results_to_kafka(context, moment):
    """Send rule results into seleted topic on selected broker."""
    shift = {
        "previous": -3600,
        "current": 0,
    }.get(moment, 0)

    with open(f"{DATA_DIRECTORY}/rules_message.json", "r") as payload_file:
        rules_payload = payload_file.read()

    with open(f"{DATA_DIRECTORY}/features_message.json", "r") as payload_file:
        features_payload = payload_file.read()

    for row in context.table:
        topic = row["topic"]
        partition = int(row["partition"])
        if row["type"] == "rules message":
            payload = rules_payload
        elif row["type"] == "features message":
            payload = features_payload
        else:
            payload = row["payload"]

        cluster_id = row.get("cluster", "")
        if cluster_id != "":
            payload = payload.replace("CLUSTER_ID_TO_BE_REPLACED", cluster_id)

        kafka_util.send_event(
            f"{context.kafka_hostname}:{context.kafka_port}",
            topic, payload.encode("utf-8"), partition=partition,
            timestamp=time.time() + shift
        )


def save_logs_to_tempfile(logs):
    """Store the logs in a temporary file."""
    tf = tempfile.NamedTemporaryFile(delete=False)
    with open(tf.name, "w") as pf_log_file:
        pf_log_file.write(logs)
    logging.info(f"You can check Parquet Factory logs at {tf.name}.")


@then("The logs should contain")
def check_logs_table(context):
    """Make sure the messaging log is in Parquet Factory logs."""
    for row in context.table:
        ok = check_logs(
            context.parquet_factory_logs,
            row["topic"],
            row["partition"],
            row["offset"],
            row["message"],
        )
        assert ok, \
            f'topic {row["topic"]}, partition {row["partition"]}, ' + \
            f'offset {row["offset"]}, message {row["message"]}, ' + \
            'not found'


@then('The logs should contain "{log_message}"')
def check_logs_message(context, log_message):
    """Make sure the log message is in the Parquet Factory logs."""
    for log in context.parquet_factory_logs.split("\n"):
        if log_message in log:
            return True

    return False


@then("The logs shouldn't contain")
def check_no_logs_table(context):
    """Make sure the messaging log isn't in Parquet Factory logs."""
    for row in context.table:
        ok = check_logs(
            context.parquet_factory_logs,
            row["topic"],
            row["partition"],
            row["offset"],
            row["message"],
        )
        assert not ok, \
            f'topic {row["topic"]}, partition {row["partition"]}, ' + \
            f'offset {row["offset"]}, message {row["message"]}, ' + \
            'found'


def check_logs(logs: str, topic: str, partition: int,
               offset: int, message: str):
    """Make sure that a messaging log exists in Parquet Factory logs.

    The log is build from the topic, partition, offset and
    message arguments.
    """
    # Parse the fields and values into a dictionary
    map_checker = {
        "topic": topic,
        "partition": partition,
        "offset": offset,
        "message": message,
    }

    num_fields_to_check = len(map_checker)

    logs = logs.split("\n")

    for log in logs:
        found = 0
        try:
            log_as_json = json.loads(log)
        except json.decoder.JSONDecodeError:
            continue

        if not set(map_checker.keys()) <= set(log_as_json.keys()):
            # Make sure all the expected fields are in the JSON
            continue

        for k, v in map_checker.items():
            if str(log_as_json[k]) == v:
                found += 1
        if found == num_fields_to_check:
            return True
    logging.debug(map_checker, "not found")
    return False
