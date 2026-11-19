FROM gitea/runner:6.0.0@sha256:f9a1f17484398b861c25a763b81febfb394b17b72e0522c25d8067d7b484f347

LABEL maintainer="hal@halsbox.io"
LABEL description="Gitea Runner with Node.js, Ansible and Python packages"

ENV ANSIBLE_VENV=/opt/ansible
ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"

COPY requirements.txt requirements-build.txt /tmp/

RUN apk add --no-cache \
        curl=8.23.0-r0 \
        libssh=0.12.2-r0 \
        net-snmp-tools=5.9.5.2-r0 \
        nodejs=24.22.3-r0 \
        openssh=10.3_p1-r2 \
        py3-virtualenv=21.3.3-r0 \
        python3=3.14.10-r1 \
        sshpass=1.10-r0 && \
    apk add --no-cache --virtual .build-deps \
        build-base=0.5-r4 \
        libffi-dev=3.5.2-r1 \
        libssh-dev=0.12.2-r0 \
        openssl-dev=3.5.9-r1 \
        pkgconf=2.5.1-r0 \
        python3-dev=3.14.10-r1 && \
    virtualenv "${ANSIBLE_VENV}" && \
    "${ANSIBLE_VENV}/bin/pip" install --no-cache-dir --require-hashes -r /tmp/requirements-build.txt && \
    "${ANSIBLE_VENV}/bin/pip" install --no-cache-dir --no-build-isolation --require-hashes -r /tmp/requirements.txt && \
    rm -f /tmp/requirements-build.txt /tmp/requirements.txt && \
    apk del .build-deps
