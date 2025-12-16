@echo off
set BUILD_TYPE=Release
set BUILD_DIR=build\windows\%BUILD_TYPE%

conan profile detect --force

conan install . ^
  -of %BUILD_DIR% ^
  -s build_type=%BUILD_TYPE% ^
  --build=missing

cmake -S . -B %BUILD_DIR% -G Ninja ^
  -DCMAKE_TOOLCHAIN_FILE=%BUILD_DIR%\conan_toolchain.cmake ^
  -DCMAKE_BUILD_TYPE=%BUILD_TYPE%

cmake --build %BUILD_DIR%
ctest --test-dir %BUILD_DIR% --output-on-failure
