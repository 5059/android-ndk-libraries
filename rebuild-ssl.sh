#!/bin/sh -ex

DESTINATION="`pwd`/libssl"

VERSION="1.0.2g"

### Download source

if [ ! -f "openssl-$VERSION.tar.gz" ]
then
  curl -O "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
fi

### Extract source (twice)

rm -rf "openssl-$VERSION"
tar -xvf "openssl-$VERSION.tar.gz"

### Build and install

rm -rf "$DESTINATION"

source "common.sh"

pushd "openssl-$VERSION"
./Configure android-armv7 --prefix="$DESTINATION"
make -j4
make install_sw
rm -rf "$DESTINATION/bin" "$DESTINATION/ssl" "$DESTINATION/lib/engines" "$DESTINATION/lib/pkgconfig"
rm -f "$DESTINATION/libcrypto.so" "$DESTINATION/libcrypto.so.1.0.0" "$DESTINATION/libssl.so" "$DESTINATION/libssl.so.1.0.0"
popd

### Clean up

rm -rf "openssl-$VERSION"
