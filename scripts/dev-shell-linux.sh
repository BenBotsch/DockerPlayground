#!/usr/bin/env bash

# ============================================================
#  Developer Shell – Docker Playground (Linux)
# ============================================================

# -------------------------
# Theme (dark | light)
# -------------------------
DEV_THEME="${DEV_THEME:-dark}"

if [[ "$DEV_THEME" == "light" ]]; then
  BLUE="\033[94m"
  GREEN="\033[32m"
  CYAN="\033[36m"
  YELLOW="\033[33m"
  GRAY="\033[90m"
else
  BLUE="\033[34m"
  GREEN="\033[32m"
  CYAN="\033[36m"
  YELLOW="\033[33m"
  GRAY="\033[90m"
fi

BOLD="\033[1m"
RESET="\033[0m"

# -------------------------
# Project metadata
# -------------------------
PROJECT_NAME="Docker Playground"
LANGUAGE="C++20"
GENERATOR="CMake + Conan 2"
OS="Linux"
CONTAINER="$(hostname)"
BUILD_TYPE="${BUILD_TYPE:-Debug}"

# -------------------------
# Helpers
# -------------------------
git_info() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch dirty
    branch="$(git branch --show-current)"
    git diff --quiet || dirty="*"
    echo "${GREEN}${branch}${YELLOW}${dirty}${RESET}"
  else
    echo "${GRAY}no-git${RESET}"
  fi
}

cmake_preset() {
  if [[ -f CMakePresets.json ]] && command -v jq >/dev/null 2>&1; then
    jq -r '.configurePresets[0].name' CMakePresets.json 2>/dev/null \
      | sed "s/.*/${CYAN}&${RESET}/"
  else
    echo "${GRAY}unknown${RESET}"
  fi
}

compiler_info() {
  c++ --version | head -n1
}

# -------------------------
# Build type switcher
# -------------------------
build-debug() {
  export BUILD_TYPE=Debug
  echo -e "${GREEN}Switched to Debug${RESET}"
}

build-release() {
  export BUILD_TYPE=Release
  echo -e "${GREEN}Switched to Release${RESET}"
}

# -------------------------
# Header
# -------------------------
draw_header() {
  echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${BLUE}║ ${GREEN}${PROJECT_NAME}${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}║ ${CYAN}${LANGUAGE} | ${GENERATOR}${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}║ Build: ${YELLOW}${BUILD_TYPE}${BLUE} | Preset: $(cmake_preset)${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}║ Git: $(git_info)${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}║ Container: ${GRAY}${CONTAINER}${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}║ ${GRAY}$(compiler_info)${BLUE}${RESET}"
  echo -e "${BOLD}${BLUE}╠══════════════════════════════════════════════════════════╣${RESET}"

  echo -e "${BOLD}${BLUE}║ ${CYAN}Common Commands (copy & paste)${BLUE}${RESET}"

  echo -e "${BOLD}${BLUE}║ ${GREEN}Conan:${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan profile detect --force${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan profile list${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan profile show${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan install . -s build_type=Debug   --build=missing${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan install . -s build_type=Release --build=missing${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan graph info .${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan graph info . --format=html > graph.html${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan search opencv*${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan cache clean${RESET}"
  echo -e "${BLUE}║   ${GRAY}conan remove "*" -c${RESET}"

  echo -e "${BOLD}${BLUE}║ ${GREEN}CMake:${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --list-presets${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --list-presets=configure${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --list-presets=build${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --list-presets=test${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --preset conan-default${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --build --preset conan-debug${RESET}"
  echo -e "${BLUE}║   ${GRAY}cmake --build --preset conan-release${RESET}"


  echo -e "${BOLD}${BLUE}║ ${GREEN}Tests:${RESET}"
  echo -e "${BLUE}║   ${GRAY}ctest --preset conan-debug   --output-on-failure${RESET}"
  echo -e "${BLUE}║   ${GRAY}ctest --preset conan-release --output-on-failure${RESET}"

  echo -e "${BOLD}${BLUE}║ ${GREEN}Helpers:${RESET}"
  echo -e "${BLUE}║   ${GRAY}build-debug     # switch build type${RESET}"
  echo -e "${BLUE}║   ${GRAY}build-release   # switch build type${RESET}"

  echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════╝${RESET}"
}

# -------------------------
# Redraw handler
# -------------------------
__redraw_shell() {
  clear
  draw_header
}

# -------------------------
# Key bindings (interactive only)
# -------------------------
[[ $- != *i* ]] && return

# clear + redraw header
bind -x '"\C-x":__redraw_shell'

# -------------------------
# Initial draw
# -------------------------
draw_header

# -------------------------
# Prompt
# -------------------------
PS1="\[\033[32m\]\u@\h\[\033[0m\]:\[\033[36m\]\w\[\033[0m\]\n\[\033[1m\]➜ \[\033[0m\]"
