FROM apache/airflow:3.1.8-python3.12

USER airflow

RUN pip install --no-cache-dir \
    "dbt-postgres==1.9.1" \
    "dbt-duckdb==1.11.0" \
    "duckdb==1.5.5" \
    "astronomer-cosmos==1.15.1" \
    apache-airflow-providers-fab