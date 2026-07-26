#!/usr/bin/env bash

set -euxo pipefail

ROOT="$(dirname "$(realpath "${BASH_SOURCE[0]}" )" )"
RUN_CONFIG="${ROOT}/2.11bsd-195.ini"

cd "$ROOT"

exec pdp11 "$RUN_CONFIG"
