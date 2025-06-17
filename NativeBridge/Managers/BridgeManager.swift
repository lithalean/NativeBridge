//
//  BridgeManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/16/25.
//

import Foundation
import SwiftUI

@MainActor
class BridgeManager: ObservableObject {
    // Bridge Component Status
    @Published var swiftGodotStatus: ComponentStatus = .disconnected
    @Published var gameEngineStatus: ComponentStatus = .disconnected
    @Published var bridgeStatus: ComponentStatus = .disconnected
    @Published var runtimeStatus: ComponentStatus = .disconnected
    @Published var pckStatus: ComponentStatus = .disconnected
    
    // Performance Metrics
    @Published var performanceMetrics = PerformanceMetrics()
    
    // Debug Console
    @Published var debugMessages: [String] = []
    @Published var isDebugExpanded = false
    
    // Godot Engine Manager
    private let godotEngineManager = GodotEngineManager()
    
    struct ComponentStatus {
        let isConnected: Bool
        let displayName: String
        let lastUpdated: Date
        
        static let disconnected = ComponentStatus(isConnected: false, displayName: "Disconnected", lastUpdated: Date())
        static let connected = ComponentStatus(isConnected: true, displayName: "Connected", lastUpdated: Date())
        static let error = ComponentStatus(isConnected: false, displayName: "Error", lastUpdated: Date())
        static let loading = ComponentStatus(isConnected: false, displayName: "Loading", lastUpdated: Date())
        static let loaded = ComponentStatus(isConnected: true, displayName: "Loaded", lastUpdated: Date())
    }
    
    struct PerformanceMetrics {
        var bridgeLatency: Double = 0.0
        var memoryUsage: Double = 0.0
        var frameRate: Double = 60.0
        var buildTime: Double = 0.0
        
        // Trend indicators
        var latencyTrend: TrendDirection = .stable
        var memoryTrend: TrendDirection = .stable
        var frameRateTrend: TrendDirection = .stable
        var buildTimeTrend: TrendDirection = .stable
        
        enum TrendDirection {
            case improving, stable, degrading
            
            var icon: String {
                switch self {
                case .improving: return "↗️"
                case .stable: return "→"
                case .degrading: return "↘️"
                }
            }
            
            var color: Color {
                switch self {
                case .improving: return .green
                case .stable: return .blue
                case .degrading: return .red
                }
            }
        }
    }
    
    init() {
        addDebugMessage("🚀 BridgeManager initialized - Phase 2 PCK Loading Ready")
        startPerformanceMonitoring()
        
        // Monitor GodotEngineManager status changes
        setupGodotEngineObservation()
    }
    
    // MARK: - Godot Engine Observation
    
    private func setupGodotEngineObservation() {
        // Observe engine status changes
        godotEngineManager.$engineStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.updateEngineStatus(status)
            }
            .store(in: &cancellables)
        
