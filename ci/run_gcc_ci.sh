#!/usr/bin/env bash
set -euo pipefail

image="${CI_GCC_IMAGE:-cpp-example:gcc-ci}"
workspace="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

docker build \
  --file "${workspace}/ci/gcc.Dockerfile" \
  --tag "${image}" \
  "${workspace}"

docker run --rm \
  --user "$(id -u):$(id -g)" \
  --env USER=codex \
  --env HOME=/tmp/codex-home \
  --env BAZELISK_HOME=/tmp/bazelisk \
  --workdir /work \
  --volume "${workspace}:/work" \
  --volume "${TMPDIR:-/tmp}/cpp-example-gcc-ci-home:/tmp/codex-home" \
  --volume "${TMPDIR:-/tmp}/cpp-example-gcc-ci-bazelisk:/tmp/bazelisk" \
  "${image}" \
  bash -lc 'mkdir -p "$HOME" "$BAZELISK_HOME" && gcc --version && bazel run --config=gcc-ci //src:hello'
