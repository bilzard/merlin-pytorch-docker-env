FROM nvcr.io/nvidia/merlin/merlin-pytorch:22.12

RUN apt update && apt upgrade -y

WORKDIR /merlin
# install requirements
COPY ./artifact/requirements.txt .
RUN pip install -U pip && pip install -r requirements.txt
RUN pip freeze >| requirements.lock

RUN mkdir -p /usr/local/share/jupyter/lab/settings
COPY ./artifact/overrides.json /usr/local/share/jupyter/lab/settings/.

RUN mkdir -p /root/.ipython/profile_default
COPY ./artifact/ipython_config.py /root/.ipython/profile_default/.

COPY ./artifact/gitignore_global /root/.gitignore_global
COPY ./artifact/jupyter_lab_config.py .
