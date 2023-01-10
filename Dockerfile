FROM zenos876/curl-impersonate:0.5.3-chrome-slim-bullseye as builder
# config
RUN cp /build/out/*.so* /usr/local/lib
RUN ldconfig

# pycurl
RUN curl-impersonate-chrome -LJO https://github.com/ycq0125/pycurl/tarball/master \
    && mkdir -p pycurl \
    && tar xzvf *.tar.gz --strip-components 1 -C pycurl \
    && rm -rf *.tar.gz
WORKDIR /pycurl
RUN apt install -y build-essential libssl-dev
RUN python setup.py bdist_wheel --curl-config=/usr/local/bin/curl-impersonate-chrome-config

FROM zenos876/curl-impersonate:0.5.3-chrome-slim-bullseye
COPY --from=builder /pycurl/dist/*.whl /build
RUN pip install /build/*.whl
