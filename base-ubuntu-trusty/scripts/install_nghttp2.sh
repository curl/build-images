#!/bin/bash

set -euxo pipefail

apt-get install -y libcunit1-dev \
                   libjemalloc-dev

# Download, compile and install nghttp2.
pushd /tmp
curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.24.0/nghttp2-1.24.0.tar.gz | tar xzvf -
pushd nghttp2-1.24.0
./configure --prefix=/usr --disable-threads --enable-app
make
make install
popd

# Clean up afterwards.
rm -rf nghttp2-1.24.0
popd
