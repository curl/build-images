#!/usr/bin/env bash

# Get the version from the version file.
export VERSION=$(cat VERSION)

# Use this repository
export DOCKER_REPO=curlbuildimages


# Simple function which uses docker to build images.
build_image()
{
  TAG=$1
  BASE_IMAGE=$2
  DOCKER_SCRIPT=$3

  echo "Building ${TAG}:${VERSION} from ${BASE_IMAGE}"

  docker build --build-arg BASE_IMAGE=${BASE_IMAGE} \
               --build-arg DOCKER_SCRIPT=${DOCKER_SCRIPT} \
               -t ${DOCKER_REPO}/${TAG}:${VERSION}  \
               .
}

# Simple wrapper function which adds the REPOSITORY and VERSION to the given
# BASE_IMAGE, then builds.
build_image_versioned()
{
  TAG=$1
  BASE_IMAGE=$2
  DOCKER_SCRIPT=$3

  build_image ${TAG} ${DOCKER_REPO}/${BASE_IMAGE}:${VERSION} ${DOCKER_SCRIPT}
}
