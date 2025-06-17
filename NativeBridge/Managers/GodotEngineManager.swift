//
//  GodotEngineManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/16/25.
//

// GodotEngineManager.swift
// Simplified GameEngine connection for NativeBridge
// Place this in: NativeBridge/Managers/GodotEngineManager.swift

import Foundation
// import SwiftGodot  // Uncomment when SwiftGodot package is properly configured

@MainActor
class GodotEngineManager: ObservableObject {
    @Published var engineStatus: EngineStatus = .disconnected
    @Published var debugMessages: [String] = []
    @Published var loadedPckPath: String? = nil
    @Published var projectStructure: ProjectStructure? = nil
    
    enum EngineStatus: Equatable {
        case disconnected
        case initializing
        case connected
        case loadingPck
        case pckLoaded
        case error(String)
        
        var displayName: String {
            switch self {
            case .disconnected: return "Disconnected"
            case .initializing: return "Initializing"
            case .connected: return "Connected"
            case .loadingPck: return "Loading PCK"
            case .pckLoaded: return "PCK Loaded"
            case .error(let message): return "Error: \(message)"
            }
        }
        
        // Equatable conformance for error case
        static func == (lhs: EngineStatus, rhs: EngineStatus) -> Bool {
            switch (lhs, rhs) {
            case (.disconnected, .disconnected),
                 (.initializing, .initializing),
                 (.connected, .connected),
                 (.loadingPck, .loadingPck),
                 (.pckLoaded, .pckLoaded):
                return true
            case (.error(let lhsMessage), .error(let rhsMessage)):
                return lhsMessage == rhsMessage
            default:
                return false
            }
        }
    }
    
    struct ProjectStructure {
        let mainScene: String?
        let scenes: [String]
        let scripts: [String]
        let resources: [String]
        let totalFiles: Int
        
        var debugDescription: String {
            var desc = "=== PROJECT STRUCTURE ===\n"
            desc += "Main Scene: \(mainScene ?? "Not set")\n"
            desc += "Total Files: \(totalFiles)\n\n"
            
            desc += "SCENES (\(scenes.count)):\n"
            for scene in scenes.prefix(10) {
                desc += "  • \(scene)\n"
            }
            if scenes.count > 10 {
                desc += "  ... and \(scenes.count - 10) more\n"
            }
            
            desc += "\nSCRIPTS (\(scripts.count)):\n"
            for script in scripts.prefix(10) {
                desc += "  • \(script)\n"
            }
            if scripts.count > 10 {
                desc += "  ... and \(scripts.count - 10) more\n"
            }
            
            desc += "\nRESOURCES (\(resources.count)):\n"
            for resource in resources.prefix(10) {
                desc += "  • \(resource)\n"
            }
            if resources.count > 10 {
                desc += "  ... and \(resources.count - 10) more\n"
            }
            
            return desc
        }
    }
    
    private var engine: GodotRuntime?
    
    init() {
        addDebugMessage("🚀 GodotEngineManager initialized")
    }
    
    // MARK: - Engine Lifecycle
    
    func initializeEngine() async {
        addDebugMessage("🔄 Initializing Godot Engine...")
        engineStatus = .initializing
        
        do {
            // Initialize Godot Runtime
            try await Task.sleep(nanoseconds: 500_000_000) // Simulate initialization
            
            // Create and configure engine
            engine = GodotRuntime()
            
            engineStatus = .connected
            addDebugMessage("✅ Godot Engine initialized successfully")
            addDebugMessage("🎮 Engine Version: \(getEngineVersion())")
            addDebugMessage("📱 Platform: \(getPlatformInfo())")
            
        } catch {
            let errorMessage = "Failed to initialize engine: \(error.localizedDescription)"
            engineStatus = .error(errorMessage)
            addDebugMessage("❌ \(errorMessage)")
        }
    }
    
    // MARK: - PCK Loading Integration
    
