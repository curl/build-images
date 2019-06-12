#!/usr/bin/env bash

pushd /tmp

# Download an archive of a stable version of curl.
wget https://github.com/curl/curl/releases/download/curl-7_65_1/curl-7.65.1.tar.gz

# Untar curl
tar xvf curl-7.65.1.tar.gz

# Rename the folder to curl
mv curl-7.65.1 curl

popd