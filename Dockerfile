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
        curl \
	net-snmp-tools && \
    apk add --no-cache --virtual .build-deps \
        build-base \
        python3-dev \
        pkgconfig \
        libffi-dev \
        libssh-dev \
        openssl-dev && \
    pip3 install --upgrade pip setuptools --break-system-packages

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt --break-system-packages && \
    pip3 install --break-system-packages --user ansible-pylibssh && \
    rm /tmp/requirements.txt && \
    apk del .build-deps
