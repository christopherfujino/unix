#!/usr/bin/env bash

set -euxo pipefail

ROOT="$(dirname "$(realpath "${BASH_SOURCE[0]}" )" )"
cd "$ROOT"

OUT="${ROOT}/out"
TARBALL="${OUT}/2.11BSD-pl195.tar"

mkdir -p "$OUT"

curl -L https://www.tuhs.org/Archive/Distributions/UCB/2BSD/2.11BSD-pl195.tar -o "$TARBALL"
pushd "$OUT"

SCRIPT_NAME='tar2tape.pl'
TAPE_NAME='211bsd-195.tap'
EXTRACTED_211_BSD_DIR="${OUT}/2.11bsd-tape"
mkdir -p "$EXTRACTED_211_BSD_DIR"
tar xvf "$TARBALL" -C "$EXTRACTED_211_BSD_DIR"
zips=('root.dmp.gz' 'src.tar.gz' 'usr.tar.gz' 'sys.tar.gz')

pushd "${EXTRACTED_211_BSD_DIR}"
for file in "${zips[@]}"; do
  gunzip "$file"
done

cp "../../$SCRIPT_NAME" .
"./$SCRIPT_NAME"

cp "./$TAPE_NAME" ../../

popd # "${EXTRACTED_211_BSD_DIR}"
popd # $OUT

pdp11 ./2.11bsd-195-bootstrap.ini