        // Observe debug messages
        godotEngineManager.$debugMessages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] messages in
                // Add new messages to our debug console
                if let lastMessage = messages.last {
                    self?.addDebugMessage("🎮 " + lastMessage)
                }
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private func updateEngineStatus(_ status: GodotEngineManager.EngineStatus) {
        switch status {
        case .disconnected:
            gameEngineStatus = .disconnected
            swiftGodotStatus = .disconnected
            bridgeStatus = .disconnected
            runtimeStatus = .disconnected  // Runtime not implemented yet
            pckStatus = .disconnected
            
        case .initializing:
            gameEngineStatus = .loading
            swiftGodotStatus = .loading
            // Runtime stays disconnected in Phase 2
            
        case .connected:
            gameEngineStatus = .connected
            swiftGodotStatus = .connected
            bridgeStatus = .connected
            // Runtime stays disconnected - not implemented in Phase 2
            runtimeStatus = ComponentStatus(isConnected: false, displayName: "Phase 3", lastUpdated: Date())
            pckStatus = .disconnected
            
        case .loadingPck:
            pckStatus = .loading
            
        case .pckLoaded:
            pckStatus = .loaded
            
        case .error(let message):
            gameEngineStatus = .error
            addDebugMessage("❌ Engine Error: \(message)")
        }
    }
    
    // MARK: - Bridge Operations
    
    func connectGameEngine() async {
        addDebugMessage("🔄 Initiating GameEngine connection...")
        
        // Update status to show connection attempt
        swiftGodotStatus = ComponentStatus(isConnected: false, displayName: "Connecting...", lastUpdated: Date())
        
        // Initialize the Godot Engine
        await godotEngineManager.initializeEngine()
        
        // Update performance metrics
        updatePerformanceMetrics()
        
        addDebugMessage("✅ GameEngine connection sequence complete")
    }
    
    func loadPckFile(at path: String) async {
        addDebugMessage("📦 Loading PCK file: \(path)")
        
        // Update PCK status
        pckStatus = .loading
        
        // Load the PCK file through GodotEngineManager
        await godotEngineManager.loadPckFile(at: path)
        
        // Update performance metrics after loading
        updatePerformanceMetrics()
        
        if godotEngineManager.engineStatus == .pckLoaded {
            addDebugMessage("✅ PCK file loaded successfully")
            addDebugMessage("🔍 Project structure available in debug console")
        } else {
            addDebugMessage("❌ PCK file loading failed")
        }
    }
    
    func testGameEngineBridge() async {
        addDebugMessage("🧪 Testing GameEngine bridge communication...")
        
        let startTime = Date()
        let success = await godotEngineManager.sendTestMessage()
        let latency = Date().timeIntervalSince(startTime) * 1000 // Convert to milliseconds
        
        // Update bridge latency metric
        performanceMetrics.bridgeLatency = latency
        
        if success {
            addDebugMessage("✅ Bridge test successful - Latency: \(String(format: "%.2f", latency))ms")
            
            // If we have a loaded PCK, show some project info
            if let structure = godotEngineManager.projectStructure {
                addDebugMessage("📋 Loaded project: \(structure.totalFiles) files")
                if let mainScene = structure.mainScene {
                    addDebugMessage("🎬 Main scene: \(mainScene)")
                }
            }
        } else {
            addDebugMessage("❌ Bridge test failed")
        }
        
        updatePerformanceMetrics()
    }
    
    func inspectProjectStructure() {
        guard let structure = godotEngineManager.projectStructure else {
            addDebugMessage("❌ No project loaded - load a PCK file first")
            return
        }
        
        addDebugMessage("🔍 Displaying current project structure:")
        addDebugMessage(structure.debugDescription)
    }
    
    func loadPckFromBundle() async {
        addDebugMessage("🔍 Searching for PCK file in app bundle...")
        
        // Use your existing PCKManager to find the file
        await godotEngineManager.loadPckFromBundle()
        
        // Update performance metrics after loading
        updatePerformanceMetrics()
        
        if godotEngineManager.engineStatus == .pckLoaded {
            addDebugMessage("✅ PCK file loaded from bundle successfully")
            addDebugMessage("🔍 Project structure available - use 'Inspect Structure'")
        } else {
            addDebugMessage("❌ PCK file loading from bundle failed")
        }
    }
    
    func monitorBridgePerformance() {
        addDebugMessage("📊 Bridge performance monitoring enabled")
        addDebugMessage("📈 Current metrics:")
        addDebugMessage("   • Bridge Latency: \(String(format: "%.2f", performanceMetrics.bridgeLatency))ms \(performanceMetrics.latencyTrend.icon)")
        addDebugMessage("   • Memory Usage: \(String(format: "%.1f", performanceMetrics.memoryUsage))MB \(performanceMetrics.memoryTrend.icon)")
        addDebugMessage("   • Frame Rate: \(String(format: "%.1f", performanceMetrics.frameRate))fps \(performanceMetrics.frameRateTrend.icon)")
        addDebugMessage("   • Build Time: \(String(format: "%.1f", performanceMetrics.buildTime))s \(performanceMetrics.buildTimeTrend.icon)")
    }
    
    func debugBridgeOperations() {
        addDebugMessage("🔧 Bridge debug mode enabled")
        addDebugMessage("🎯 Bridge Components Status:")
        addDebugMessage("   • SwiftGodot: \(swiftGodotStatus.displayName)")
        addDebugMessage("   • GameEngine: \(gameEngineStatus.displayName)")
        addDebugMessage("   • Bridge: \(bridgeStatus.displayName)")
        addDebugMessage("   • Runtime: \(runtimeStatus.displayName)")
        addDebugMessage("   • PCK Status: \(pckStatus.displayName)")
        
        if let pckPath = godotEngineManager.loadedPckPath {
            addDebugMessage("📦 Loaded PCK: \(pckPath)")
        }
        
        if let structure = godotEngineManager.projectStructure {
            addDebugMessage("📊 Project Stats: \(structure.totalFiles) files, \(structure.scenes.count) scenes")
        }
    }
    
    func debugBundleContents() {
        addDebugMessage("🔍 Inspecting app bundle contents...")
        
        // Use PCKManager to get detailed bundle info
        let pckManager = PCKManager()
        pckManager.debugBundleContents()
        
        // Wait a moment for the async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for debugLine in pckManager.debugInfo {
                self.addDebugMessage("📦 \(debugLine)")
            }
        }
    }
    
    // MARK: - Performance Monitoring
    
    private func startPerformanceMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.updatePerformanceMetrics()
            }
        }
    }
    
    private func updatePerformanceMetrics() {
        // Simulate realistic performance metrics with some variation
        let oldLatency = performanceMetrics.bridgeLatency
        let oldMemory = performanceMetrics.memoryUsage
        let oldFrameRate = performanceMetrics.frameRate
        let oldBuildTime = performanceMetrics.buildTime
        
        // Update metrics with realistic values
        performanceMetrics.bridgeLatency = max(0.5, performanceMetrics.bridgeLatency + Double.random(in: -0.3...0.3))
        performanceMetrics.memoryUsage = max(8.0, min(50.0, performanceMetrics.memoryUsage + Double.random(in: -2.0...2.0)))
        performanceMetrics.frameRate = max(30.0, min(120.0, performanceMetrics.frameRate + Double.random(in: -5.0...5.0)))
        performanceMetrics.buildTime = max(15.0, min(45.0, performanceMetrics.buildTime + Double.random(in: -2.0...2.0)))
        
        // Update trends
        performanceMetrics.latencyTrend = calculateTrend(old: oldLatency, new: performanceMetrics.bridgeLatency, lowerIsBetter: true)
        performanceMetrics.memoryTrend = calculateTrend(old: oldMemory, new: performanceMetrics.memoryUsage, lowerIsBetter: true)
        performanceMetrics.frameRateTrend = calculateTrend(old: oldFrameRate, new: performanceMetrics.frameRate, lowerIsBetter: false)
        performanceMetrics.buildTimeTrend = calculateTrend(old: oldBuildTime, new: performanceMetrics.buildTime, lowerIsBetter: true)
    }
    
    private func calculateTrend(old: Double, new: Double, lowerIsBetter: Bool) -> PerformanceMetrics.TrendDirection {
        let threshold = 0.1
        let difference = new - old
        
        if abs(difference) < threshold {
            return .stable
        }
        
        if lowerIsBetter {
            return difference < 0 ? .improving : .degrading
        } else {
            return difference > 0 ? .improving : .degrading
        }
    }
    
    // MARK: - Debug Console
    
    private func addDebugMessage(_ message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        let timestamp = formatter.string(from: Date())
        let formattedMessage = "[\(timestamp)] \(message)"
        debugMessages.append(formattedMessage)
        
        // Keep only last 100 messages
        if debugMessages.count > 100 {
            debugMessages.removeFirst(debugMessages.count - 100)
        }
        
        print(formattedMessage)
    }
    
    func clearDebugConsole() {
        debugMessages.removeAll()
        addDebugMessage("🧹 Debug console cleared")
    }
    
    func exportDebugLog() {
        addDebugMessage("📤 Debug log export functionality would be implemented here")
        // In a real app, this would save the debug log to a file
    }
}

// MARK: - Extensions

import Combine
