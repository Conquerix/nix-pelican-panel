#!/usr/bin/env bash

set -e

get_latest_version() {
    local repo=$1
    curl -s "https://api.github.com/repos/pelican-dev/$repo/releases/latest" | jq -r '.tag_name' | sed 's/^v//'
}

update_version() {
    local file=$1
    local version=$2
    sed -i "s/version = \".*\";/version = \"$version\";/" "$file"
}

update_source_hash() {
    local file=$1
    local repo=$2
    local version=$3
    local hash=$(nix-shell -p nix-prefetch-github --run "nix-prefetch-github pelican-dev $repo --rev v$version" | jq -r '.hash')
    sed -i "s|sha256 = \"sha256-.*\";|sha256 = \"$hash\";|" "$file"
}

update_vendor_hash() {
    local file=$1
    local flake=$2
    sed -i 's|vendorHash = "sha256-.*";|vendorHash = "";|' "$file"
    local vendor_hash=$(nix build ".#$flake" 2>&1 | grep -oP 'got:\s+\K\S+' | head -1)
    sed -i "s|vendorHash = \"\";|vendorHash = \"$vendor_hash\";|" "$file"
}

echo "🔄 Updating Pelican Panel packages..."

echo "📡 Fetching latest versions..."
panel_version=$(get_latest_version "panel")
wings_version=$(get_latest_version "wings")

echo "🔧 Updating Pelican Panel to $panel_version"
update_version "lib/pelican-panel.nix" "$panel_version"
update_source_hash "lib/pelican-panel.nix" "panel" "$panel_version"

echo "🔧 Updating Wings to $wings_version"
update_version "lib/wings.nix" "$wings_version"
update_source_hash "lib/wings.nix" "wings" "$wings_version"
update_vendor_hash "lib/wings.nix" "wings"

echo "✅ Done! Updated to Panel $panel_version, Wings $wings_version"
