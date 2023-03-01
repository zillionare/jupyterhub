FROM ubuntu:focal
MAINTAINER Aaron_Yang

ENV PYPI_INDEX_URL=https://mirrors.aliyun.com/pypi/simple
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /
COPY rootfs ./

RUN apt-get update \
        && apt-get install -qq --no-install-recommends -y openssh-server wget  git \
        && apt-get install -qq --no-install-recommends -y python3.10 python3-pip  vim iputils-ping  npm nodejs \
        && mkdir /var/run/sshd \
        && (echo 'root:root' | chpasswd) \
        && npm install -g configurable-http-proxy \
        && chmod 700 /root/.ssh \
        && bash /root/miniconda.sh -b -p /conda \
        && /conda/bin/conda init \
        && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
        && pip install jupyterhub \
        && pip install jupyterlab \
        && pip install notebook \
        && pip install jupyterhub-idle-culler \
	    && (echo "PermitRootLogin yes" >> /etc/ssh/sshd_config) \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && useradd -ms /bin/bash admin \
        && (echo 'admin:M@cao123' | chpasswd)


expose 22
expose 3180-3184 
expose 8081

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
