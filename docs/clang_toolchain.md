# Hermetic Clang Toolchain

This project keeps the default Bazel build on the host C++ toolchain, and adds
an opt-in LLVM/Clang toolchain for reproducible checks:

```sh
bazel build --config=clang //...
bazel run --config=clang //src:hello
```

The toolchain is configured in `MODULE.bazel` with `toolchains_llvm`, pins LLVM
to `22.1.7`, and adds explicit Linux x86_64/aarch64 sysroots. It is not
registered globally, so normal builds are unchanged. The `clang` Bazel config
also disables local C++ toolchain detection, so it can run in containers that do
not install `gcc` or a system `clang`.

The generated repository `@llvm_toolchain_llvm` contains the downloaded LLVM
distribution. For example, this target exposes the pinned formatter:

```sh
bazel run @llvm_toolchain//:clang-format -- --version
```

Inside the configured devcontainer image, the same commands should work:

```sh
mkdir -p /private/tmp/cpp-example-devcontainer-home /private/tmp/cpp-example-bazelisk

docker run --rm \
  --user "$(id -u):$(id -g)" \
  --env USER=codex \
  --env HOME=/tmp/codex-home \
  --env BAZELISK_HOME=/tmp/bazelisk \
  --workdir /work \
  --volume "$PWD:/work" \
  --volume /private/tmp/cpp-example-devcontainer-home:/tmp/codex-home \
  --volume /private/tmp/cpp-example-bazelisk:/tmp/bazelisk \
  ghcr.io/neibniz/bazel-dev:18e5dadcd545 \
  bazel run --config=clang //src:hello
```

The extra environment and cache mounts keep Bazel/Bazelisk writable when the
container runs as the host UID under OrbStack.
