#!/bin/bash
#
# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Define a set of temporary docker packages used during docker building.
DOCKER_BUILD_PACKAGES="software-properties-common curl"

# Update APT so we can install packages.
apt-get -y update

# Install temporary build packages
apt-get -y install $DOCKER_BUILD_PACKAGES

# Install the necessary repositories:
# - ubuntu-toolchain-r-test
add-apt-repository ppa:ubuntu-toolchain-r/test

# Install all necessary packages for curl building
apt-get -y update
bash /scripts/install_common.sh
apt-get -y install gcc-7 g++-7

# Install gcc-7 as the standard cc and g++-7 as the standard c++
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
update-alternatives --set cc /usr/bin/gcc
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
update-alternatives --set c++ /usr/bin/g++

# Download, compile and install other libraries.
/scripts/install_nghttp2.sh
/scripts/install_libidn2.sh
/scripts/install_libpsl.sh

# Remove the temporary build packages and any auto-installed dependencies
apt-get --purge -y remove $DOCKER_BUILD_PACKAGES
apt-get -y autoremove

# Removing any apt cache data.
rm -rf /var/lib/apt/lists/*
