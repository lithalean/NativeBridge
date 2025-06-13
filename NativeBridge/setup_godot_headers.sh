#!/bin/bash

set -e

TARGET_DIR="./Sources/libgodot/godot_headers"

echo "📥 Cloning godot_headers repo into $TARGET_DIR..."

if [ -d "$TARGET_DIR" ]; then
  echo "⚠️ Directory already exists at $TARGET_DIR. Pulling latest changes..."
  git -C "$TARGET_DIR" pull
else
  git clone https://github.com/godotengine/godot_headers.git "$TARGET_DIR"
fi

echo "✅ godot_headers are ready at $TARGET_DIR."
echo "You can now build your project."
