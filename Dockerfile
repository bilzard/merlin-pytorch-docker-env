FROM nvcr.io/nvidia/merlin/merlin-pytorch:22.11

WORKDIR /merlin/working
RUN mkdir -p /merlin/input
COPY ./artifact/jupyter_lab_config.py /merlin/.

RUN apt update && apt upgrade -y
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
  && apt install -y nodejs

COPY ./artifact/requirements.txt /merlin/.
RUN pip install -U pip && pip install -r /merlin/requirements.txt
RUN pip freeze >| /merlin/requirements.lock

RUN jupyter labextension install jupyterlab-plotly

RUN mkdir -p /usr/local/share/jupyter/lab/settings
COPY ./artifact/overrides.json /usr/local/share/jupyter/lab/settings/.
