#!/bin/bash
set -e

# Kiểm tra và cài đặt các yêu cầu từ requirements.txt
if [ -e "/opt/airflow/requirements.txt" ]; then
  python -m pip install --upgrade pip
  pip install --user -r /opt/airflow/requirements.txt
fi

# Khởi tạo cơ sở dữ liệu Airflow và tạo người dùng admin nếu chưa có
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email tvh25082004@gmail.com \
    --password admin
fi

# Cập nhật cơ sở dữ liệu Airflow
airflow db upgrade

# Chạy Airflow webserver
exec airflow webserver
