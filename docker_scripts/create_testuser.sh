#!/usr/bin/env bash

set -euxo pipefail

# Create a user for running tests if it doesn't exist.
if ! id -u testuser
then
  useradd -ms /bin/bash testuser
  echo "testuser:testuser" | chpasswd
fi
