#!/usr/bin/env bash
set -euo pipefail

VERSION="1.4.0"
DOWNLOAD_URL="https://github.com/kubernetes-monitoring/kubernetes-mixin/releases/download/version-${VERSION}/kubernetes-mixin-version-{$VERSION}.zip"

RELEASE_DIR="release/${VERSION}"
TMP_DIR=".tmp"
ZIP_FILE="${TMP_DIR}/kubernetes-mixin.zip"

if [ -d "$RELEASE_DIR" ]; then
  echo "Error: Target release directory $RELEASE_DIR already exists." >&2
  exit 1
fi

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

curl -L "$DOWNLOAD_URL" -o "$ZIP_FILE"
unzip -q "$ZIP_FILE" -d "$TMP_DIR/extracted"
mv "$TMP_DIR/extracted/dashboards_out" "$TMP_DIR/extracted/dashboards"

mkdir -p "$RELEASE_DIR"
# Move extracted contents to release/$VERSION
mv "$TMP_DIR/extracted"/* "$RELEASE_DIR"/

# Optionally clean up temp files
rm -rf "$TMP_DIR"
git add "$RELEASE_DIR"
echo "Kubernetes Mixin version $VERSION downloaded and extracted to $RELEASE_DIR."