FROM gitea/act_runner:latest

LABEL maintainer="hal@halsbox.io"
LABEL description="Gitea Act Runner with Nodejs, Ansible and Python packages"

RUN apk update && \
    apk add --no-cache \
        nodejs \
        python3 \
        py3-pip \
        py3-virtualenv \
        openssh \
        sshpass \
        curl && \
    pip3 install --upgrade pip setuptools --break-system-packages

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt --break-system-packages && rm /tmp/requirements.txt
