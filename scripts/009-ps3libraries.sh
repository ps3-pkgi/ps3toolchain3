#!/usr/bin/env bash
set -eo pipefail
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)

## Check if we want to skip this step
if [ -n "$BUILD_PS3TOOLCHAIN_ONLY" ]; then
    echo "PS3 Toolchain only set. Skipping..."
    exit 0
fi

source ../utils/utils.sh

## Download the source code.
../download.sh ps3libraries.tar.gz

## Unpack the source code.
rm -Rf ps3libraries
mkdir ps3libraries
echo "Unpacking ps3libraries"
extract ../archives/ps3libraries.tar.gz --strip-components=1 --directory=ps3libraries
cd ps3libraries

## ps3libraries downloads with wget; switch it to aria2.
rm -f depends/check-wget.sh
sed -i.bak -e '/^WGET=/d' \
  -e 's|^[[:space:]]*\$WGET -O "\$dest" "\$url"|aria2c -c --max-tries=5 --timeout=30 --console-log-level=warn --allow-overwrite=true --auto-file-renaming=false --summary-interval=0 --async-dns=false -o "$dest" "$url"|' \
  download.sh
rm -f download.sh.bak

## Compile and install.
./libraries.sh
