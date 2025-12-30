import duckdb
import pandas as pd

pd.set_option("display.max_columns", None)
pd.set_option("display.max_colwidth", None)
pd.set_option("display.width", 0)  # auto-fit

con = duckdb.connect("/home/dbt/dbt_sample/dbt_sample.duckdb")
print(con.execute("SELECT version()").fetchall())

print(con.execute("SELECT schema_name FROM information_schema.schemata").fetchall())

print(con.execute("select * from main.stg_customers").fetchdf())
print(con.execute("select * from snapshots.customers_snapshot").fetchdf())
