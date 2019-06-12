#!/usr/bin/env bash

# This script encompasses all the builds that should happen in stage 2 of
# the Travis build.

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# If a build name is passed then just build that build.
REQUESTED=${1:-}

# Build stage 2. Stage 2 produces images with gcc-8 and clang-7 installed.

if [[ -z ${REQUESTED} ]] || [[ ${REQUESTED} == "gcc8" ]]
then
  # Build gcc-8. Depends on `base_image` from stage1
  ${SCRIPTDIR}/build_and_push.sh base_gcc8 base_image install_gcc8.sh
fi

if [[ -z ${REQUESTED} ]] || [[ ${REQUESTED} == "clang7" ]]
then
  # Build clang-7. Depends on `base_image` from stage1
  ${SCRIPTDIR}/build_and_push.sh base_clang7 base_image install_clang7.sh
fi