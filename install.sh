#!/bin/bash
set -euo pipefail

REPO="${REELA_CLI_REPO:-reela-ai/reela-cli}"
RELEASE_BASE_URL="${REELA_CLI_RELEASE_BASE_URL:-}"
DIST_SUFFIX="${REELA_CLI_DIST_SUFFIX:-}"
INSTALL_DIR="${REELA_INSTALL_DIR:-$HOME/.local/bin}"
DOCS_DIR="${REELA_DOCS_DIR:-$HOME/.reela/docs}"
BINARY_NAME="reela"
TMPDIR_CLEANUP=""
trap 'if [ -n "$TMPDIR_CLEANUP" ]; then rm -rf "$TMPDIR_CLEANUP"; fi' EXIT

# Allow the source template to run in GitHub mode before CI renders placeholders.
case "$RELEASE_BASE_URL" in
  \{\{*\}\}) RELEASE_BASE_URL="" ;;
esac
case "$DIST_SUFFIX" in
  \{\{*\}\}) DIST_SUFFIX="" ;;
esac

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
    if [ -n "$RELEASE_BASE_URL" ]; then
      die "Unsupported OS: $os"
    else
      die "Unsupported OS: $os. For Windows, download from https://github.com/$REPO/releases"
    fi
    ;;
  esac

  echo "$target"
}

# --- Resolve release archive ---

get_latest_github_version() {
  local latest_url version
  latest_url=$(curl -fsSL -o /dev/null -w '%{url_effective}' "https://github.com/$REPO/releases/latest")
  version=$(echo "$latest_url" | sed -E 's#.*/releases/tag/reela-cli-v([^/?#]+).*#\1#')

  if [ -z "$version" ] || [ "$version" = "$latest_url" ]; then
    die "Failed to determine latest version"
  fi

  echo "$version"
}

parse_version_from_archive() {
  local archive_name="$1"
  local suffix="$2"
  local version

  version="${archive_name#reela-v}"
  version="${version%${suffix}}"

  if [ -z "$version" ] || [ "$version" = "$archive_name" ]; then
    die "Failed to determine latest version from $archive_name"
  fi

  echo "$version"
}

select_archive_from_checksums() {
  local checksums_file="$1"
  local target="$2"
  local ext="$3"
  local suffix archive_name

  suffix="${DIST_SUFFIX}-${target}.${ext}"
  archive_name="$(
    awk '{print $2}' "$checksums_file" |
      grep -E "^reela-v.+${suffix//./\.}$" |
      head -n 1 || true
  )"

  [ -n "$archive_name" ] || die "No release archive found for $target"
  echo "$archive_name"
}

# --- Main ---

main() {
  local version="${1:-}"
  local target ext archive_name checksum_url archive_url tmpdir

  target=$(detect_target)
  ext="tar.gz"

  tmpdir=$(mktemp -d)
  TMPDIR_CLEANUP="$tmpdir"

  if [ -n "$RELEASE_BASE_URL" ]; then
    checksum_url="$RELEASE_BASE_URL/SHA256SUMS"
    info "Fetching latest checksum manifest..."
    curl -fsSL "$checksum_url" -o "$tmpdir/SHA256SUMS"

    if [ -z "$version" ]; then
      archive_name=$(select_archive_from_checksums "$tmpdir/SHA256SUMS" "$target" "$ext")
      version=$(parse_version_from_archive "$archive_name" "${DIST_SUFFIX}-${target}.${ext}")
    else
      archive_name="reela-v${version}${DIST_SUFFIX}-${target}.${ext}"
    fi
    archive_url="$RELEASE_BASE_URL/$archive_name"
  else
    if [ -z "$version" ]; then
      info "Detecting latest version..."
      version=$(get_latest_github_version)
    fi
    archive_name="reela-v${version}${DIST_SUFFIX}-${target}.${ext}"
    checksum_url="https://github.com/$REPO/releases/download/reela-cli-v${version}/SHA256SUMS"
    archive_url="https://github.com/$REPO/releases/download/reela-cli-v${version}/${archive_name}"
  fi

  info "Installing reela v$version for $target"
  info "Downloading $archive_name..."
  curl -fsSL "$archive_url" -o "$tmpdir/$archive_name"

  info "Verifying checksum..."
  if [ ! -f "$tmpdir/SHA256SUMS" ]; then
    curl -fsSL "$checksum_url" -o "$tmpdir/SHA256SUMS"
  fi
  (
    cd "$tmpdir" && grep " $archive_name$" SHA256SUMS |
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
