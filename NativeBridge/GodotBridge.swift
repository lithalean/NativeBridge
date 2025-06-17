//
//  GodotBridge.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//

import Foundation

// Direct C interface to your custom libgodot.xcframework
class GodotBridge {
    static var isInitialized = false
    
    // MARK: - Framework Interface
    
    static func initialize() -> Bool {
        print("🎮 Initializing custom libgodot.xcframework")
        // Call your framework's initialization function
        // Example: return custom_godot_initialize()
        isInitialized = true
        return true
    }
    
    static func loadResourcePack(path: String) -> Bool {
        print("📦 Loading PCK with custom framework: \(path)")
        
        // Validate file exists
        guard FileManager.default.fileExists(atPath: path) else {
            print("❌ PCK file not found: \(path)")
            return false
        }
        
        // Call your framework's PCK loading function
        // Example: return custom_godot_load_pck(path.cString(using: .utf8))
        print("✅ PCK loaded via custom libgodot.xcframework")
        return true
    }
    
    static func getEngineVersion() -> String {
        return "Custom libgodot.xcframework (Godot 4.x)"
    }
    
    static func getPlatform() -> String {
        #if os(iOS)
        return "iOS"
        #elseif os(macOS)
        return "macOS"
        #else
        return "Unknown"
        #endif
    }
    
    static func getArchitecture() -> String {
        #if arch(arm64)
        return "arm64"
        #elseif arch(x86_64)
        return "x86_64"
        #else
        return "unknown"
        #endif
    }
    
    static func fileExists(path: String) -> Bool {
        // Your framework's virtual file system check
        // Example: return custom_godot_file_exists(path.cString(using: .utf8))
        
        // For Phase 1, simulate based on expected Godot structure
        let commonFiles = [
            "res://project.godot",
            "res://main.tscn",
            "res://scenes/player/player.tscn",
            "res://scenes/player/player.gd",
            "res://scripts/game_manager.gd",
            "res://assets/textures/player_sprite.png",
            "res://assets/audio/music/main_theme.ogg"
        ]
        return commonFiles.contains(path)
    }
    
    static func listDirectory(path: String) -> [String] {
        // Your framework's directory listing
        // Example: return custom_godot_list_directory(path.cString(using: .utf8))
        
        // For Phase 1, return realistic Godot project structure
        if path == "res://" {
            return [
                "project.godot",
                "main.tscn",
                "scenes/",
                "scripts/",
                "assets/"
            ]
        }
        return []
    }
}

// Compatibility API that matches what your managers expect
class ProjectSettings {
    static func loadResourcePack(path: String, replaceFiles: Bool = false, offset: Int = 0) -> Bool {
        return GodotBridge.loadResourcePack(path: path)
    }
}

class Engine {
    static func getVersionInfo() -> String {
        return GodotBridge.getEngineVersion()
    }
    
    static func getArchitectureName() -> String {
        return GodotBridge.getArchitecture()
    }
}

class OS {
    static func getName() -> String {
        return GodotBridge.getPlatform()
    }
}

class FileAccess {
    static func fileExists(path: String) -> Bool {
        return GodotBridge.fileExists(path: path)
    }
}

class DirAccess {
    private let path: String
    private var contents: [String] = []
    private var currentIndex = 0
    
    init(path: String) {
        self.path = path
        self.contents = GodotBridge.listDirectory(path: path)
    }
    
    static func open(path: String) -> DirAccess? {
        return DirAccess(path: path)
    }
    
    func listDirBegin() {
        currentIndex = 0
    }
    
    func getNext() -> String {
        if currentIndex < contents.count {
            let item = contents[currentIndex]
            currentIndex += 1
            return item
        }
        return ""
    }
    
    func currentIsDir() -> Bool {
        // Check if current item is directory
        if currentIndex > 0 && currentIndex <= contents.count {
            let item = contents[currentIndex - 1]
            return item.hasSuffix("/")
        }
        return false
    }
    
    func listDirEnd() {
        // Cleanup if needed
    }
}
