FROM ubuntu:14.04
MAINTAINER Kevin Smyth <kevin.m.smyth@gmail.com>

RUN apt-get -qq update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates dpkg-dev build-essential git-core
ADD . /build

WORKDIR /build

CMD ["bash", "-xe", "build.sh"]
