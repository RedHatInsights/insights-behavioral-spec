from behave import when

from pushgateway import (
    assert_metric_with_label,
    compare,
    get_metrics,
    reset_metrics,
)


@given('Pushgateway in "{pushgateway_url}" is empty of metrics')
@when('I delete all metrics from "{pushgateway_url}"')
def _reset_metrics(context, pushgateway_url):
    """Delete all metrics in {PUSHGATEWAY_URL}."""
    reset_metrics(pushgateway_url)
    context.metrics = {}


@when('I store the metrics from "{pushgateway_url}"')
def store_metrics(context, pushgateway_url):
    """Store the metrics into context.metrics as a dictionary."""
    context.metrics = get_metrics(pushgateway_url)


@then("Metrics are")
def assert_metrics_table(context):
    """Check a metric given in context is in the Pushgateway.

    It makes sure a metric {metric} has value {value} in {context.metrics}
    dictionary for the given {label} and {label_value}. The value is compared
    using the {operation} parameter. Parameters are read from {context.row}.
    """
    for row in context.table:
        metric = row["metric"]
        operation = row["operation"]
        value = row["value"]
        label = row["label"]
        label_value = row["label_value"]
        if label == "" or label_value == "":
            assert_metric(context, metric, operation, value)
        else:
            assert_metric_with_label(
                context, metric, operation, value, label, label_value)


@then('Metric "{metric}" has value "{operation}" "{value}"')
def assert_metric(context, metric, operation, value):
    """
    Check a metric in the Pushgateway.

    Make sure a metric {metric} has value {value} in {context.metrics}
    dictionary.
    """
    assert metric in context.metrics, \
        f"Metric {metric} not found in {context.metrics.keys()}"

    for sub_metric in context.metrics[metric]:
        if compare(operation, sub_metric["value"], value):
            return
    assert False, \
        f"Couldn't find metric {metric} {operation} {value} in:" + \
        f"\n{pformat(context.metrics[metric])}."


@then('Metric "{metric}" is not registered')
def assert_metric_not_registered(context, metric):
    """Make sure a metric {metric} is not registered."""
    assert metric not in context.metrics, \
        f"Metric {metric} found in {context.metrics.keys()}"
