# enode-docker

## Overview

This project provides a production-ready, containerized environment for running a Python application behind an NGINX reverse proxy with a MySQL database for persistent storage. The stack is designed to handle data sent from the Enode API to a webhook hosted on Postman. Incoming webhook requests are received by the NGINX reverse proxy, routed securely to the Python backend, which processes the data and stores it in the MySQL database.

## Prerequisites

- [Docker](https://www.docker.com/) / [Docker Compose](https://docs.docker.com/compose/)
- Webhook - Can be created via [Postman](https://www.postman.com/)
- Public DNS Name - Can be requested via [No-IP](https://www.noip.com/)
- Certbot
- Open ports `443` and `3306` on your host machine

## Architecture

**Services:**

1. **Reverse Proxy (NGINX)**
- Builds from: `./nginx/.`
- Exposes port `443`  
- Handles HTTPS and routes traffic to the app
- Static IP: `192.168.1.10`

2. **Application (Python)**  
- Builds from: `./python/.`  
- Uses `.env` in `./python/` for configuration  
- Static IP: `192.168.1.15`

3️. **Database (MySQL)**  
- Image: `mysql:8.0`  
- Data persisted at `./db/enodedata/`  
- Uses `.env` in `./db/` for credentials/config  
- Exposes port `3306`  
- Static IP: `192.168.1.20`

All services run on a custom bridge network `enodenet` with subnet `192.168.1.0/24`.

## Installation

1. **Clone the repo:**

   ```bash
   git clone https://github.com/jvieira9/enode-docker.git
   cd enode-docker
   ```

2. **Obtain DNS Name:**

- Associate your host machine's IP address to a DNS Name, this can be done via [No-IP](https://www.noip.com/)

3. **Generate certificate:**

- You can generate your certificate via Certbot:

Before executing the next commands, your host machine and NGINX container need to have port 80 open, so that Certbot can check the website's existence. The port can be closed after the process is complete.

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx
```
After generating the certificate, tranfer the files `fullchain.pem` `options-ssl-nginx.conf` `privkey.pem` `ssl-dhparams.pem` to `./enode-docker/nginx/.`

4. **Setup ENODE:**

- Create an [ENODE Account](https://developers.enode.com/)
- Create a new client
- Save the API credentials

5. **Create webhook:**

- Install the [ENODE API Postman Collection](https://enode-api.production.enode.io/postman/latest.json)
- Setup the API Credentials
- Create a webhook, modifying the `body` section and removing the `authentication` block

6. **Create .env files:**

- Modify the two .env files with your data

- Example of `./python/.env` — for your Python app’s environment variables:

```.env
DB_HOST=your_db_user_ip
DB_USER=your_db_user
DB_PASS=your_db_password
DB_NAME=your_db_name

ENODE_WEBHOOK_SECRET=your_webhook_secret
ENODE_CLIENT_ID=your_client_id
ENODE_CLIENT_SECRET=your_client_secret
```

- Example of `./db/.env` — for MySQL root password, database name, user, etc.

```env
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=your_db_name
MYSQL_USER=your_db_user
MYSQL_PASSWORD=your_db_password
```

## Usage

1. Build and start all services:

``` bash
docker-compose up --build -d
```
2. Stop and remove containers:
```bash
docker-compose down
```

## Author

2025 - João Vieira | `jvieira9` on [GitHub](https://github.com/jvieira9)
