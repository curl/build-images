#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install --with-gssapi and --with-libssh2 development packages.
apt-get -y install --no-install-recommends krb5-user libkrb5-dev libssh2-1-dev

# Install --with-gssapi and --with-libssh2 test packages.
apt-get -y install --no-install-recommends openssh-server

