#!/bin/bash

# Adjust paths if needed
SWIFTGODOTKIT_PATH="../SwiftGodotKit-main"
NATIVEBRIDGE_PATH="."

echo "📦 Copying godot_headers from SwiftGodotKit to NativeBridge..."

# Copy godot_headers folder
cp -R "${SWIFTGODOTKIT_PATH}/Sources/libgodot/godot_headers" "${NATIVEBRIDGE_PATH}/Sources/libgodot/"

if [ $? -eq 0 ]; then
  echo "✅ godot_headers copied successfully."
else
  echo "❌ Failed to copy godot_headers folder."
  exit 1
fi

# Fix .xcconfig file paths
XCCONFIG_FILE="${NATIVEBRIDGE_PATH}/NativeBridge.xcconfig"

if [ -f "$XCCONFIG_FILE" ]; then
  echo "🔧 Fixing HEADER_SEARCH_PATHS and SWIFT_INCLUDE_PATHS in $XCCONFIG_FILE..."

  sed -i.bak -E \
	-e 's|HEADER_SEARCH_PATHS =.*|HEADER_SEARCH_PATHS = $(inherited) $(PROJECT_DIR)/Sources/libgodot|' \
	-e 's|USER_HEADER_SEARCH_PATHS =.*|USER_HEADER_SEARCH_PATHS = $(inherited) $(PROJECT_DIR)/Sources/libgodot|' \
	-e 's|SWIFT_INCLUDE_PATHS =.*|SWIFT_INCLUDE_PATHS = $(inherited) $(PROJECT_DIR)/Sources/libgodot|' \
	"$XCCONFIG_FILE"

  echo "✅ Paths updated in $XCCONFIG_FILE"
else
  echo "⚠️ $XCCONFIG_FILE not found. Please update your search paths manually."
fi

echo "🎉 Done! Try building your project again."
