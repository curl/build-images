#!/usr/bin/env bash

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# Build stage 1. Stage 1 consists of the root base image with some common tools installed.
echo "Building stage 1 (version ${VERSION})"

# Build the root base image from Xenial
build_image base_image ubuntu:xenial-20190515 install_base_tools.sh


# On Travis, push the images.
if [[ -n "${TRAVIS:-}" ]]
then
  push_image_versioned base_image
fi
