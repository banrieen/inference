# Linux bash env init
# Host system Debian12 
sudo apt update -y
sudo apt install redis-server -y
## Sanic will automatically spin up multiple processes and route traffic between them. We recommend as many workers as you have available processors.
## The easiest way to get the maximum CPU performance is to use the --fast option. This will automatically run the maximum number of workers given the system constraints.
# sanic server:app --host=0.0.0.0 --port=1337 --workers=4
sanic server:app --host=0.0.0.0 --port=1337 --reload --debug --single-process

sanic server:app --host=0.0.0.0 --port=1337 --fast
# To run both an HTTP/3 and HTTP/1.1 server simultaneously,
# sanic path.to.server:app --http=3 --http=1
# If you still require access logs, but want to enjoy this performance boost, consider using Nginx as a proxy, and letting that handle your access logging. It will be much faster than anything Python can handle.
# sanic path.to.server:app --no-access-logs

# Python 环境管理
uv venv
source .env/bin/activate
uv add opencv-python

kill -9 `isof -ti:1337`

## Mlflow server 
uv add mlflow
mlflow server --host 127.0.0.1 --port 8083

## use podman start the postgres DB on host system windows11
cd workspace
podman volume create postgres_data
podman run -d \
  --name postgresql \
  -e POSTGRES_USER=banrieen \
  -e POSTGRES_PASSWORD=banrieen@2025 \
  -e POSTGRES_DB=agentDB \
  -p 5432:5432 \
  -v \
  
、、:/var/lib/postgresql/data \
  --restart=unless-stopped \
  docker.1ms.run/library/postgres:latest


## Install and start Ray on local
# uv add ray[default]
# ray 

# ## 安装或更新 ollama 
# curl -fsSL https://ollama.com/install.sh | sh

## autoagent studio
uv add autogen-agentchat
uv add autogenstudio
### create database and public user
CREATE USER autogen WITH PASSWORD 'autogen';
CREATE DATABASE autogenstudio OWNER autogen;
ALTER USER autogen WITH PASSWORD 'autogen';
\q
# GRANT ALL PRIVILEGES ON DATABASE inference TO thomas;
# GRANT CONNECT ON DATABASE inference TO thomas;
# GRANT USAGE ON SCHEMA public TO thomas;
# GRANT CREATE ON SCHEMA public TO thomas;

### Start dev service
HOST=192.168.124.17
PORT=8081
DatabaseName=autogenstudio
Workspace="~/workspace/.autogenstudio"
DatabaseURL=postgresql+psycopg://autogen:autogen@${HOST}/${DatabaseName}
autogenstudio ui --appdir ${Workspace} --host ${HOST} --port ${PORT} --database-uri ${DatabaseURL}  &
## autogenstudio ui --appdir ${Workspace} --host ${HOST} --port ${PORT}

## vllm
# uv pip install vllm

# ## 使用 huggingface 国内镜像下载模型
# uv add huggingface_hub
# $env:HF_ENDPOINT = "https://hf-mirror.com"
# huggingface-cli download --resume-download "meta-llama/Llama-4-Scout-17B-16E-Instruct" --local-dir llama4

# 本地 podman 使用文档 file:///C:/Program%20Files/RedHat/Podman/podman-for-windows.html