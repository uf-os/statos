#!/bin/bash

set -ouex pipefail

# Create the programs directory
mkdir -p /abc/programs

# Download Godot v4.5-stable for Linux x86_64
echo "Downloading Godot v4.5-stable..."
curl -fsSL -o /tmp/godot.zip \
    "https://github.com/godotengine/godot/releases/download/4.5-stable/Godot_v4.5-stable_linux.x86_64.zip"

# Verify download was successful
if [[ ! -f /tmp/godot.zip ]]; then
    echo "Error: Failed to download Godot binary"
    exit 1
fi

# Extract the Godot binary to /abc/programs/
echo "Extracting Godot binary to /abc/programs/..."
unzip -q /tmp/godot.zip -d /abc/programs/

# Verify extraction was successful
if [[ ! -f /abc/programs/Godot_v4.5-stable_linux.x86_64 ]]; then
    echo "Error: Failed to extract Godot binary"
    exit 1
fi

# Clean up the temporary zip file
rm -f /tmp/godot.zip

echo "Godot v4.5-stable installed successfully to /abc/programs/"