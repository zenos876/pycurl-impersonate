# pycurl-impersonate

基于 https://github.com/ycq0125/pycurl/tarball/master 魔改过的 pycurl, 以 curl-impersonate 为基础镜像编译 pycurl。
构建完成的 wheel 在 /build/*.whl

## 构建

`docker build -t pycurl-impersonate:0.5.3-chrome-slim-bullseye .`
