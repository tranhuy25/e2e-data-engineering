#!/bin/bash
set -e

# Upgrade pip and install requirements
if [ -e "/opt/airflow/requirements.txt" ]; then
  /usr/local/bin/python -m pip install --upgrade pip
  /usr/local/bin/pip install -r /opt/airflow/requirements.txt
fi

# Initialize the Airflow database and create admin user if not exists
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init && \
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@example.com \
    --password admin
fi

# Upgrade the Airflow database schema
airflow db upgrade

# Start the Airflow webserver
exec airflow webserver
