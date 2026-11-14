# Docker Playground

[![CI](https://github.com/BenBotsch/DockerPlayground/actions/workflows/ci.yml/badge.svg)](https://github.com/BenBotsch/DockerPlayground/actions/workflows/ci.yml)
![C++20](https://img.shields.io/badge/C%2B%2B-20-00599c)
![Conan 2](https://img.shields.io/badge/Conan-2-6699cb)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

A cross-platform C++20 template with CMake, Conan 2, OpenCV and Catch2. It builds and tests reproducibly in Docker on Linux and on Windows, so the host needs no local toolchain. Conan resolves the same dependencies on both platforms and caches them for fast reruns.

## Requirements

You need Git and Docker Desktop. On a Windows host, Docker Desktop needs WSL 2 and must switch between Linux and Windows containers, because it cannot run both at the same time.

## Layout

```text
docker/
  linux/Dockerfile
  windows/Dockerfile
scripts/
  ci-linux.sh
  ci-windows.cmd
docker-compose.linux.yml
docker-compose.windows.yml
```

## Linux image

The Linux image serves daily development, CI and fast iteration. It runs on any host.

```bash
docker compose -f docker-compose.linux.yml build          # build the image
docker compose -f docker-compose.linux.yml run --rm test  # install dependencies, build and run all tests
docker compose -f docker-compose.linux.yml run --rm shell # interactive shell
```

Inside the shell the presets work as usual.

```bash
cmake --preset conan-release
cmake --build --preset conan-release
ctest --preset conan-release
```

## Windows image

The Windows image builds and tests native binaries with MSVC. Docker Desktop must run in Windows container mode.

```bash
docker compose -f docker-compose.windows.yml build
docker compose -f docker-compose.windows.yml run --rm test
```

## License

MIT, see [LICENSE](LICENSE).
