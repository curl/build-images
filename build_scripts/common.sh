#!/usr/bin/env bash

# Calculate the current build locations
export SCRIPTDIR=$(dirname "${BASH_SOURCE[0]}")
export ROOTDIR=${SCRIPTDIR}/..

# If running on travis and processing a tag, work with curlbuildimages.
# If running on travis and processing anything else, work with
# curlbuildimagestemp.
# If running locally, work with the curlbuildimagestemp namespace.
if [[ -n "${TRAVIS:-}" ]]
then

  # Check to see if we can log into Docker. Pull requests cannot log into Docker
  if [[ -n "${DOCKER_USER:-}" ]]
  then
    # Log into Docker.
    echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
  fi

  if [[ -n "${TRAVIS_TAG:-}" ]]
  then
    # Processing a tagged build. Get the version from the version file.
    export VERSION=$(cat VERSION)

    # Use the main repository.
    export DOCKER_REPO=curlbuildimages
  else
    # Processing an untagged build. The version is the build ID, which is
    # shared between stages.
    export VERSION=${TRAVIS_BUILD_ID}

    # Use the temporary repository.
    export DOCKER_REPO=curlbuildimagestemp
  fi
else
  # Get the version from the version file.
  export VERSION=$(cat VERSION)

    # Use the temporary repository.
  export DOCKER_REPO=curlbuildimagestemp
fi


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


# Simple function which adds the REPOSITORY and VERSION to the given TAG,
# then pushes to Docker.
push_image_versioned()
{
  if [[ -n "${DOCKER_USER:-}" ]]
  then
    # The Docker user environment variable exists, so pushing should work.
    TAG=$1
    docker push ${DOCKER_REPO}/${TAG}:${VERSION}
  else
    echo "Would have pushed to ${DOCKER_REPO}/${TAG}:${VERSION} but "
    echo "DOCKER_USER is not set."
  fi
}


# Function to remove an image tag from the Docker hub
remove_image_versioned()
{
  python3 ${ROOTDIR}/docker_hub_scripts/remove_tag.py \
      --username ${DOCKER_USER} \
      --password ${DOCKER_PASS} \
      --repository ${1} \
      --tag ${VERSION}
}
