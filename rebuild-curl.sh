#!/bin/sh -ex

DESTINATION="`pwd`/libcurl"

VERSION="7.47.1"

### Download source

if [ ! -f "curl-$VERSION.tar.gz" ]
then
  curl -O "https://curl.haxx.se/download/curl-$VERSION.tar.gz"
fi

### Extract source

rm -rf "curl-$VERSION"
tar -xvf "curl-$VERSION.tar.gz"

### Build and install

rm -rf "$DESTINATION"

source "common.sh"

pushd "curl-$VERSION"
./configure --prefix="$DESTINATION" --host="$HOST" --enable-static --disable-shared \
  --disable-debug --disable-curldebug --enable-verbose \
  --enable-threaded-resolver --disable-ares \
  --enable-ipv6 \
  --enable-crypto-auth \
  --enable-http \
  --enable-proxy \
  --disable-ftp \
  --disable-file \
  --disable-ldap \
  --disable-ldaps \
  --disable-rtsp \
  --disable-dict \
  --disable-telnet \
  --disable-tftp \
  --disable-pop3 \
  --disable-imap \
  --disable-smb \
  --disable-smtp \
  --disable-gopher \
  --disable-manual \
  --disable-sspi \
  --with-ssl="`pwd`/../libssl" --without-libssh2
make -j
make install
rm -rf "$DESTINATION/bin" "$DESTINATION/share" "$DESTINATION/lib/libcurl.la" "$DESTINATION/lib/pkgconfig"
popd

### Clean up

rm -rf "curl-$VERSION"
