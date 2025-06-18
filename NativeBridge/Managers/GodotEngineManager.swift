//
//  GodotEngineManager.swift
//  NativeBridge
//
//  Integrated with custom GodotBridge and BridgeManager
//  Real custom libgodot.xcframework integration for Phase 1 completion
//

import Foundation
import SwiftUI

class GodotEngineManager: ObservableObject {
    @Published var isEngineRunning = false
    @Published var connectionStatus = "Disconnected"
    @Published var lastError: String? = nil
    @Published var debugMessages: [String] = []
    @Published var performanceMetrics: [String: Any] = [:]
    
    // Bridge integration
    private var bridgeInitialized = false
    private let pckManager = PCKManager()
    
    // Performance tracking
    private var operationCount = 0
    private var successCount = 0
    private var startTime = Date()
    
    init() {
        print("🎮 GodotEngineManager: Initializing with custom bridge...")
        updatePerformanceMetrics()
    }
    
    // MARK: - Engine Lifecycle
    
    func initializeEngine() {
        print("🎮 GodotEngineManager: Starting engine initialization...")
        addDebugMessage("Initializing custom bridge...")
        
        // Initialize the custom bridge
        let success = GodotBridge.initialize()
        bridgeInitialized = success
        
        if success {
            print("✅ GodotEngineManager: Custom bridge initialized successfully")
            updateStatus("Custom Bridge Initialized ✅")
            isEngineRunning = true
            
            // Test basic bridge functionality
            testBridgeCommunication()
        } else {
            print("❌ GodotEngineManager: Failed to initialize custom bridge")
            updateStatus("Bridge initialization failed", isError: true)
        }
        
        updatePerformanceMetrics()
    }
    
    func shutdownEngine() {
        print("🎮 GodotEngineManager: Shutting down engine...")
        addDebugMessage("Shutting down engine...")
        
        // Note: Add proper shutdown when GodotBridge supports it
        isEngineRunning = false
        bridgeInitialized = false
        updateStatus("Engine Shutdown")
        
        updatePerformanceMetrics()
    }
    
    // MARK: - Bridge Communication Testing
    
    func testBridgeCommunication() {
        print("🧪 Testing custom bridge communication:")
        addDebugMessage("Testing bridge communication...")
        
        operationCount += 1
        
        // Test engine version
        let version = GodotBridge.getEngineVersion()
        print("🔧 Engine Version: \(version)")
        addDebugMessage("Engine Version: \(version)")
        
        // Test platform detection
        let platform = GodotBridge.getPlatform()
        print("📱 Platform: \(platform)")
        addDebugMessage("Platform: \(platform)")
        
        // Test architecture
        let architecture = GodotBridge.getArchitecture()
        print("🏗️ Architecture: \(architecture)")
        addDebugMessage("Architecture: \(architecture)")
        
        // Test bridge status
        let initialized = GodotBridge.isInitialized
        print("🛠️ Bridge Initialized: \(initialized)")
        addDebugMessage("Bridge Status: \(initialized ? "✅ Ready" : "❌ Not Ready")")
        
        // Test file access
        let testFileExists = GodotBridge.fileExists(path: "res://project.godot")
        print("📄 File Access Test (res://project.godot): \(testFileExists ? "✅" : "❌")")
        addDebugMessage("File Access Test: \(testFileExists ? "✅ Working" : "❌ Failed")")
        
        successCount += 1
        updatePerformanceMetrics()
    }
    
    // MARK: - Enhanced PCK Loading with Comprehensive Debug
    
