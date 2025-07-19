#!/usr/bin/env bash

set -euxo pipefail

TARBALL='./2.11BSD-pl195.tar'
curl -L https://www.tuhs.org/Archive/Distributions/UCB/2.11BSD-pl195.tar -o "$TARBALL"

OUT='out'
mkdir "$OUT"

SCRIPT_NAME='tar2tape.pl'
TAPE_NAME='211bsd-195.tap'

tar xvf "$TARBALL" -C "$OUT"
zips=('root.dmp.gz' 'src.tar.gz' 'usr.tar.gz' 'sys.tar.gz')

pushd "$OUT"

for file in "${zips[@]}"; do
  gunzip "$file"
done

cp "../$SCRIPT_NAME" .
"./$SCRIPT_NAME"

cp "./$TAPE_NAME" ../

popd

pdp11 ./2.11bsd-195.ini
