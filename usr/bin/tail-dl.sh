#!/bin/bash
set -euo pipefail

GNUPGHOME=$(mktemp -d)
export GNUPGHOME
trap 'rm -rf "$GNUPGHOME"' EXIT

echo "Fetching metadata..."
LATEST_JSON=$(curl -fsSL https://tails.net/install/v2/Tails/amd64/stable/latest.json)

IMG_URL=$(echo "$LATEST_JSON" | jq -r '.installations[]."installation-paths"[] | select(.type=="img") | .["target-files"][0].url')
SIG_URL="${IMG_URL}.sig"

echo "Image URL: $IMG_URL"
curl -fsSLO "$IMG_URL"

echo "Signature URL: $SIG_URL"
curl -fsSLO "$SIG_URL"
curl -fsSLO https://tails.net/tails-signing.key

echo "import signin keys"
gpg --import tails-signing.key

echo
echo "Fingerprint of imported key:"
gpg --fingerprint

echo
echo "Verifying signature..."
TZ=UTC gpg --verify "$(basename "$SIG_URL")" "$(basename "$IMG_URL")"

