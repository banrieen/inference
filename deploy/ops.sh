# Linux bash env init
# Host system Debian12 
sudo apt update -y

## Sanic will automatically spin up multiple processes and route traffic between them. We recommend as many workers as you have available processors.
## The easiest way to get the maximum CPU performance is to use the --fast option. This will automatically run the maximum number of workers given the system constraints.
# sanic server:app --host=0.0.0.0 --port=1337 --workers=4
sanic server:app --host=0.0.0.0 --port=1337 --reload --debug --single-process

sanic server:app --host=0.0.0.0 --port=1337 --fast
# To run both an HTTP/3 and HTTP/1.1 server simultaneously,
# sanic path.to.server:app --http=3 --http=1
# If you still require access logs, but want to enjoy this performance boost, consider using Nginx as a proxy, and letting that handle your access logging. It will be much faster than anything Python can handle.
# sanic path.to.server:app --no-access-logs

# Python 环节管理
uv venv
source .env/bin/activate
uv add opencv-python

kill -9 `isof -ti:1337`

## Start mlflow server
uv add mlflow
mlflow ui -h 10.0.56.113 -p 5000


# Install gradio, ffor cv test and demo
# uv add gradio

## Install and start Ray on local

# uv add ray[default]
# ray 

## 安装或更新 ollama 
# curl -fsSL https://ollama.com/install.sh | sh

## autoagent studio
uv add autogen-agentchat
uv add autogenstudio

### create database and public user
podman run -d --name=agentDB   -e POSTGRES_USER=banrieen   -e POSTGRES_PASSWORD=banrieen@2025   -e POSTGRES_DB=appdb   -v C:\\workspace\\postgres-data:/var/lib/postgresql/data   -p 6543:5432   --restart=unless-stopped   docker.1ms.run/library/postgres:latest  
podman exec -it agentDB psql -U admbanrieenin -d appdb  # 进入容器内命令行
# 推荐使用 Alpine 精简版

CREATE USER autogen WITH PASSWORD 'autogen';
CREATE DATABASE autogenstudio OWNER autogen;
ALTER USER autogen WITH PASSWORD 'autogen';
\q
# GRANT ALL PRIVILEGES ON DATABASE inference TO thomas;
# GRANT CONNECT ON DATABASE inference TO thomas;
# GRANT USAGE ON SCHEMA public TO thomas;
# GRANT CREATE ON SCHEMA public TO thomas;

### Start dev service
#### HOST=10.0.56.113
HOST=192.168.124.12
PORT=8081
DatabaseName=autogenstudio
Workspace="~/workspace/autogenstudio"
DatabaseURL=postgresql+psycopg://autogen:autogen@6543/${DatabaseName}
autogenstudio ui --appdir ${Workspace} --host ${HOST} --port ${PORT} --database-uri ${DatabaseURL}  &

# Knowledge graph database

sudo podman run -d -it -p 8080:8080 -p 9080:9080 -v ~/dgraph:/dgraph docker.xuanyuan.me/dgraph/standalone:latest

## GUI client
podman run -p 8010:8010 docker.xuanyuan.me/dgraph/ratel:latest

## Multi LLM chat DB
CREATE DATABASE llmChat OWNER autogen;
ALTER USER autogen WITH PASSWORD 'autogen';
\q