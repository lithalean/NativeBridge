#!/bin/bash

PROJECT_NAME="NativeBridge"
XCODEPROJ="${PROJECT_NAME}.xcodeproj"
XCCONFIG_FILE="NativeBridge.xcconfig"
XCCONFIG_PATH="./$XCCONFIG_FILE"

cat > "$XCCONFIG_PATH" << EOF
// NativeBridge.xcconfig

HEADER_SEARCH_PATHS = \$(inherited) \$(PROJECT_DIR)/Sources/libgodot/godot_headers
USER_HEADER_SEARCH_PATHS = \$(inherited) \$(PROJECT_DIR)/Sources/libgodot/godot_headers
SWIFT_INCLUDE_PATHS = \$(inherited) \$(PROJECT_DIR)/Sources/libgodot
EOF

echo "✅ Created $XCCONFIG_FILE with correct search paths."

if ! command -v ruby &> /dev/null || ! ruby -e "require 'xcodeproj'" &> /dev/null; then
  echo "❌ Ruby or xcodeproj gem not found."
  echo "Install Ruby and run: gem install xcodeproj"
  exit 1
fi

ruby <<RUBY
require 'xcodeproj'

project_path = '$XCODEPROJ'
xcconfig_path = '$XCCONFIG_FILE'

proj = Xcodeproj::Project.open(project_path)

file_ref = proj.files.find { |f| f.path == xcconfig_path }
unless file_ref
  file_ref = proj.new_file(xcconfig_path)
end

proj.targets.each do |target|
  target.build_configurations.each do |config|
	config.base_configuration_reference = file_ref
	puts "🔧 Set #{target.name} #{config.name} config to use #{xcconfig_path}"
  end
end

proj.save
RUBY

echo "✅ Updated $XCODEPROJ to use $XCCONFIG_FILE for all build configurations."
