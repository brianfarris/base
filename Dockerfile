FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y git vim make curl python3 python3-pip && \
    git clone --depth=1 https://github.com/amix/vimrc.git /root/.vim_runtime && \
    sh /root/.vim_runtime/install_awesome_vimrc.sh && \
    git clone https://github.com/magicmonty/bash-git-prompt.git /root/.bash-git-prompt --depth=1 && \
    echo "# git prompt" >> /root/.bashrc && \
    echo "GIT_PROMPT_ONLY_IN_REPO=1" >> /root/.bashrc && \
    echo "source /root/.bash-git-prompt/gitprompt.sh" >> /root/.bashrc && \
    echo "GIT_PROMPT_THEME=Solarized" >> /root/.bashrc

RUN pip3 install --upgrade pip
RUN pip install virtualenv virtualenvwrapper
ENV WORKON_HOME /root/.virtualenvs
ENV PROJECT_HOME /src
ENV VIRTUALENVWRAPPER_PYTHON /usr/bin/python3
RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh"
RUN echo "source /usr/local/bin/virtualenvwrapper.sh" >> /root/.bashrc
RUN echo "export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'" >> /root/.bashrc

RUN echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /root/.bashrc

RUN pip install flake8 flake8-docstrings
COPY my_configs.vim /root/.vim_runtime/
WORKDIR /src
