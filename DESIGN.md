# Design

This document covers the design thoughts behind build images for speeding up Travis CI and a proposal for how to implement things going forward.

## Background

Travis CI currently uses standard Ubuntu containers to build curl. There are lots and lots of entries in the curl build matrix and currently a single job takes a long time to complete.

Part of this is due to downloading and compiling dependencies (e.g. brotli, wolfssl). There's also elapsed time taken in downloading and installing packages for compilation.

Using Docker containers, we can create a build image whereby the dependencies are already downloaded and installed, and compiled where necessary. Theoretically it also means developers can have the same build environment as the CI jobs, which is good for reproducibility.

## Design thoughts

- The build images should be based on Ubuntu Trusty, as Travis CI currently use Ubuntu Trusty as their base image.
  - An alternative could be Centos - any Linux distribution is likely fine. It might be that we choose Trusty to start with then, then move onto Centos for testing different distributions.
  - Another alternative is Xenial as many of the builds explicitly request the Xenial distribution.
- Build images will be strictly versioned using semver for reproducibility. The "latest" tag will not be used.

## Current set of builds

The current set of Linux curl CI builds (from .travis.yml) are as follows:

- gcc-8 (with-gssapi, with-libssh2) CHECKSRC=1
- gcc-8 (disable-http, disable-smtp, disable-imap)
- gcc-8 (enable-ares)
- gcc-8 (dist:xenial, disable-verbose, no-variadic-macros) NOTESTS=1
- gcc-8 (with-brotli)
- gcc-8 (dist:xenial, with-boringssl) T=novalgrind
- gcc-8 (dist:xenial, with-wolfssl, without-ssl)
- gcc-8 (dist:xenial, with-mesalink, without-ssl)
- clang-7 (dist:xenial)
- clang-7 (dist:xenial, enable-alt-svc)
- clang-7 (dist:xenial, with-mbedtls, without-tls)
- clang-7 (dist:xenial, with-gnutls, without-tls)
- clang-7 (dist:xenial, disable-threaded-resolver) T=debug
- clang-7 (dist:xenial, with-nss, without-ssl) T=debug NOTESTS=1
- gcc-8 () T=iconv
- gcc-8 (dist:xenial) T=cmake
- clang-7 (dist:xenial) T=cmake
- gcc-8 (dist:xenial) T=coverage
- gcc-8 (dist:xenial) T=distcheck
- clang-7 (dist:xenial) T=fuzzer
- clang-7 (dist:xenial) T=tidy
- clang-7 (dist:xenial) T=scan-build
- clang-7 (dist:xenial, many sanitization options) T=debug

There are several OSX builds which I don't intend to run through Docker.

It probably makes sense to have an individual build image for each of these different options, caching the dependencies of each. Docker builds are "cheap".

It might make sense to have several stages of build:

- Build gcc-8, clang-7 images on top of the base image (Trusty/Xenial/whatever)
- Build all these images on top of these bases.