# Docker Playground

Modern C++ (C++20) • CMake • Conan 2 • OpenCV • Docker

A cross-platform C++ project template using **CMake + Conan 2** with **OpenCV** and **unit tests**, designed to be built and tested reproducibly using **Docker** on **Linux and Windows**.

This setup allows:

- Linux builds & tests on any host
- Windows builds & tests using Windows containers
- Identical dependency resolution via Conan 2
- No local toolchain pollution

---

## ✨ Features

- Modern **C++20**
- **CMake** with Conan 2 integration
- **OpenCV** as a third-party dependency
- **Catch2** for unit testing
- Fully containerized **Linux and Windows CI**
- Reproducible builds
- Cached dependencies (fast re-runs)

---

## 📦 Requirements

### General

- **Git**
- **Docker Desktop**

### Windows Host

- Docker Desktop **with WSL2 enabled**
- Ability to switch between:
  - *Linux containers*
  - *Windows containers*

> ⚠️ Docker Desktop cannot run Linux and Windows containers at the same time.
> You must switch modes depending on the target platform.

---

## 📁 Repository Structure (Relevant Parts)

```text
docker/
 ├─ linux/
 │   └─ Dockerfile
 └─ windows/
     └─ Dockerfile

scripts/
 ├─ ci-linux.sh
 └─ ci-windows.cmd

docker-compose.linux.yml
docker-compose.windows.yml
```

## 🐳 Building & Using Docker Images (Linux & Windows)

### 🐧 Linux Docker Image

The Linux image is intended for daily development, CI, and fast iteration.
It can be built and run on any host OS (Windows, Linux, macOS).

#### **Build the Linux image**

```bash
docker compose -f docker-compose.linux.yml build
```

#### **Run build and unit tests**

```bash
docker compose -f docker-compose.linux.yml run --rm test
```

This will:

- Start a Linux container
- Install dependencies via Conan (cached)
- Configure the project using CMake presets
- Build all targets
- Execute all unit tests

#### **Start an interactive development shell**

```bash
docker compose -f docker-compose.linux.yml run --rm shell
```

Inside the container you can:

- Run CMake manually
- Execute tests selectively
- Run demo applications
- Inspect build artifacts

#### **Example:**

```bash
cmake --preset conan-release
cmake --build --preset conan-release
ctest --preset conan-release
```

### 🪟 Windows Docker Image (MSVC)

The Windows image builds and tests native Windows binaries using MSVC.
It requires Docker Desktop to run in Windows container mode.

#### **Build the Windows image**

```bash
docker compose -f docker-compose.windows.yml build
```

#### **Run build and unit tests**

```bash
docker compose -f docker-compose.windows.yml run --rm test
```
