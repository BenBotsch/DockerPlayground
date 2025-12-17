@echo off
setlocal

set BUILD_TYPE=Release
set BUILD_DIR=build\windows\%BUILD_TYPE%

conan profile detect --force

conan install . ^
  --output-folder=%BUILD_DIR% ^
  --build=missing ^
  -s build_type=%BUILD_TYPE%

cmake --preset conan-default

cmake --build --preset conan-release

ctest --preset conan-release --output-on-failure

endlocal
