@echo off
setlocal

set BUILD_TYPE=Release
set BUILD_DIR=build\windows\%BUILD_TYPE%

conan profile detect --force

conan install . ^
  --output-folder=%BUILD_DIR% ^
  --build=missing ^
  -s build_type=%BUILD_TYPE%

cmake --preset conan-%BUILD_TYPE%

cmake --build --preset conan-%BUILD_TYPE%

ctest --preset conan-%BUILD_TYPE% --output-on-failure

endlocal
