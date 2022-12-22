FROM nvcr.io/nvidia/merlin/merlin-pytorch:22.11

WORKDIR /merlin/working
RUN mkdir -p /merlin/input
COPY ./artifact/jupyter_lab_config.py /merlin/.

RUN apt update && apt upgrade -y
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
  && apt install -y nodejs

# fish
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt update && \
    apt install -y fish && \
    chsh -s /usr/bin/fish

# fisher
SHELL ["/usr/bin/fish", "-c"]
RUN curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && \
    apt install -y fonts-powerline && \
    fisher install oh-my-fish/theme-bobthefish && \
    fisher install jethrokuan/z
SHELL ["/usr/bin/bash", "-c"]

# install diff-so-fancy
RUN curl -qL https://www.npmjs.com/install.sh | sh && npm install -g diff-so-fancy
RUN echo -e "export LANG=C\nexport LC_ALL=C" >> ~/.bashrc
RUN echo -e "set -x LANG C\nset -x LC_ALL C" >> ~/.config/fish/config.fish

# install requirements
COPY ./artifact/requirements.txt /merlin/.
RUN pip install -U pip && pip install -r /merlin/requirements.txt
RUN pip freeze >| /merlin/requirements.lock
RUN jupyter labextension install jupyterlab-plotly

RUN mkdir -p /usr/local/share/jupyter/lab/settings
COPY ./artifact/overrides.json /usr/local/share/jupyter/lab/settings/.

RUN mkdir -p /root/.ipython/profile_default
COPY ./artifact/ipython_config.py /root/.ipython/profile_default/.

COPY ./artifact/gitignore_global /root/.gitignore_global
