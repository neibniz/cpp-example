# CI GCC Toolchain

This project uses a CI container to make GCC builds reproducible. The GCC path
is fixed by the image, and Bazel is told to use that compiler through:

```sh
bazel build --config=gcc-ci //...
bazel run --config=gcc-ci //src:hello
```

The `gcc-ci` config is meant for CI containers, not arbitrary developer hosts.
It pins `CC=/usr/bin/gcc` for Bazel C++ toolchain autoconfiguration and applies
`-std=c++20`.

Build and run the local CI image:

```sh
ci/run_gcc_ci.sh
```

The Dockerfile:

- starts from the same Bazel devcontainer image, pinned by digest
- switches apt to the Debian `20260623T000000Z` snapshot
- installs pinned GCC 14, G++ 14, binutils, libc headers, and make

This is a CI-level closed GCC toolchain. It is intentionally separate from the
`clang` config, which uses a Bazel-managed LLVM toolchain and sysroot.

To verify the compiler selected by Bazel:

```sh
docker run --rm \
  --user "$(id -u):$(id -g)" \
  --env USER=codex \
  --env HOME=/tmp/codex-home \
  --env BAZELISK_HOME=/tmp/bazelisk \
  --workdir /work \
  --volume "$PWD:/work" \
  cpp-example:gcc-ci \
  bash -lc 'bazel aquery --config=gcc-ci "mnemonic(\"CppCompile\", //src:hello)" --output=text | grep -E "/usr/bin/gcc|CC=/usr/bin/gcc"'
```
