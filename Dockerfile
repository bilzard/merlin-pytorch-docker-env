FROM nvcr.io/nvidia/merlin/merlin-pytorch:22.11

WORKDIR /merlin/working
RUN mkdir -p /merlin/input
COPY ./artifact/jupyter_lab_config.py /merlin/.

RUN pip install -U pip && pip install \
    fastprogress \
    japanize-matplotlib \
    nb-black \
    jupyterlab_materialdarker \
    IProgress \
    ipywidgets

RUN pip freeze >| /merlin/requirements.lock

RUN mkdir -p /usr/local/share/jupyter/lab/settings
COPY ./artifact/overrides.json /usr/local/share/jupyter/lab/settings/.
