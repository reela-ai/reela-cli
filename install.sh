#!/bin/bash
set -euo pipefail

REPO="reelanything/reela-cli"
INSTALL_DIR="${REELA_INSTALL_DIR:-$HOME/.local/bin}"
BINARY_NAME="reela"

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
        x86_64)  target="x86_64-unknown-linux-musl" ;;
        aarch64) target="aarch64-unknown-linux-musl" ;;
        *)       die "Unsupported Linux architecture: $arch" ;;
      esac
      ;;
    Darwin)
      case "$arch" in
        x86_64)  target="x86_64-apple-darwin" ;;
        arm64)   target="aarch64-apple-darwin" ;;
        *)       die "Unsupported macOS architecture: $arch" ;;
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
  local version
  version=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | grep '"tag_name"' \
    | sed -E 's/.*"tag_name": *"reela-cli-v([^"]+)".*/\1/')

  if [ -z "$version" ]; then
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
  trap 'rm -rf "$tmpdir"' EXIT

  info "Downloading $archive_name..."
  curl -fsSL "$archive_url" -o "$tmpdir/$archive_name"

  info "Verifying checksum..."
  curl -fsSL "$checksum_url" -o "$tmpdir/SHA256SUMS"
  (cd "$tmpdir" && grep "$archive_name" SHA256SUMS | \
    if command -v sha256sum >/dev/null 2>&1; then
      sha256sum -c --quiet
    else
      shasum -a 256 -c --quiet
    fi
  ) || die "Checksum verification failed"

  info "Extracting..."
  tar -xzf "$tmpdir/$archive_name" -C "$tmpdir"

  info "Installing to $INSTALL_DIR..."
  mkdir -p "$INSTALL_DIR"
  mv "$tmpdir/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
  chmod +x "$INSTALL_DIR/$BINARY_NAME"

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
  echo ""
  echo "  Run 'reela --help' to get started."
  echo ""
  echo "  We recommend installing the reela-cli skills (https://github.com/reelanything/reela-cli)"
}

main "$@"
