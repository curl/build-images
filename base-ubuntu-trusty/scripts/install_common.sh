#!/bin/bash

# Install common dependencies
apt-get -y install make \
                   pkg-config \
                   autoconf \
                   libtool \
                   valgrind \
                   libev-dev \
                   libc-ares-dev \
                   libstdc++-7-dev \
                   stunnel4 \
                   libssh2-1-dev \
                   libssh-dev \
                   krb5-user \
                   autopoint \
                   libunistring-dev \
                   python
