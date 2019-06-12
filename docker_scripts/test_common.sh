#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# If /opt/curl has not been mounted into the Docker container, then fail the
# build.
if [[ ! -d /opt/curl ]]
then
  echo "Mount a curl root directory into the Docker container"
  echo "by using -v <path to curl root>:/opt/curl"
  exit 1
fi

# Run the buildconf script.
pushd /opt/curl
./buildconf
popd

# Set MAKEFLAGS to the number of processors.
export MAKEFLAGS+=-j$(nproc)
