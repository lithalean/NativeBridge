#!/bin/bash

# === Config ===
PROJECT_FILE="NativeBridge.xcodeproj"
TARGET_NAME="NativeBridge"

echo "🔍 Checking build settings for target: $TARGET_NAME"

# === Extract and filter build settings ===
xcodebuild -project "$PROJECT_FILE" -target "$TARGET_NAME" -showBuildSettings > _build_settings.tmp

echo ""
echo "📦 Swift Import Paths (SWIFT_INCLUDE_PATHS):"
grep SWIFT_INCLUDE_PATHS _build_settings.tmp || echo "❌ Not set"

echo ""
echo "📁 Header Search Paths (HEADER_SEARCH_PATHS):"
grep HEADER_SEARCH_PATHS _build_settings.tmp || echo "❌ Not set"

echo ""
echo "📂 User Header Search Paths (USER_HEADER_SEARCH_PATHS):"
grep USER_HEADER_SEARCH_PATHS _build_settings.tmp || echo "⚠️ Not explicitly set"

echo ""
echo "🧭 Resolved project directory:"
grep PROJECT_DIR _build_settings.tmp | head -1

# === Clean up ===
rm _build_settings.tmp

echo ""
echo "✅ Done. If any setting shows ❌ or ⚠️, open Xcode and check Build Settings manually."
