#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install the necessary repositories for newer gccs:
# - ubuntu-toolchain-r-test
add-apt-repository ppa:ubuntu-toolchain-r/test

# Install gcc-8. Only install dependencies, not recommendations.
apt-get -y update
apt-get -y install --no-install-recommends gcc-8 g++-8

# Install gcc-8 as the standard cc and g++-8 as the standard c++
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 10
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 10
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
update-alternatives --set cc /usr/bin/gcc
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
update-alternatives --set c++ /usr/bin/g++