    func loadPCKBundle() {
        print("🎮 GodotEngineManager: Starting enhanced PCK loading process...")
        addDebugMessage("Starting PCK loading process...")
        
        // 1. Ensure bridge is initialized
        guard bridgeInitialized else {
            print("❌ Bridge not initialized - cannot load PCK")
            updateStatus("Bridge not initialized", isError: true)
            addDebugMessage("❌ Bridge not initialized")
            return
        }
        
        // 2. Debug PCKManager state
        print("🔍 PCKManager Debug State:")
        print("  Detected Path: \(pckManager.detectedPath ?? "nil")")
        print("  Bundle Info: \(pckManager.bundleInfo)")
        print("  Search Results Count: \(pckManager.searchResults.count)")
        
        addDebugMessage("PCK Detection State: \(pckManager.detectionStatus)")
        
        // Force re-detection if nothing found
        if pckManager.detectedPath == nil {
            print("🔄 No PCK detected, forcing re-detection...")
            addDebugMessage("🔄 Forcing PCK re-detection...")
            pckManager.forceRedetection()
        }
        
        // 3. Check detection results
        guard let pckPath = pckManager.detectedPath else {
            print("❌ GodotEngineManager Error: No PCK file found after enhanced detection")
            print("📋 Search results:")
            for result in pckManager.searchResults {
                print("  \(result)")
                addDebugMessage(result)
            }
            updateStatus("No PCK file found in bundle", isError: true)
            addDebugMessage("❌ No PCK file found in bundle")
            return
        }
        
        print("🎯 Using PCK path: \(pckPath)")
        addDebugMessage("🎯 Using PCK: \((pckPath as NSString).lastPathComponent)")
        
        // 4. Verify file exists before loading
        let fileExists = FileManager.default.fileExists(atPath: pckPath)
        print("📁 File exists check: \(fileExists)")
        
        if !fileExists {
            print("❌ PCK file does not exist at detected path: \(pckPath)")
            updateStatus("PCK file not accessible", isError: true)
            addDebugMessage("❌ PCK file not accessible")
            return
        }
        
        // 5. Get file info
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: pckPath)
            let fileSize = attributes[.size] as? Int64 ?? 0
            let sizeInMB = Double(fileSize) / (1024 * 1024)
            print("📊 PCK file size: \(String(format: "%.2f", sizeInMB)) MB")
            addDebugMessage("📊 PCK size: \(String(format: "%.2f", sizeInMB)) MB")
        } catch {
            print("⚠️ Could not get PCK file attributes: \(error)")
            addDebugMessage("⚠️ Could not get file attributes")
        }
        
        // 6. Attempt loading through bridge
        print("🔗 Loading PCK through custom bridge...")
        addDebugMessage("🔗 Loading PCK through bridge...")
        operationCount += 1
        
        let success = GodotBridge.loadResourcePack(path: pckPath)
        
        if success {
            print("✅ PCK loaded successfully through custom bridge")
            updateStatus("PCK Loaded via Custom Bridge ✅")
            addDebugMessage("✅ PCK loaded successfully!")
            successCount += 1
            
            // 7. Verify loading by testing file access
            testPCKFileAccess(pckPath)
        } else {
            print("❌ Failed to load PCK through custom bridge")
            updateStatus("PCK loading failed", isError: true)
            addDebugMessage("❌ PCK loading failed")
        }
        
        updatePerformanceMetrics()
    }
    
    // MARK: - PCK File Access Testing
    
    func testPCKFileAccess(_ pckPath: String) {
        print("🧪 Testing PCK file access after loading...")
        addDebugMessage("🧪 Testing PCK file access...")
        
        // Test common Godot project files
        let testPaths = [
            "res://project.godot",
            "res://project.binary",
            "res://main.tscn",
            "res://default_env.tres",
            "res://icon.png"
        ]
        
        var foundFiles = 0
        for testPath in testPaths {
            let exists = GodotBridge.fileExists(path: testPath)
            print("  \(exists ? "✅" : "❌") \(testPath)")
            if exists {
                foundFiles += 1
                addDebugMessage("✅ Found: \(testPath)")
            }
        }
        
        addDebugMessage("📁 Found \(foundFiles)/\(testPaths.count) common files")
        
        // Try to list res:// directory
        print("📁 Listing res:// directory contents...")
        let contents = GodotBridge.listDirectory(path: "res://")
        print("  Found \(contents.count) items in res://:")
        
        for item in contents.prefix(10) { // Show first 10 items
            print("    📄 \(item)")
        }
        
        if contents.count > 10 {
            print("    ... and \(contents.count - 10) more items")
        }
        
        addDebugMessage("📁 res:// contains \(contents.count) items")
        
        // Add some key files to debug messages
        for item in contents.prefix(5) {
            addDebugMessage("📄 \(item)")
        }
        
        if contents.count > 5 {
            addDebugMessage("... and \(contents.count - 5) more files")
        }
    }
    
    // MARK: - Bundle Debug Helper
    
    func debugBundleForPCK() {
        print("🔍 BUNDLE DEBUG: Comprehensive bundle analysis for PCK detection...")
        addDebugMessage("🔍 Analyzing bundle structure...")
        
        let bundle = Bundle.main
        print("📦 Bundle identifier: \(bundle.bundleIdentifier ?? "Unknown")")
        print("📦 Bundle path: \(bundle.bundlePath)")
        
        // Check if GameContent exists in the app bundle
        let bundlePath = bundle.bundlePath
        let gameContentPath = "\(bundlePath)/GameContent"
        
        print("🎮 Checking for GameContent directory...")
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: gameContentPath, isDirectory: &isDirectory)
        
        print("🎮 GameContent exists: \(exists)")
        print("🎮 Is directory: \(isDirectory.boolValue)")
        
        if exists && isDirectory.boolValue {
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: gameContentPath)
                print("🎮 GameContent contents (\(contents.count) items):")
                addDebugMessage("🎮 GameContent: \(contents.count) items")
                
                for item in contents {
                    let itemPath = "\(gameContentPath)/\(item)"
                    let itemExists = FileManager.default.fileExists(atPath: itemPath)
                    print("  📄 \(item) - exists: \(itemExists)")
                    
                    if item.hasSuffix(".pck") {
                        print("    🎯 Found PCK file: \(item)")
                        addDebugMessage("🎯 Found PCK: \(item)")
                    }
                }
            } catch {
                print("❌ Error reading GameContent: \(error)")
                addDebugMessage("❌ Error reading GameContent")
            }
        } else {
            print("⚠️ GameContent directory not found or not accessible")
            addDebugMessage("⚠️ GameContent not found")
            
            // Alternative: check if PCK is directly in bundle
            print("🔍 Checking for PCK files directly in bundle...")
            do {
                let bundleContents = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
                let pckFiles = bundleContents.filter { $0.hasSuffix(".pck") }
                print("📋 PCK files in bundle root: \(pckFiles)")
                addDebugMessage("📋 Bundle PCK files: \(pckFiles.count)")
            } catch {
                print("❌ Error reading bundle contents: \(error)")
                addDebugMessage("❌ Error reading bundle")
            }
        }
    }
    
    // MARK: - Status and Debug Management
    
    private func updateStatus(_ message: String, isError: Bool = false) {
        DispatchQueue.main.async {
            self.connectionStatus = message
            if isError {
                self.lastError = message
            } else {
                self.lastError = nil
            }
        }
    }
    
    private func addDebugMessage(_ message: String) {
        DispatchQueue.main.async {
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
            self.debugMessages.append("[\(timestamp)] \(message)")
            
            // Keep only last 50 messages
            if self.debugMessages.count > 50 {
                self.debugMessages.removeFirst(self.debugMessages.count - 50)
            }
        }
    }
    
    private func updatePerformanceMetrics() {
        DispatchQueue.main.async {
            let uptime = Date().timeIntervalSince(self.startTime)
            let successRate = self.operationCount > 0 ? Double(self.successCount) / Double(self.operationCount) * 100 : 0
            
            self.performanceMetrics = [
                "uptime": uptime,
                "operations": self.operationCount,
                "success_rate": successRate,
                "bridge_status": self.bridgeInitialized ? "Connected" : "Disconnected"
            ]
        }
    }
    
    // MARK: - Public Interface
    
    func connectEngine() {
        initializeEngine()
    }
    
    func disconnectEngine() {
        shutdownEngine()
    }
    
    func sendTestMessage() {
        testBridgeCommunication()
    }
    
    func loadPCK() {
        loadPCKBundle()
    }
    
    func analyzeProjectStructure() {
        guard let pckPath = pckManager.detectedPath else {
            addDebugMessage("❌ No PCK loaded for analysis")
            return
        }
        
        addDebugMessage("🔍 Analyzing project structure...")
        testPCKFileAccess(pckPath)
    }
    
    func clearDebugMessages() {
        DispatchQueue.main.async {
            self.debugMessages.removeAll()
        }
    }
}
