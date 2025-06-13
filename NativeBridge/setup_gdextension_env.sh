#!/bin/bash

echo "📁 Ensuring godot_headers are present..."
HEADERS_PATH="./Sources/libgodot/godot_headers"
if [ ! -f "$HEADERS_PATH/godot_gdnative.h" ]; then
  echo "📥 Downloading godot_headers..."
  mkdir -p "$HEADERS_PATH"
  curl -L https://github.com/godotengine/godot-headers/archive/refs/heads/master.zip -o headers.zip
  unzip -q headers.zip
  mv godot-headers-master/* "$HEADERS_PATH"
  rm -rf godot-headers-master headers.zip
  echo "✅ Headers downloaded to $HEADERS_PATH"
else
  echo "✅ Headers already exist."
fi

echo "📦 Creating GDExtension module.modulemap..."
MODULEMAP_PATH="./Sources/libgodot/module.modulemap"
cat > "$MODULEMAP_PATH" <<EOF
module GDExtension [system] [extern_c] {
	umbrella "godot_headers"
	export *
}
EOF
echo "✅ Created $MODULEMAP_PATH"

echo "🔧 Creating NativeBridge.xcconfig..."
XCCONFIG_PATH="./NativeBridge.xcconfig"
cat > "$XCCONFIG_PATH" <<EOF
SWIFT_INCLUDE_PATHS = \$(PROJECT_DIR)/Sources/libgodot \$(PROJECT_DIR)/Sources/libgodot/godot_headers
HEADER_SEARCH_PATHS = \$(PROJECT_DIR)/Sources/libgodot \$(PROJECT_DIR)/Sources/libgodot/godot_headers
EOF
echo "✅ Created $XCCONFIG_PATH"

if [ -f "NativeBridge.xcodeproj/project.pbxproj" ]; then
  echo "🧠 Attempting to link xcconfig to Xcode project using Ruby..."
  ruby -r xcodeproj -e "
	project = Xcodeproj::Project.open('NativeBridge.xcodeproj')
	project.targets.each do |target|
	  project.build_configurations.each do |config|
		config.base_configuration_reference = project.files.new('path' => '$XCCONFIG_PATH')
	  end
	  target.build_configurations.each do |config|
		config.base_configuration_reference = project.files.new('path' => '$XCCONFIG_PATH')
	  end
	end
	project.save
  " 2>/dev/null && echo "✅ Linked $XCCONFIG_PATH to NativeBridge.xcodeproj" || echo "⚠️ Ruby or xcodeproj gem not found. Link it manually in Xcode."
else
  echo "❌ No Xcode project found. Please create NativeBridge.xcodeproj first."
fi

echo "🔍 Dumping current search paths for sanity check..."
xcodebuild -project NativeBridge.xcodeproj -showBuildSettings | grep -E 'SWIFT_INCLUDE_PATHS|HEADER_SEARCH_PATHS|PROJECT_DIR' || echo "⚠️ Couldn't read build settings."

echo "🧼 Tip: Run 'Shift+Cmd+K' in Xcode to clean the build before rebuilding."
