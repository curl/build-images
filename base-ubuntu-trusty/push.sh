#!/bin/bash

set -euxo pipefail

# Push docker image. This assumes that the curlimages user is logged in.
docker push curlimages/base-ubuntu-trusty:gcc
