Overview
========

This repository contains various open source libraries precompiled as static libraries and ready-to-use with the Android NDK for armv7. The build scripts are also provided.

* [libcurl](http://curl.haxx.se/libcurl/) (with HTTP and HTTPS protocols)
* [libssl](https://www.openssl.org/)
* [libicu](http://site.icu-project.org/) (with legacy conversion turned off)

# curl-android-ndk

Build script to build OpenSSL and cURL using the Android NDK.

Build Environment
=================

* OS X 10.10.x
* NDK r10e
* Android API level 18

Using the Libraries
===================

To make HTTPS certificate verification work, see http://stackoverflow.com/a/31521185/463432.
