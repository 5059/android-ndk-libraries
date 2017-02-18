Overview
========

This repository contains various open source libraries precompiled as static libraries and ready-to-use with the Android NDK for armv7. The build scripts are also provided.

* [libcurl](http://curl.haxx.se/libcurl/) (with HTTP and HTTPS protocols)
* [libssl](https://www.openssl.org/)
* [libicu](http://site.icu-project.org/) (with legacy conversion turned off)
* [libmbedtls](https://tls.mbed.org/)

Build Environment
=================

* OS X
* Android Studio 2.x with NDK support
* NDK ~~r10e~~ r11
* Android API level 18

Using the Libraries
===================

To make HTTPS certificate verification work with curl, see http://stackoverflow.com/a/31521185/463432.
