#!/bin/bash

set -e

echo "Setting up Enode Python environment..."

apt-get update
apt-get install -y python3-venv

python3 -m venv venv

./venv/bin/pip install --upgrade pip
./venv/bin/pip install flask gunicorn python-dotenv mysql-connector-python

ENV_FILE=".env"
if [[ ! -f $ENV_FILE ]]; then
    echo "Creating .env file..."
    cat <<EOF > $ENV_FILE
DB_HOST=database-mysql.ctl4ffo64vfd.us-east-1.rds.amazonaws.com
DB_USER=admin
DB_PASS=Passw0rd
DB_NAME=enode
EOF
else
    echo ".env file already exists, skipping creation."
fi

if [[ -f requirements.txt ]]; then
    ./venv/bin/pip install -r requirements.txt
else
    echo "requirements.txt not found, skipping installation."
fi