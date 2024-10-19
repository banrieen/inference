# Linux bash env init
sudo zypper update -y
pip install -r requirements.ini
sudo zypper install -y libgthread-2_0-0
https://download.opensuse.org/repositories/openSUSE:/Factory/standard/x86_64/traefik-2.10.1-1.2.x86_64.rpm
sudo zypper install -y traefik-2.10.1-1.2.x86_64.rpm 
## Sanic will automatically spin up multiple processes and route traffic between them. We recommend as many workers as you have available processors.
## The easiest way to get the maximum CPU performance is to use the --fast option. This will automatically run the maximum number of workers given the system constraints.
# sanic server:app --host=0.0.0.0 --port=1337 --workers=4
sanic server:app --host=0.0.0.0 --port=1337 --reload --debug --single-process

sanic server:app --host=0.0.0.0 --port=1337 --fast
# To run both an HTTP/3 and HTTP/1.1 server simultaneously,
# sanic path.to.server:app --http=3 --http=1
# If you still require access logs, but want to enjoy this performance boost, consider using Nginx as a proxy, and letting that handle your access logging. It will be much faster than anything Python can handle.
# sanic path.to.server:app --no-access-logs

# 
pip install virtualenv
virtualenv Venv
source /Venv/bin/activate
pip install -r requirements
pip install opencv-python

kill -9 `isof -ti:1337`

## python3.12 venv
# py venv init
# sudo zypper install pyenv
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(pyenv init -)"' >> ~/.bashrc
# 
# export PYTHON_BUILD_MIRROR_URL_SKIP_CHECKSUM=1
# export PYTHON_BUILD_MIRROR_URL="https://repo.huaweicloud.com/python/"
# env PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto' PYTHON_CFLAGS='-march=native -mtune=native' pyenv install 3.11.0rc2
# 
# .\generator\Scripts\activate
# pip install -r requirements.ini
# 
# ### Resolve GPK ERROR
# 
# wget -nv https://download.opensuse.org/repositories/home:strycore/xUbuntu_18.04/Release.key -O Release.key
# sudo apt-key add - < Release.key
# sudo apt update 
# ## remote test env
# ## update python 3.11
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt update 
# sudo apt install -y python3.11
# # Set Python 3.11 as default
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 110
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 100
# sudo update-alternatives --config python3
# 
# ssh thomas@192.168.10.156 -p22
# thomas/thomas2023!

# Install gradio
python -m pip install --upgrade setuptools
pip install gradio