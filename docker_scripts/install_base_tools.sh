#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install the tool needed for `add-apt-repository`.
apt-get -y update
apt-get -y install software-properties-common
