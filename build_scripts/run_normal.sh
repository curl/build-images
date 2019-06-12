#!/usr/bin/env bash

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# Get the inputs to this script.
IMAGE_NAME=${1}
CURL_DIR=${2}

# Shift the arguments along so we can pass $@ to the docker container.
shift 2

# Derive the full name of the image.
FULL_IMAGE_NAME=${DOCKER_REPO}/${IMAGE_NAME}:${VERSION}

# If we need to run with special environment variables, check now.
ENV_CHECKSRC=

if [[ -n ${CHECKSRC:-} ]]
then
  ENV_CHECKSRC="-e CHECKSRC=1"
fi

# Finally, just run the docker test.
docker run --rm -it $ENV_CHECKSRC -v ${CURL_DIR}:/opt/curl ${FULL_IMAGE_NAME} /scripts/test_normal.sh $@
