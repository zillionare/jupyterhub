FROM ubuntu:focal
MAINTAINER Aaron_Yang

ENV user=aaron
ENV password=aaron@cH
VOLUME ["/home/$user/notebooks"]
ENV PYPI_INDEX_URL=https://mirrors.aliyun.com/pypi/simple
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /
COPY rootfs ./

RUN apt-get update \
    && apt-get install -qq --no-install-recommends -y wget \
    && apt-get install -qq --no-install-recommends -y python3.8 python3-pip build-essential vim iputils-ping libssl-dev libcurl4-openssl-dev python3.8-dev \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && (echo 'root:root' | chpasswd) \
    && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && pip install jupyterlab quantstats \
    && pip install pycurl Cython==0.29.33 \
    && cat /root/ta-lib-0.4.0-src.tar.gz | tar -xzv -C /tmp/ \
    && cd /tmp/ta-lib \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && pip install --pre zillionare-omicron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

expose 8888

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
