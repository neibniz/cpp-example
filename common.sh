bazel run @hedron_compile_commands//:refresh_all
bazel clean --expunge
CC=/usr/bin/g++ bazel run //src:hello
