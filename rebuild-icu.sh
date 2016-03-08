#!/bin/sh -ex

DESTINATION="`pwd`/libicu"

_VERSION="56.1"
VERSION="56_1"

### Download source

if [ ! -f "icu4c-$VERSION-src.tgz" ]
then
  curl -O "http://download.icu-project.org/files/icu4c/$_VERSION/icu4c-$VERSION-src.tgz"
fi

### Extract source (twice)

rm -rf "icu"
tar -xvf "icu4c-$VERSION-src.tgz"
rm -rf "icu~"
mv "icu" "icu~"
tar -xvf "icu4c-$VERSION-src.tgz"

### Apply patch for building 56.1 (see https://mail-index.netbsd.org/pkgsrc-users/2016/01/20/msg022855.html)

pushd "icu"
patch -p 0 < "../icu-release-56-1-flagparser-fix.patch"
popd
pushd "icu~"
patch -p 0 < "../icu-release-56-1-flagparser-fix.patch"
popd

### Pre-build for cross-compilation to satisfy "--with-cross-build=..."

pushd "icu~/source"
./configure --disable-icuio --disable-layout --disable-tests --disable-samples
make -j4
popd

### Build and install

rm -rf "$DESTINATION"

source "common.sh"

# http://icu-project.org/apiref/icu4c/uconfig_8h.html
# http://icu-project.org/apiref/icu4c/utypes_8h.html
# http://icu-project.org/apiref/icu4c/platform_8h.html
export CPPFLAGS="-DUCONFIG_NO_LEGACY_CONVERSION=1 -DU_CHARSET_IS_UTF8=1 -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_BREAK_ITERATION=1 -DUCONFIG_NO_FORMATTING=1"

pushd "icu/source"
./configure --prefix="$DESTINATION" --host="$HOST" --enable-static --disable-shared --disable-dyload --disable-renaming --disable-icuio --disable-layout --disable-tests --disable-samples --disable-tools --with-cross-build="`pwd`/../../icu~/source"
make -j4
make install
rm -rf "$DESTINATION/lib/icu" "$DESTINATION/lib/pkgconfig" "$DESTINATION/bin" "$DESTINATION/sbin" "$DESTINATION/share"
popd

### Clean up

rm -rf "icu"
rm -rf "icu~"
