#!/bin/bash

set -exuo pipefail

# Download, compile and install libidn2.
pushd /tmp
curl -L https://ftp.gnu.org/gnu/libidn/libidn2-2.0.4.tar.gz | tar -xzvf -
pushd libidn2-2.0.4
./configure --prefix=/usr
make
make install
popd

# Clean up afterwards.
rm -rf libidn2-2.0.4
popd
