# Dockerfile
FROM apache/airflow:2.10.4

# Switch to root to install system dependencies (if needed, usually not for pure python)
USER airflow

# Install the Spark and Trino providers once, permanently
RUN pip install --no-cache-dir \
    apache-airflow-providers-apache-spark \
    apache-airflow-providers-trino