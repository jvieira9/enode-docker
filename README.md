# enode-docker

A containerized environment for running an application stack with an NGINX reverse proxy, a Python backend, and a MySQL database using Docker Compose.

## 📚 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Directory Structure](#directory-structure)
- [Contributing](#contributing)
- [License](#license)

---

## 📌 Overview

This project provides a production-ready containerized setup for deploying a Python application behind an NGINX reverse proxy, with a MySQL database for persistent storage.

## 🗂️ Architecture

**Services:**

1️⃣ **Reverse Proxy (NGINX)**  
- Builds from: `./nginx/`  
- Exposes port `443`  
- Handles HTTPS and routes traffic to the app.  
- Static IP: `192.168.1.10`

2️⃣ **Application (Python)**  
- Builds from: `./python/`  
- Uses `.env` in `./python/` for configuration  
- Static IP: `192.168.1.15`

3️⃣ **Database (MySQL)**  
- Image: `mysql:8.0`  
- Data persisted at `./db/jvdatamysql/`  
- Uses `.env` in `./db/` for credentials/config  
- Exposes port `3306`  
- Static IP: `192.168.1.20`

All services run on a custom bridge network `jvnet` with subnet `192.168.1.0/24`.

---

## ✅ Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Open ports `443` and `3306` on your host machine

---

## ⚙️ Installation

1. **Clone the repo:**

   ```bash
   git clone https://github.com/jvieira9/enode-docker.git
   cd enode-docker
   ```
2. Create .env files:

- Example of ./python/.env — for your Python app’s environment variables:

```.env
DB_HOST=your_db_user_ip
DB_USER=your_db_user
DB_PASS=your_db_password
DB_NAME=your_db_name

ENODE_WEBHOOK_SECRET=your_webhook_secret
ENODE_CLIENT_ID=your_client_id
ENODE_CLIENT_SECRET=your_client_secret
```

- Example of ./db/.env — for MySQL root password, database name, user, etc.

```.env
**Example `db/.env`:**

```env
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=your_db_name
MYSQL_USER=your_db_user
MYSQL_PASSWORD=your_db_password
```

## 🚀 Usage

1. Build and start all services:

``` bash
docker-compose up --build -d
```
2. Stop and remove containers:
```bash
docker-compose down
``` 
## ⚙️ Configuration
- NGINX:
Place your custom NGINX configuration files in ./nginx/. Make sure your Dockerfile in that folder copies them correctly.

### Python App:
Your application code and dependencies should live in ./python/. Update your Dockerfile there to install dependencies and run the app properly.

Database:
The MySQL database stores its data persistently in ./db/jvdatamysql/. This means your data won’t be lost when containers are stopped or rebuilt.
