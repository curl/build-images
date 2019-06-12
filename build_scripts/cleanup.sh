#!/usr/bin/env bash

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

if [[ -n "${TRAVIS:-}" ]]
then
  if [[ -z "${TRAVIS_TAG:-}" ]]
  then
    # Install requests.
    sudo apt-get update
    sudo apt-get -y install python3 python3-pip
    sudo pip3 install requests

    # Remove all the images.
    remove_image_versioned base_image
    remove_image_versioned base_gcc8
    remove_image_versioned base_clang7
    remove_image_versioned gssapi_libssh2
  fi
fi
