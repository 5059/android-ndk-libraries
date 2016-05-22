#!/bin/sh -ex

DESTINATION="`pwd`/libmbedtls"

VERSION="2.2.1"

### Download source

if [ ! -f "mbedtls-$VERSION-apache.tgz" ]
then
  curl -O "https://tls.mbed.org/download/mbedtls-$VERSION-apache.tgz"
fi

### Extract source

rm -rf "mbedtls-$VERSION"
tar -xvf "mbedtls-$VERSION-apache.tgz"

### Build and install

rm -rf "$DESTINATION"

source "common.sh"

pushd "mbedtls-$VERSION"
perl -p -e "s|DESTDIR=.*|DESTDIR=$DESTINATION|g" "Makefile" > "Makefile~"
mv -f "Makefile~" "Makefile"
export CFLAGS="$CFLAGS -fomit-frame-pointer"  # https://tls.mbed.org/kb/development/arm-thumb-error-r7-cannot-be-used-in-asm-here
make -j no_test
make install
rm -rf "$DESTINATION/bin"
popd

### Clean up

rm -rf "mbedtls-$VERSION"
