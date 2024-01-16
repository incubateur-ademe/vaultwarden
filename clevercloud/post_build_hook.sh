#!/usr/bin/env bash

# Define the repository
repo="dani-garcia/bw_web_builds"

# Use GitHub API to get the latest release data
json=$(curl -s "https://api.github.com/repos/$repo/releases/latest")

# Extract the tag name (release name) from the JSON response
# release_name=$(echo "$json" | grep -Po '"tag_name": "\K.*?(?=")')
release_name=$(echo "$json" | awk -F '"' '/tag_name/ {print $4}')

# Construct the asset download URL
asset_url="https://github.com/$repo/releases/download/$release_name/bw_web_${release_name}.tar.gz"

# Download the asset
curl -L -o "bw_web_${release_name}.tar.gz" "$asset_url"

# Extract the 'web-vault' folder from the tarball
tar -xzf "bw_web_${release_name}.tar.gz" "web-vault"

# Remove the tarball
rm -rf "bw_web_${release_name}.tar.gz"

# test "web-vault" folder exists
if [ -d "./web-vault" ]; then
    echo "web-vault folder exists"
else
    echo "web-vault folder does not exist"
    exit 1
fi