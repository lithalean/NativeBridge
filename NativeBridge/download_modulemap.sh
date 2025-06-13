#!/bin/bash

# === Configuration ===
DEST_DIR="NativeBridge/Sources/libgodot"
DEST_FILE="$DEST_DIR/module.modulemap"
RAW_URL="https://raw.githubusercontent.com/migueldeicaza/SwiftGodotKit/main/Sources/libgodot/module.modulemap"

# === Ensure Destination Folder Exists ===
mkdir -p "$DEST_DIR"

# === Download the Correct File ===
echo "📥 Downloading module.modulemap to $DEST_FILE..."
curl -sSL "$RAW_URL" -o "$DEST_FILE"

# === Verify the File ===
if grep -q "<!DOCTYPE html>" "$DEST_FILE"; then
	echo "❌ Error: Downloaded file is HTML, not a valid module.modulemap."
	rm "$DEST_FILE"
	exit 1
fi

if grep -q "module GDExtension" "$DEST_FILE"; then
	echo "✅ Successfully downloaded module.modulemap!"
else
	echo "⚠️ Warning: File downloaded, but content may not be correct."
fi
