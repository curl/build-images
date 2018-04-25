#!/bin/bash

set -euxo pipefail

# Build gcc image
docker build -f Dockerfile.gcc \
             -t curlimages/base-ubuntu-trusty:gcc \
             .
