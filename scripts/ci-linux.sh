#!/usr/bin/env bash
set -euo pipefail

BUILD_TYPE="${BUILD_TYPE:-Release}"
BUILD_DIR="build/linux/${BUILD_TYPE}"

echo "==> Conan install"
conan profile detect --force

conan install . \
  -of "${BUILD_DIR}" \
  -s build_type="${BUILD_TYPE}" \
  --build=missing \
  -c tools.system.package_manager:mode=install

echo "==> Configure (CMake preset)"
cmake --preset conan-release

echo "==> Build"
cmake --build --preset conan-release

echo "==> Test"
ctest --preset conan-release --output-on-failure
