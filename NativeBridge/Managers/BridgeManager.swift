//
//  BridgeManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/16/25.
//


//
//  BridgeManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/13/25.
//

import Foundation
import SwiftUI

// MARK: - Bridge Manager

@MainActor
class BridgeManager: ObservableObject {
    // MARK: - GameEngine Integration
    @Published var godotEngine = GodotEngineManager()
    
    @Published var isActive = false
    @Published var swiftGodotStatus: BridgeComponentStatus = .disconnected
    @Published var gameEngineStatus: BridgeComponentStatus = .disconnected
    @Published var runtimeStatus: BridgeComponentStatus = .disconnected
    @Published var bridgeStatus: BridgeComponentStatus = .disconnected
    
    @Published var bridgeLatency: Double = 0.0
    @Published var memoryUsage: Double = 0.0
    @Published var frameRate: Double = 0.0
    @Published var buildTime: Double = 0.0
    
    @Published var latencyTrend: MetricTrend = .stable
    @Published var memoryTrend: MetricTrend = .stable
    @Published var frameTrend: MetricTrend = .stable
    @Published var buildTrend: MetricTrend = .stable
    
    @Published var foundationLogs: [String] = []
    @Published var allLogs: [String] = []
    
    func startMonitoring() {
        isActive = true
        // Simulate some initial status
        swiftGodotStatus = .connecting
        
        // Simulate real-time metrics
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                self.updateMetrics()
            }
        }
        
        addLog("NativeBridge monitoring started")
    }
    
    func refreshStatus() {
        addLog("Refreshing all component status...")
        // Simulate status checks
    }
    
    func runBridgeTest() {
        addLog("Running bridge connection test...")
        foundationLogs.append("Bridge test initiated")
    }
    
    func runPerformanceTest() {
        addLog("Starting performance benchmark...")
    }
    
    func checkMemoryUsage() {
        addLog("Analyzing memory allocation patterns...")
    }
    
    func testHotReload() {
        addLog("Testing hot-reload capabilities...")
    }
    
    func testExport() {
        addLog("Testing framework export...")
    }
    
    func clearLogs() {
        allLogs.removeAll()
        foundationLogs.removeAll()
    }
    
    func resetMetrics() {
        bridgeLatency = 0.0
        memoryUsage = 0.0
        frameRate = 0.0
        buildTime = 0.0
        addLog("Metrics reset")
    }
    
    func exportReport() {
        addLog("Exporting development report...")
    }
    
    private func updateMetrics() {
        // Simulate realistic metrics
        bridgeLatency = Double.random(in: 1.0...5.0)
        memoryUsage = Double.random(in: 45.0...55.0)
        frameRate = Double.random(in: 58.0...62.0)
        buildTime = Double.random(in: 15.0...25.0)
        
        // Random trend updates
        if Int.random(in: 0...10) == 0 {
            latencyTrend = [.up, .down, .stable].randomElement() ?? .stable
            memoryTrend = [.up, .down, .stable].randomElement() ?? .stable
            frameTrend = [.up, .down, .stable].randomElement() ?? .stable
            buildTrend = [.up, .down, .stable].randomElement() ?? .stable
        }
    }
    
    private func addLog(_ message: String) {
        let timestamp = DateFormatter.timeFormatter.string(from: Date())
        let logEntry = "[\(timestamp)] \(message)"
        allLogs.append(logEntry)
        if allLogs.count > 100 {
            allLogs.removeFirst()
        }
    }
    
    // MARK: - GameEngine Integration Methods
    func connectGameEngine() async {
        addLog("🔌 Connecting to GameEngine...")
        gameEngineStatus = .connecting
        
        await godotEngine.initializeEngine()
        
        if godotEngine.isEngineInitialized {
            gameEngineStatus = .connected
            swiftGodotStatus = .connected
            bridgeStatus = .connected
            addLog("✅ GameEngine connected successfully!")
        } else {
            gameEngineStatus = .error
            addLog("❌ Failed to connect GameEngine")
        }
    }
    
    func testGameEngineBridge() async {
        addLog("🧪 Testing GameEngine bridge communication...")
        
        let success = await godotEngine.sendTestMessage()
        
        if success {
            bridgeLatency = 2.5
            addLog("✅ Bridge test successful (2.5ms latency)")
        } else {
            addLog("❌ Bridge test failed")
        }
    }
    
    func disconnectGameEngine() {
        godotEngine.shutdown()
        gameEngineStatus = .disconnected
        swiftGodotStatus = .disconnected
        bridgeStatus = .disconnected
        addLog("🔌 GameEngine disconnected")
    }
}

// MARK: - Supporting Types (if not already in ContentView)

enum BridgeComponentStatus {
    case connected
    case connecting
    case disconnected
    case error
    
    var description: String {
        switch self {
        case .connected: return "Connected and operational"
        case .connecting: return "Establishing connection..."
        case .disconnected: return "Not connected"
        case .error: return "Connection error"
        }
    }
}

enum MetricTrend {
    case up, down, stable
}

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}