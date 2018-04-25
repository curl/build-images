#!/bin/bash

set -exuo pipefail

# Download, compile and install libpsl.
pushd /tmp
curl -L https://github.com/rockdaboot/libpsl/releases/download/libpsl-0.20.1/libpsl-0.20.1.tar.gz | tar -xzvf -
pushd libpsl-0.20.1
autoreconf -i
./configure --prefix=/usr
make
make install
popd

# Clean up afterwards.
rm -rf libpsl-0.20.1
popd
