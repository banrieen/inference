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
uv add  -r requirements
uv add opencv-python

kill -9 `isof -ti:1337`

## Start mlflow server
uv add mlflow
mlflow ui -h 10.0.56.113 -p 5000


## Start ray 


# Install gradio, ffor cv test and demo
uv add gradio

## Install and start Ray on local

uv add ray[default]
ray 

## 安装或更新 ollama 
curl -fsSL https://ollama.com/install.sh | sh

## autoagent studio
uv add autogen-agentchat~=0.2
uv add autogenstudio
### create database and public user
CREATE DATABASE autogen;
CREATE USER thomas WITH PASSWORD 'thomas';
GRANT ALL PRIVILEGES ON DATABASE autogen TO thomas;
GRANT CONNECT ON DATABASE autogen TO thomas;
GRANT USAGE ON SCHEMA public TO thomas;
GRANT CREATE ON SCHEMA public TO thomas;

### autogenstudio ui --host 10.0.56.113 --port 8081 & 
mkdir -p ~/workspace/autogenstudio
HOST=192.168.124.12
autogenstudio ui --appdir ~/workspace/autogenstudio --reload  --host $HOST --port 8081 --database-uri postgresql+psycopg://thomas:thomas@$HOST/autogenstudio &
