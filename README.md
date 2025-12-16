# my-cv-project

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
