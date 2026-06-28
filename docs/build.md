# Build

This project uses CMake for builds and Conan 2 for third-party dependencies.

## Requirements

- CMake 3.25 or newer
- Conan 2
- A C++20 compiler
- Make or Ninja

## Quick commands

```sh
conan profile detect --force

conan install . --output-folder build/release --build=missing -s build_type=Release -s compiler.cppstd=20
cmake --preset release
cmake --build --preset release

conan install . --output-folder build/test --build=missing -s build_type=Debug -s compiler.cppstd=20 -o '&:with_tests=True'
cmake --workflow --preset test
```

## Manual flow

```sh
conan profile detect --force
conan install . --output-folder build/release --build=missing -s build_type=Release -s compiler.cppstd=20
cmake --preset release
cmake --build --preset release
./build/release/app
```

For Debug builds:

```sh
conan install . --output-folder build/debug --build=missing -s build_type=Debug -s compiler.cppstd=20
cmake --preset debug
cmake --build --preset debug
```

## Presets

Available CMake presets:

```text
debug
release
relwithdebinfo
minsizerel
asan
ubsan
asan-ubsan
tsan
test
coverage
benchmark
```

Sanitizer presets use Debug dependencies from Conan and place build trees under
dedicated directories such as `build/asan` and `build/ubsan`.

```sh
conan install . --output-folder build/asan --build=missing -s build_type=Debug -s compiler.cppstd=20
cmake --preset asan
cmake --build --preset asan
ASAN_OPTIONS=halt_on_error=1 ./build/asan/app
```

Tests, coverage, and benchmarks are exposed as CMake workflow presets. Run
Conan first with the matching output folder because each CMake preset reads the
toolchain file from `build/<preset>/generators/conan_toolchain.cmake`.
Tests use GoogleTest, enabled through the Conan `with_tests` option.

```sh
conan install . --output-folder build/test --build=missing -s build_type=Debug -s compiler.cppstd=20 -o '&:with_tests=True'
cmake --workflow --preset test

conan install . --output-folder build/coverage --build=missing -s build_type=Debug -s compiler.cppstd=20 -o '&:with_tests=True'
cmake --workflow --preset coverage

conan install . --output-folder build/benchmark --build=missing -s build_type=Release -s compiler.cppstd=20 -o '&:with_benchmarks=True'
cmake --workflow --preset benchmark
```

The `coverage` preset builds Debug tests with coverage instrumentation enabled.
Coverage report generation depends on the compiler toolchain and can be layered
on top with tools such as `gcovr`, `lcov`, or `llvm-cov`.

The `benchmark` preset builds benchmarks as Release and runs benchmark-labeled
CTest entries.

## IDE support

Generate the Debug build directory before opening the project in clangd-based
editors:

```sh
conan install . --output-folder build/debug --build=missing -s build_type=Debug -s compiler.cppstd=20
cmake --preset debug
```

To expose a root-level compile database for tools that do not read `.clangd`:

```sh
ln -sf build/debug/compile_commands.json compile_commands.json
```

## Dev container

The dev container consumes a fixed prebuilt image and does not build an image
from this repository:

```text
ghcr.io/neibniz/cpp-cmake-conan:20260629
```

That image is expected to contain CMake, Conan 2, a C++20 compiler, Make or
Ninja, clangd, clang-format, and clang-tidy.

The dev container keeps Docker named volumes across container recreates. Volume
names are derived from `${localWorkspaceFolderBasename}`, so the same template
can be reused by different repositories without cache collisions:

- `${localWorkspaceFolderBasename}-vscode-server`: VS Code Server and remote extensions
- `${localWorkspaceFolderBasename}-vscode-server-insiders`: VS Code Insiders Server
- `${localWorkspaceFolderBasename}-conan2`: Conan 2 package cache and profiles
- `${localWorkspaceFolderBasename}-cache`: clangd and other XDG cache data

VS Code may still download a new server once after the desktop app updates,
because the server version is tied to the VS Code commit.

The dev container `postCreateCommand` only ensures the Conan default profile
exists and pins `compiler.cppstd=20`. Conan's detected profile can otherwise
choose an older default standard.
