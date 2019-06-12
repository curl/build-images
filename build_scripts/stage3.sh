#!/usr/bin/env bash

# This script encompasses all the builds that should happen in stage 3 of
# the Travis build.

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# If a build name is passed then just build that build.
REQUESTED=${1:-}

# Build stage 3. Stage 3 produces all the relevant test images.
if [[ -z ${REQUESTED} ]] || [[ ${REQUESTED} == "gssapi_libssh2" ]]
then
  # Build for test: gcc-8 (with-gssapi, with-libssh2) CHECKSRC=1
  ${SCRIPTDIR}/build_and_push.sh gssapi_libssh2 base_gcc8 create_gssapi_libssh2.sh
fi
