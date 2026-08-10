FROM apache/airflow:3.1.8-python3.12

USER airflow

RUN pip install --no-cache-dir \
    "dbt-postgres<1.10" \
    "astronomer-cosmos>=1.9.0" \
    apache-airflow-providers-fab
    