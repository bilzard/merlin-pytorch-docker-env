FROM nvcr.io/nvidia/merlin/merlin-pytorch:22.11

WORKDIR /merlin/working
RUN mkdir -p /merlin/input
COPY ./artifact/jupyter_lab_config.py /merlin/.

RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
  && apt-get install -y nodejs

RUN pip install -U pip && pip install \
    fastprogress \
    japanize-matplotlib \
    nb-black \
    jupyterlab_materialdarker \
    IProgress \
    ipywidgets \
    jupyterlab-nvdashboard \
    bokeh==2.4.1 \
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash


RUN pip freeze >| /merlin/requirements.lock

RUN jupyter labextension install jupyterlab-plotly

RUN mkdir -p /usr/local/share/jupyter/lab/settings
COPY ./artifact/overrides.json /usr/local/share/jupyter/lab/settings/.
