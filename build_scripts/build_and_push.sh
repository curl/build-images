#!/usr/bin/env bash

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# The first argument is the tag. This should match a repository in Docker and
# is the "name" of the image.
TAG=${1}

# The second argument is the base image. This is what the image is built on top
# of.
BASE_IMAGE=${2}

# The third argument is the build script. This is run inside Docker to install
# the new files.
DOCKER_SCRIPT=${3}

# Use the common script functionality to build the image.
build_image_versioned ${TAG} ${BASE_IMAGE} ${DOCKER_SCRIPT}

# On Travis, push the newly generated image if possible.
if [[ -n "${TRAVIS:-}" ]]
then
  push_image_versioned ${TAG}
fi