    func loadPckFile(at path: String) async {
        guard engineStatus == .connected else {
            addDebugMessage("❌ Cannot load PCK: Engine not connected")
            return
        }
        
        addDebugMessage("📦 Loading PCK file: \(path)")
        engineStatus = .loadingPck
        
        do {
            // Verify file exists
            let fileManager = FileManager.default
            guard fileManager.fileExists(atPath: path) else {
                throw NSError(domain: "PCKLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "PCK file not found at path: \(path)"])
            }
            
            // Get file size for debugging
            let attributes = try fileManager.attributesOfItem(atPath: path)
            let fileSize = attributes[.size] as? Int64 ?? 0
            addDebugMessage("📁 PCK file size: \(formatFileSize(fileSize))")
            
            // Load the PCK file using SwiftGodot
            let success = await loadPckFileWithSwiftGodot(path: path)
            
            if success {
                loadedPckPath = path
                engineStatus = .pckLoaded
                addDebugMessage("✅ PCK loaded successfully")
                
                // Inspect and display project structure
                await inspectProjectStructure()
                
            } else {
                engineStatus = .connected
                addDebugMessage("❌ Failed to load PCK file")
            }
            
        } catch {
            engineStatus = .error("PCK load failed: \(error.localizedDescription)")
            addDebugMessage("❌ PCK loading error: \(error.localizedDescription)")
        }
    }
    
    func loadPckFromBundle() async {
        guard engineStatus == .connected else {
            addDebugMessage("❌ Cannot load PCK: Engine not connected")
            return
        }
        
        addDebugMessage("🔍 Searching for PCK file in app bundle...")
        
        // Use PCKManager to find the PCK file
        let pckManager = PCKManager()
        pckManager.checkForPCK()
        
        // Wait for PCK detection to complete
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        switch pckManager.status {
        case .found:
            addDebugMessage("✅ Found PCK file: \(pckManager.detectedPath)")
            await loadPckFile(at: pckManager.detectedPath)
            
        case .notFound:
            addDebugMessage("❌ PCK file not found in bundle")
            addDebugMessage("📋 Expected locations checked:")
            addDebugMessage("   • GameContent/game.pck")
            addDebugMessage("   • PCK/game.pck")
            addDebugMessage("   • Pack/game.pck")
            addDebugMessage("   • GameData/game.pck")
            addDebugMessage("💡 To add a PCK file:")
            addDebugMessage("   1. Create a folder named 'GameContent' in your Xcode project")
            addDebugMessage("   2. Add your game.pck file to that folder")
            addDebugMessage("   3. Ensure it's included in the app bundle")
            engineStatus = .error("PCK file not found in bundle")
            
        case .error:
            addDebugMessage("❌ Error searching for PCK: \(pckManager.errorMessage)")
            engineStatus = .error("PCK search failed: \(pckManager.errorMessage)")
            
        case .loading:
            addDebugMessage("🔄 Still searching for PCK...")
        }
    }
    
    private func loadPckFileWithSwiftGodot(path: String) async -> Bool {
        addDebugMessage("🔄 Mounting PCK file system with SwiftGodot...")
        
        // Real SwiftGodot implementation would be:
        // return ProjectSettings.loadResourcePack(path)
        
        // For now, simulate the loading process
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        addDebugMessage("🔄 Parsing project settings...")
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        addDebugMessage("🔄 Loading resource index...")
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Simulate successful loading
        return true
    }
    
    // MARK: - Project Structure Inspection
    
    private func inspectProjectStructure() async {
        addDebugMessage("🔍 Inspecting project structure...")
        
        // Simulate project structure discovery
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Mock project structure - replace with real SwiftGodot calls
        let structure = ProjectStructure(
            mainScene: "res://scenes/Main.tscn",
            scenes: [
                "res://scenes/Main.tscn",
                "res://scenes/Menu.tscn",
                "res://scenes/Game.tscn",
                "res://scenes/UI/HUD.tscn",
                "res://scenes/UI/PauseMenu.tscn",
                "res://scenes/Player/Player.tscn",
                "res://scenes/Enemies/BasicEnemy.tscn",
                "res://scenes/Environment/Level1.tscn"
            ],
            scripts: [
                "res://scripts/GameManager.gd",
                "res://scripts/Player.gd",
                "res://scripts/Enemy.gd",
                "res://scripts/UI/MenuController.gd",
                "res://scripts/Utils/ResourceLoader.gd"
            ],
            resources: [
                "res://textures/player_sprite.png",
                "res://textures/enemy_sprite.png",
                "res://audio/music/background.ogg",
                "res://audio/sfx/jump.wav",
                "res://fonts/main_font.ttf",
                "res://data/levels.json"
            ],
            totalFiles: 42
        )
        
        projectStructure = structure
        addDebugMessage(structure.debugDescription)
        addDebugMessage("✅ Project structure inspection complete")
    }
    
    // MARK: - Real SwiftGodot Integration Methods
    // These would replace the mock methods above in production
    // Uncomment when SwiftGodot is properly integrated
    
    /*
    private func loadPckWithSwiftGodot(path: String) -> Bool {
        // Real implementation would use:
        return ProjectSettings.loadResourcePack(path)
    }
    
    private func getProjectMainScene() -> String? {
        // Real implementation would use:
        return ProjectSettings.getSetting("application/run/main_scene") as? String
    }
    
    private func enumerateProjectFiles() -> (scenes: [String], scripts: [String], resources: [String]) {
        // Real implementation would use:
        // let dir = DirAccess.open("res://")
        // Recursively traverse and categorize files
        return ([], [], [])
    }
    */
    
    // MARK: - Utility Methods
    
    func sendTestMessage() async -> Bool {
        guard engineStatus == .connected || engineStatus == .pckLoaded else {
            addDebugMessage("❌ Cannot send test message: Engine not ready")
            return false
        }
        
        addDebugMessage("📤 Sending test message to Godot Engine...")
        
        // Simulate message sending
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        let success = Bool.random() ? true : true // Force success for demo
        
        if success {
            addDebugMessage("✅ Test message sent successfully")
            if let structure = projectStructure {
                addDebugMessage("📋 Current project has \(structure.totalFiles) files loaded")
            }
        } else {
            addDebugMessage("❌ Test message failed")
        }
        
        return success
    }
    
    func shutdown() {
        addDebugMessage("🔄 Shutting down Godot Engine...")
        
        engine = nil
        loadedPckPath = nil
        projectStructure = nil
        engineStatus = .disconnected
        
        addDebugMessage("✅ Engine shutdown complete")
    }
    
    // MARK: - Debug Utilities
    
    private func addDebugMessage(_ message: String) {
        let timestamp = DateFormatter.debugTime.string(from: Date())
        let formattedMessage = "[\(timestamp)] \(message)"
        debugMessages.append(formattedMessage)
        
        // Keep only last 50 messages to prevent memory issues
        if debugMessages.count > 50 {
            debugMessages.removeFirst(debugMessages.count - 50)
        }
        
        print(formattedMessage) // Also log to console
    }
    
    private func getEngineVersion() -> String {
        // Real implementation would use:
        // return Engine.getVersionInfo()["string"] as? String ?? "Unknown"
        return "4.3.0"
    }
    
    private func getPlatformInfo() -> String {
        // Real implementation would use:
        // return OS.getPlatformName()
        return "iOS ARM64"
    }
    
    private func formatFileSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}

// MARK: - Extensions

extension DateFormatter {
    static let debugTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()
}

// MARK: - Mock GodotRuntime for Development
// Remove this when using real SwiftGodot integration

class GodotRuntime {
    init() {
        // Mock initialization
    }
}
