"""Steps implementation for parquet-factory features, related to parquet files."""

from behave import then

import pandas as pd

from src.minio import read_object_into_bytes_buffer


@then("The parquet file {object_name} is exactly this one")
def check_parquet_table_is(context, object_name):
    """Check that the parquet table is exactly the one in context."""
    data = read_object_into_bytes_buffer(context, object_name)
    got_df = pd.read_parquet(data, engine="pyarrow")
    got_df = decode_df(got_df)

    want_df = gherkin_table_to_df(context.table)
    got_df = got_df.astype(str)  # in order to have same format as in want_df

    want_df = want_df.sort_values(
        by=["archive_path"], ascending=False).reset_index(drop=True)
    got_df = got_df.sort_values(
        by=["archive_path"], ascending=False).reset_index(drop=True)

    assert want_df.equals(got_df), f"Got:\n{got_df}\nwant:\n{want_df}"


def decode_df(df):
    """Decode all bytes column into strings."""
    str_df = df.select_dtypes([object])
    str_df = str_df.stack().str.decode("utf-8").unstack()

    for col in str_df:
        df[col] = str_df[col]
    return df


def gherkin_table_to_df(table):
    """Convert a Gherkin table into a Pandas Dataframe.

    _Args:
        table (behave.model.Table): the Gherkin table.

    _Returns:
        pandas.DataFrame: the table as a Dataframe
    """
    return pd.DataFrame(table, columns=table.headings)
