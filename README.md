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


















Example of .env located in enode-docker/db/.env

```.env
MYSQL_ROOT_PASSWORD: ###
MYSQL_DATABASE: ###
MYSQL_USER: ###
MYSQL_PASSWORD: ###
```
Example of .env located in enode-docker/python/.env
```.env
DB_HOST=13.216.27.150
DB_USER=root
DB_PASS=Passw0rd
DB_NAME=enode_demo

ENODE_WEBHOOK_SECRET=85pEtSKJojh7UaitSsh2AlZRlt2D02NcpqDVsZW_9f8
ENODE_CLIENT_ID=503bf672-ffcf-440a-bc5d-b50d230753ba
ENODE_CLIENT_SECRET=06a969bb3248affe9deff4dca586c1b26ce776ae
```
