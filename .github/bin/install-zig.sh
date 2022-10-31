#!/usr/bin/env bash

case "$(uname)" in
  Darwin*)   os='macos'   ;;
  Linux*)    os='linux'   ;;
  Windows*)  os='windows' ;;
  MINGW*)    os='windows' ;;
  MSYS_NT-*) os='windows' ;;
  *)         os='linux'   ;;
esac

case "${os}" in
  windows*) ext='zip'    ;;
  *)        ext='tar.xz' ;;
esac

arch="$(uname -m)"

version='0.10.1'
url="https://ziglang.org/download/${version}/zig-${os}-${arch}-${version}.${ext}"

curlopts=(
  --silent
  --show-error
  --fail
  --location
  --retry 3
)

file="zig.${ext}"
curl "${curlopts[@]}" --output "${file}" "${url}"
tar xJf "${file}"
mkdir -p "${HOME}/bin"
ln -s "$(pwd)"/zig-*/zig "${HOME}/bin/zig"
