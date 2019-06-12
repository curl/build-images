#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install the tool needed for `add-apt-repository`.
apt-get -y update
apt-get -y install --no-install-recommends software-properties-common

# Install wget to download files.
apt-get -y install --no-install-recommends wget

# Install common build dependencies
apt-get -y install --no-install-recommends make \
                                           pkg-config \
                                           autoconf \
                                           libtool \
                                           valgrind \
                                           automake
