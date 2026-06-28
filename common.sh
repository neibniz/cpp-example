#!/usr/bin/env bash
set -euo pipefail

case "${1:-build}" in
  build)
    bazel build //...
    ;;
  run)
    bazel run //src:hello
    ;;
  clang_build)
    bazel build --config=clang //...
    ;;
  clang_run)
    bazel run --config=clang //src:hello
    ;;
  gcc_ci_build)
    bazel build --config=gcc-ci //...
    ;;
  gcc_ci_run)
    bazel run --config=gcc-ci //src:hello
    ;;
  compile_commands)
    bazel run @hedron_compile_commands//:refresh_all
    ;;
  clean)
    bazel clean
    ;;
  *)
    echo "Usage: $0 [build|run|clang_build|clang_run|gcc_ci_build|gcc_ci_run|compile_commands|clean]" >&2
    exit 2
    ;;
esac
