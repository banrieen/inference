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

# Python 环节管理
uv venv
source .env/bin/activate
uv add opencv-python

kill -9 `isof -ti:1337`

## Start mlflow server
uv add mlflow
/home/thomas/workspace/inference/.venv/bin/mlflow ui -h 0.0.0.0 -p 8083  --default-artifact-root /home/thomas/workspace/mlruns &
# sudo kill -9 $(sudo lsof -t -i :8083)

# Install gradio, ffor cv test and demo
uv add gradio

## Install and start Ray on local

uv add ray[default]
ray 

## 安装或更新 ollama 
curl -fsSL https://ollama.com/install.sh | sh

## autoagent studio
uv add autogen-agentchat
uv add autogenstudio
### create database and public user
CREATE USER autogen WITH PASSWORD 'autogen';
CREATE DATABASE autogenstudio OWNER autogen;
ALTER USER autogen WITH PASSWORD 'autogen2025';
\q
## assert the connection:　psql -h 10.0.56.113 -U autogen -d autogenstudio
# GRANT ALL PRIVILEGES ON DATABASE autogenstudio TO autogen;
# GRANT CONNECT ON DATABASE autogenstudio TO autogen;
# GRANT USAGE ON SCHEMA public TO autogen;
# GRANT CREATE ON SCHEMA public TO autogen;
##  强制断开所有数据库连接[1,7](@ref)
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE datname = 'autogenstudio';
## DROP DATABASE IF EXISTS autogenstudio-test;

### Start autogen dev service
# 使用bash 变量链接可能出现数据库认证错误
# 如果删除数据库，重新创建之后，需要再次修改数据库登录账号的密码

HOST=10.0.56.113
PORT=8081
DatabaseName=autogenstudio
Workspace="/home/thomas/workspace/autogenstudio"
DatabaseURL=postgresql+psycopg://autogen:autogen2025@10.0.56.113:5432/autogenstudio
#           postgresql+psycopg://user:password@localhost/dbname
autogenstudio ui --appdir /home/thomas/workspace/autogenstudio  \
                 --host 10.0.56.113 \
                 --port 8081 \
                 --database-uri postgresql+psycopg://autogen:autogen2025@10.0.56.113:5432/autogenstudio  &


## K3S 最小化部署
存储 minIO
数据库 postgresql
缓存（可选）
向量数据库
知识库
应用和组件服务
模型服务

