#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install the necessary repositories for clang:
# - llvm-toolchain-xenial-7

# Use wget to download the key as we're building curl...
wget http://apt.llvm.org/llvm-snapshot.gpg.key
apt-key add llvm-snapshot.gpg.key
add-apt-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main"

# Install clang7. Only install dependencies, not recommendations.
apt-get -y update
apt-get -y install --no-install-recommends clang-7

# Install clang-7 as the standard cc and clang++-7 as the standard c++
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 10
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-7 10
update-alternatives --install /usr/bin/cc cc /usr/bin/clang 30
update-alternatives --set cc /usr/bin/clang
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 30
update-alternatives --set c++ /usr/bin/clang++
