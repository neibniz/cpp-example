FROM ghcr.io/neibniz/bazel-dev@sha256:1441d4d2c06a4de257d39398fbbcd0cea884696a3bbfbfeb04ea532dc0ec967d

ENV BAZELISK_HOME=/tmp/bazelisk

RUN printf '%s\n' \
      'Types: deb' \
      'URIs: http://snapshot.debian.org/archive/debian/20260623T000000Z' \
      'Suites: trixie trixie-updates' \
      'Components: main' \
      'Signed-By: /usr/share/keyrings/debian-archive-keyring.pgp' \
      >/etc/apt/sources.list.d/debian.sources \
 && apt-get -o Acquire::Check-Valid-Until=false update \
 && apt-get install --no-install-recommends -y \
      binutils=2.44-3 \
      cpp-14=14.2.0-19 \
      gcc=4:14.2.0-1 \
      gcc-14=14.2.0-19 \
      g++=4:14.2.0-1 \
      g++-14=14.2.0-19 \
      libc6-dev=2.41-12+deb13u3 \
      libc-dev-bin=2.41-12+deb13u3 \
      libgcc-14-dev=14.2.0-19 \
      libstdc++-14-dev=14.2.0-19 \
      linux-libc-dev=6.12.86-1 \
      make=4.4.1-2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN gcc --version \
 && g++ --version
