FROM ubuntu:xenial AS build_step
ARG REPO=https://github.com/GarlicoinOrg/Garlicoin.git
ARG BRANCH=master
LABEL maintainer Ryan Shaw <ryan@rshaw.me>

ENV HOME /garlicoin

RUN \
    apt-get update -y    \
    && 	apt-get install -yq   \
        git                 \
        build-essential     \
        libtool             \
        autotools-dev       \
        automake            \
        pkg-config          \
        libssl-dev          \
        libevent-dev        \
        bsdmainutils        \
        libboost-all-dev    \
        libzmq3-dev         \
		software-properties-common \ 
	&& add-apt-repository ppa:bitcoin/bitcoin \ 
	&& apt-get update \
	&& apt-get install -yq libdb4.8-dev libdb4.8++-dev

RUN git clone -b ${BRANCH} ${REPO} /garlicoin && echo 1

RUN set -ex ; \
	cd /garlicoin ; \
    ldconfig ; \
	./autogen.sh ; \
	./configure --without-gui --disable-tests --disable-bench ; \ 
	make -j2

FROM ubuntu:xenial

ADD ./bin /usr/local/bin

VOLUME ["/root/.garlicoin"]

EXPOSE 42068 42069 42070 42075

WORKDIR /root/.garlicoin

COPY --from=build_step /garlicoin/src/garlicoin* /usr/local/bin/
COPY --from=build_step /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/
COPY --from=build_step /usr/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so
COPY --from=build_step /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /lib/x86_64-linux-gnu/libcrypto.so.1.0.0

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["grlc_oneshot"]
