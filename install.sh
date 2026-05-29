#!/bin/bash
set -euo pipefail

REPO="${REELA_CLI_REPO:-reela-ai/reela-cli}"
INSTALL_DIR="${REELA_INSTALL_DIR:-$HOME/.local/bin}"
DOCS_DIR="${REELA_DOCS_DIR:-$HOME/.reela/docs}"
BINARY_NAME="reela"
TMPDIR_CLEANUP=""
trap 'if [ -n "$TMPDIR_CLEANUP" ]; then rm -rf "$TMPDIR_CLEANUP"; fi' EXIT

# --- Helpers ---

die() {
  echo "Error: $1" >&2
  exit 1
}

info() {
  echo "==> $1"
}

# --- Detect OS and Architecture ---

detect_target() {
  local os arch target

  os="$(uname -s)"
  arch="$(uname -m)"

  case "$os" in
  Linux)
    case "$arch" in
    x86_64) target="x86_64-unknown-linux-musl" ;;
    aarch64) target="aarch64-unknown-linux-musl" ;;
    *) die "Unsupported Linux architecture: $arch" ;;
    esac
    ;;
  Darwin)
    case "$arch" in
    x86_64) target="x86_64-apple-darwin" ;;
    arm64) target="aarch64-apple-darwin" ;;
    *) die "Unsupported macOS architecture: $arch" ;;
    esac
    ;;
  *)
    die "Unsupported OS: $os. For Windows, download from https://github.com/$REPO/releases"
    ;;
  esac

  echo "$target"
}

# --- Get latest version ---

get_latest_version() {
  local latest_url version
  latest_url=$(curl -fsSL -o /dev/null -w '%{url_effective}' "https://github.com/$REPO/releases/latest")
  version=$(echo "$latest_url" | sed -E 's#.*/releases/tag/reela-cli-v([^/?#]+).*#\1#')

  if [ -z "$version" ] || [ "$version" = "$latest_url" ]; then
    die "Failed to determine latest version"
  fi

  echo "$version"
}

# --- Main ---

main() {
  local version="${1:-}"
  local target

  target=$(detect_target)

  if [ -z "$version" ]; then
    info "Detecting latest version..."
    version=$(get_latest_version)
  fi

  info "Installing reela v$version for $target"

  local archive_name="reela-v${version}-${target}.tar.gz"
  local checksum_url="https://github.com/$REPO/releases/download/reela-cli-v${version}/SHA256SUMS"
  local archive_url="https://github.com/$REPO/releases/download/reela-cli-v${version}/${archive_name}"

  local tmpdir
  tmpdir=$(mktemp -d)
  TMPDIR_CLEANUP="$tmpdir"

  info "Downloading $archive_name..."
  curl -fsSL "$archive_url" -o "$tmpdir/$archive_name"

  info "Verifying checksum..."
  curl -fsSL "$checksum_url" -o "$tmpdir/SHA256SUMS"
  (
    cd "$tmpdir" && grep "$archive_name" SHA256SUMS |
      if [ "$(uname -s)" = "Darwin" ]; then
        shasum -a 256 -c --quiet
      else
        sha256sum -c --quiet
      fi
  ) || die "Checksum verification failed"

  info "Extracting..."
  tar -xzf "$tmpdir/$archive_name" -C "$tmpdir"

  info "Installing to $INSTALL_DIR..."
  mkdir -p "$INSTALL_DIR"
  mv "$tmpdir/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
  chmod +x "$INSTALL_DIR/$BINARY_NAME"

  info "Installing CLI docs to $DOCS_DIR..."
  if [ ! -d "$tmpdir/docs" ]; then
    die "Release archive did not contain docs/"
  fi
  rm -rf "$DOCS_DIR"
  mkdir -p "$(dirname "$DOCS_DIR")"
  cp -R "$tmpdir/docs" "$DOCS_DIR"

  # Check if INSTALL_DIR is in PATH
  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
    echo ""
    echo "  Add $INSTALL_DIR to your PATH:"
    echo ""
    echo "    export PATH=\"$INSTALL_DIR:\$PATH\""
    echo ""
    echo "  Add the above line to your ~/.bashrc, ~/.zshrc, or shell config."
  fi

  info "Installed reela v$version to $INSTALL_DIR/$BINARY_NAME"
  info "CLI docs installed to $DOCS_DIR"
  echo ""
  echo "  Run 'reela --help' to get started."
}

main "$@"
