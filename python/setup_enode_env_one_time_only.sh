#!/bin/bash

set -e

apt-get update
apt-get install -y python3-pip

pip3 install --upgrade pip
pip3 install flask gunicorn python-dotenv mysql-connector-python

if [[ -f requirements.txt ]]; then
    pip3 install -r requirements.txt
else
    echo "requirements.txt not found, skipping installation."
fi
