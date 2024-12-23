#!/usr/bin/env bash
set -e
pip install virtualenv
virtualenv Venv
source "Venv/bin/activate"
pip install -r requirements.ini
pip install opencv-python
sudo  killall -9 sanic
sudo kill -9 `lsof -ti:1337`
sanic server:app --host=0.0.0.0 --port=1337 --fast 
