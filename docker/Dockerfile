FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    git \
    pkg-config \
    python3 \
    python3-pip \
  && rm -rf /var/lib/apt/lists/*

# Conan 2
RUN pip3 install --no-cache-dir "conan>=2.20,<3"

WORKDIR /workspace
