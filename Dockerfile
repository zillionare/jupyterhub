FROM ubuntu:focal
MAINTAINER Aaron_Yang

VOLUME ["/notebooks"]
ENV PYPI_INDEX_URL=https://mirrors.aliyun.com/pypi/simple
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /
COPY rootfs ./

RUN apt-get update \
        && apt-get install -qq --no-install-recommends -y openssh-server wget  git \
        && apt-get install -qq --no-install-recommends -y python3.8 python3-pip build-essential  vim iputils-ping  npm nodejs libssl-dev libcurl4-openssl-dev python3.8-dev \
        && ln -s /usr/bin/python3 /usr/bin/python \
        && mkdir /var/run/sshd \
        && (echo 'root:root' | chpasswd) \
        && npm install -g configurable-http-proxy \
        && chmod 700 /root/.ssh \
        && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
        && pip install jupyterhub \
        && pip install jupyterlab \
        && pip install notebook \
        && pip install jupyterhub-idle-culler \
        && pip install pycurl \
        && mkdir -p /etc/jupyterhub \
        && jupyterhub --generate-config \
        && mv jupyterhub_config.py /etc/jupyterhub/config.py \
        && cat /root/config.py >> /etc/jupyterhub/config.py \
        && cat /root/ta-lib-0.4.0-src.tar.gz | tar -xzv -C /tmp/ \
        && cd /tmp/ta-lib \
        && ./configure --prefix=/usr \
        && make \
        && make install \
        && pip install --pre zillionare-omicron \
	    && (echo "PermitRootLogin yes" >> /etc/ssh/sshd_config) \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && useradd -ms /bin/bash admin \
        && (echo 'admin:admin' | chpasswd)

expose 22
expose 3181
expose 3180
expose 8081

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
