FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip \
    pipx \
    pkg-config \
  && rm -rf /var/lib/apt/lists/*

# pipx path aktivieren
ENV PATH="/root/.local/bin:${PATH}"

RUN pipx install "conan>=2.20,<3"

WORKDIR /workspace
