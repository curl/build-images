#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Do initial common setup.
. /scripts/test_common.sh

# The common code checks for the existence of the codebase.
pushd /opt/curl

# Configure with standard options plus anything on the command line.
./configure --enable-warnings --enable-werror $@

# Make the main program and examples.
make
make examples

# Run the tests.
if [[ -z ${NOTESTS:-} ]]
then
  make test-nonflaky
fi

# Check source code if requested.
if [[ -n ${CHECKSRC:-} ]]
then
  make checksrc
fi

popd