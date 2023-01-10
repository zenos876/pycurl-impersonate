FROM zenos876/curl-impersonate:0.5.3-chrome-slim-bullseye
# config
RUN cp /build/out/*.so* /usr/local/lib
RUN ldconfig

# python3
RUN sed -i s@/deb.debian.org/@/repo.huaweicloud.com/@g /etc/apt/sources.list && apt clean && apt update && apt upgrade -y
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN wget https://mirrors.huaweicloud.com/python/3.10.9/Python-3.10.9.tgz && tar -xvf Python-3.10.9.tgz
WORKDIR Python-3.10.9
RUN ./configure --enable-optimizations && make -j 4 && make altinstall
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 2 \
    && update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.10 2

# pycurl
WORKDIR /
RUN curl-impersonate-chrome -LJO https://github.com/ycq0125/pycurl/tarball/master && mkdir -p pycurl && tar xzvf *.tar.gz --strip-components 1 -C pycurl
WORKDIR /pycurl
RUN python setup.py install --curl-config=/usr/local/bin/curl-impersonate-chrome-config

WORKDIR /
RUN rm -rf /pycurl *.tar.gz *.tgz /Python-3.10.9
