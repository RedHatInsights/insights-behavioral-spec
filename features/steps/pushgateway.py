"""Contains different Pushgateway utilities."""

from pprint import pformat
from typing import Dict, List

import requests


def reset_metrics(pushgateway_url: str) -> None:
    """Delete all metrics in {PUSHGATEWAY_URL}."""
    url = f"http://{pushgateway_url}/api/v1/admin/wipe"
    resp = requests.put(url)
    assert resp.status_code == 202, \
        f"Got error code {resp.status_code} while deleting the metrics " + \
        f"from {url}"
    metrics = list(get_metrics(pushgateway_url).keys())
    print(f"Metrics after reseting the pushgateway:\n{metrics}")


def get_metrics(pushgateway_url) -> str | Dict[str, List]:
    """Download the metrics from {pushgateway_url} and store as Dict."""
    ans = requests.get(f"http://{pushgateway_url}/metrics")
    if ans.status_code != 200:
        return ""
    else:
        return parse_metrics(ans.text)


def parse_metrics(metrics: str) -> Dict[str, List]:
    """Convert the raw string of metrics into a dictionary.

    {
        metric: [
            {
                value: value,
                labels: labels
            },
            ...
        }
    }.
    """
    metrics_list = metrics.split("\n")
    metrics_list = [metric for metric in metrics_list if len(
        metric) > 0 and metric[0] != "#"]
    parsed_metrics = {}
    for metric in metrics_list:
        key, val = metric.split(" ")
        metric_name, metric_labels = extract_labels(key)

        if metric_name not in parsed_metrics:
            parsed_metrics[metric_name] = []

        parsed_metrics[metric_name].append(
            {
                "value": val,
                "labels": metric_labels
            })

    return parsed_metrics


def extract_labels(metric: str) -> (str, Dict):
    """Parse a metric into a dictionary.

    Convert
        metric{key1="val1",key2="val2"}
    into a dictionary like
        {
            "key1": "val1",
            "key2": "val2"
        }
    Returns the name of the metric and their additional labels.
    """
    splited_metric = metric.split("{")  # Extract the rest of the fields
    if len(splited_metric) == 1:
        return metric, {}  # No additional fields
    elif len(splited_metric) == 2:
        metric_name, labels = splited_metric
        if labels[-1] != "}":
            # Unexpected format
            return metric_name, {}
        labels = labels[:-1]  # remove trailing "}"
        out = {}
        for pair_of_key_var in labels.split(","):
            pair_of_key_var = pair_of_key_var.replace(
                '"', '')  # Remove additional captions
            key, val = pair_of_key_var.split("=")
            out[key] = val
        return metric_name, out

    else:
        # This is not supposed to happen, so just ignore it
        return "", {}


def compare(operation, a, b):
    """Compare {a} and {b} with {operation}.

    Valid operations:
        - lower than: "<"
        - greater than: ">"
        - equal to: "=="
        - not equal to: "!="
    """
    if operation == "lower than":
        return a < b
    elif operation == "greater than":
        return a > b
    elif operation == "equal to":
        return a == b
    elif operation == "not equal to":
        return a != b
    raise ValueError(f"Invalid operation {operation}")


def assert_metric_with_label(context, metric, operation, value, label, label_value):
    """Check a metric in the Pushgateway taking in account the label.

    Make sure a metric {metric} has value {value} in {context.metrics}
    dictionary for the given {label} and {label_value}. The value is compared
    using the operation parameter.
    """
    assert metric in context.metrics, \
        f"Metric {metric} not found in {context.metrics.keys()}"

    for sub_metric in context.metrics[metric]:
        if not compare(operation, sub_metric["value"], value):
            continue
        if not sub_metric["labels"][label] == label_value:
            continue
        return
    assert False, \
        f"Couldn't find metric {metric} {operation} {value} and label " + \
        f"{label} as {label_value} in:\n{pformat(context.metrics[metric])}."
