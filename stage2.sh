#!/usr/bin/env bash

set -euxo pipefail

. common.sh

# Build stage 2. Stage 2 produces images with gcc-8 and clang-7 installed.
echo "Building stage 2 (version ${VERSION})"

# Build gcc-8. Depends on `base_image` from stage1
build_image_versioned base_gcc8 base_image install_gcc8.sh

# Build clang-7. Depends on `base_image` from stage1
build_image_versioned base_clang7 base_image install_clang7.sh
