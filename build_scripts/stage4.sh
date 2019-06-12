#!/usr/bin/env bash

# This script encompasses all the tests that should happen in stage 4 of
# the Travis build.

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# If a test name is passed then just run that test.
REQUESTED=${1:-}

# Download a temporary version of curl if required.
if [[ ! -d /tmp/curl ]]
then
  ${SCRIPTDIR}/download_stable_curl.sh
fi

if [[ -z ${REQUESTED} ]] || [[ ${REQUESTED} == "gssapi_libssh2" ]]
then
  # Run test: gcc-8 (with-gssapi, with-libssh2) CHECKSRC=1
  CHECKSRC=1 ${SCRIPTDIR}/run_normal.sh gssapi_libssh2 /tmp/curl --with-gssapi --with-libssh2
fi
