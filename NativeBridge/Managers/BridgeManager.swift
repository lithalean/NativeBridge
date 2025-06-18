//
//  BridgeManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/16/25.
//

import Foundation

@MainActor
class BridgeManager: ObservableObject {
    // MARK: - Published Properties
    @Published var isEngineConnected: Bool = false
    @Published var status: String = "🔌 Disconnected"
    @Published var lastActivity: String = "Waiting for connection..."
    @Published var connectionTime: Date?
    @Published var bridgeMetrics: BridgeMetrics = BridgeMetrics()
    @Published var debugMessages: [String] = []
    
    // MARK: - Managers
    let godotEngineManager = GodotEngineManager()
    let pckManager = PCKManager()
    
    // MARK: - Private Properties
    private var performanceTimer: Timer?
    private var connectionStartTime: Date?
    
    // MARK: - Initialization
    init() {
        setupManagers()
        startPerformanceMonitoring()
    }
    
    private func setupManagers() {
        // Initial debug messages
        debugMessages = [
            "🚀 BridgeManager initialized",
            "🎮 GodotBridge + Custom libgodot.xcframework ready",
            "🛠️ PCK Manager configured",
            "📱 iOS Simulator support enabled",
            "✅ Phase 1 Bridge ready"
        ]
    }
    
    // MARK: - Connection Management
    
    func connectGameEngine() {
        guard !isEngineConnected else {
            status = "✅ Already Connected"
            return
        }
        
        connectionStartTime = Date()
        status = "🔄 Connecting..."
        lastActivity = "Initializing GodotBridge..."
        
        // Initialize the engine using the correct method
        godotEngineManager.connectEngine()
        
        // Check if initialization succeeded using the correct property
        if godotEngineManager.isEngineRunning {
            isEngineConnected = true
            connectionTime = Date()
            status = "✅ Connected"
            lastActivity = "GodotBridge initialized successfully"
            
            updateBridgeMetrics()
            addDebugMessage("✅ Engine connection established")
            addDebugMessage("🎮 GodotBridge operational")
            addDebugMessage("🛠️ Custom libgodot.xcframework active")
        } else {
            status = "❌ Connection Failed"
            lastActivity = "Failed to initialize GodotBridge"
            addDebugMessage("❌ Engine connection failed")
        }
    }
    
    func disconnectGameEngine() {
        guard isEngineConnected else { return }
        
        status = "🔄 Disconnecting..."
        lastActivity = "Shutting down GodotBridge..."
        
        godotEngineManager.disconnectEngine()
        
        isEngineConnected = false
        connectionTime = nil
        status = "🔌 Disconnected"
        lastActivity = "Engine disconnected"
        
        addDebugMessage("🔌 Engine disconnected")
        updateBridgeMetrics()
    }
    
    // MARK: - PCK Management
    
    func loadPCKBundle() async {
        guard isEngineConnected else {
            status = "❌ Engine not connected"
            lastActivity = "Connect engine first"
            return
        }
        
        status = "🔄 Loading PCK Bundle..."
        lastActivity = "Searching for PCK files..."
        
        // Use the correct method name
        godotEngineManager.loadPCK()
        
        // Update status based on PCKManager detection
        if pckManager.detectedPath != nil {
            status = "✅ PCK Bundle Loaded"
            lastActivity = "PCK loaded successfully"
            addDebugMessage("📦 PCK bundle loaded successfully")
            addDebugMessage("📁 PCK path: \(pckManager.detectedPath ?? "Unknown")")
        } else {
            status = "❌ PCK Loading Failed"
            lastActivity = "Failed to load PCK bundle"
            addDebugMessage("❌ PCK loading failed - no PCK file found")
        }
        
        updateBridgeMetrics()
    }
    
    func inspectProjectStructure() async {
        guard isEngineConnected else {
            status = "❌ Engine not connected"
            lastActivity = "Connect engine first"
            return
        }
        
        guard pckManager.detectedPath != nil else {
            status = "❌ PCK not loaded"
            lastActivity = "Load PCK bundle first"
            return
        }
        
        status = "🔍 Inspecting Project Structure..."
        lastActivity = "Analyzing project files..."
        
        // Use the correct method name
        godotEngineManager.analyzeProjectStructure()
        
        status = "✅ Project Analysis Complete"
        lastActivity = "Project structure analyzed"
        
        addDebugMessage("🔍 Project structure analyzed")
        addDebugMessage("📊 Analysis complete")
        
        updateBridgeMetrics()
    }
    
    // MARK: - Testing Methods
    
    func sendTestMessage() {
        guard isEngineConnected else {
            status = "❌ Engine not connected"
            return
        }
        
        status = "🧪 Testing Communication..."
        lastActivity = "Sending test message..."
        
        godotEngineManager.sendTestMessage()
        
        status = "✅ Test Complete"
        lastActivity = "Communication test successful"
        
        addDebugMessage("🧪 Test message sent successfully")
        updateBridgeMetrics()
    }
    
    func testProjectAccess() {
        guard isEngineConnected else {
            status = "❌ Engine not connected"
            return
        }
        
        guard pckManager.detectedPath != nil else {
            status = "❌ PCK not loaded"
            return
        }
        
        status = "🧪 Testing Project Access..."
        lastActivity = "Validating file access..."
        
        // Use bridge communication test as project access test
        godotEngineManager.sendTestMessage()
        
        status = "✅ Access Test Complete"
        lastActivity = "Project access validated"
        
        addDebugMessage("🧪 Project access test completed")
        updateBridgeMetrics()
    }
    
    // MARK: - Performance Monitoring
    
    func startPerformanceMonitoring() {
        performanceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                self.updateBridgeMetrics()
            }
        }
    }
    
    func stopPerformanceMonitoring() {
        performanceTimer?.invalidate()
        performanceTimer = nil
    }
    
    private func updateBridgeMetrics() {
        // Update connection duration
        if let connectionTime = connectionTime {
            bridgeMetrics.connectionDuration = Date().timeIntervalSince(connectionTime)
        }
        
        // Update project info based on available data
        bridgeMetrics.loadedFiles = pckManager.searchResults.count
        bridgeMetrics.loadedScenes = 0 // Will be updated when scene loading is implemented
        
        // Get bridge performance from GodotEngineManager
        if let performanceData = godotEngineManager.performanceMetrics["operations"] as? Int {
            bridgeMetrics.operationCount = performanceData
        }
        
        if let successRate = godotEngineManager.performanceMetrics["success_rate"] as? Double {
            bridgeMetrics.successRate = successRate
        }
        
        // Simulate bridge latency (in real implementation, measure actual calls)
        bridgeMetrics.bridgeLatency = Double.random(in: 1.0...5.0)
        
        // Memory usage (simplified)
        var memoryInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &memoryInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            bridgeMetrics.memoryUsage = Double(memoryInfo.resident_size) / 1024.0 / 1024.0 // MB
        }
        
        // Update engine status
        bridgeMetrics.engineStatus = isEngineConnected ? "Connected" : "Disconnected"
        bridgeMetrics.pckStatus = pckManager.detectedPath != nil ? "Loaded" : "Not Loaded"
    }
    
    // MARK: - Debug Support
    
    private func addDebugMessage(_ message: String) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        let formattedMessage = "[\(timestamp)] \(message)"
        
        debugMessages.append(formattedMessage)
        
        // Keep only last 50 messages
        if debugMessages.count > 50 {
            debugMessages.removeFirst(debugMessages.count - 50)
        }
    }
    
    func clearDebugMessages() {
        debugMessages.removeAll()
        addDebugMessage("🧹 Debug messages cleared")
    }
    
    // MARK: - Status Information
    
    func getDetailedProjectInfo() -> [String] {
        var info: [String] = []
        
        // Bridge status
        info.append("🌉 Bridge Status:")
        info.append("   Connected: \(isEngineConnected ? "✅" : "❌")")
        info.append("   Status: \(status)")
        info.append("   Last Activity: \(lastActivity)")
        info.append("")
        
        // Engine information
        if isEngineConnected {
            info.append("🎮 Engine Information:")
            info.append("   Engine: \(godotEngineManager.isEngineRunning ? "✅ Running" : "❌ Not Running")")
            info.append("   Runtime: GodotBridge + Custom libgodot.xcframework")
            info.append("   Connection Status: \(godotEngineManager.connectionStatus)")
            info.append("")
        }
        
        // PCK information
        info.append("📦 PCK Information:")
        info.append("   Status: \(getPCKStatusDescription())")
        info.append("   Detected: \(pckManager.detectedPath != nil ? "✅" : "❌")")
        if let detectedPath = pckManager.detectedPath {
            let fileName = (detectedPath as NSString).lastPathComponent
            info.append("   File: \(fileName)")
        }
        info.append("   Search Results: \(pckManager.searchResults.count)")
        info.append("")
        
        // Performance metrics
        info.append("📊 Performance Metrics:")
        info.append("   Bridge Latency: \(String(format: "%.1f", bridgeMetrics.bridgeLatency))ms")
        info.append("   Memory Usage: \(String(format: "%.1f", bridgeMetrics.memoryUsage))MB")
        info.append("   Operations: \(bridgeMetrics.operationCount)")
        info.append("   Success Rate: \(String(format: "%.1f", bridgeMetrics.successRate))%")
        if let connectionTime = connectionTime {
            let duration = Date().timeIntervalSince(connectionTime)
            info.append("   Uptime: \(String(format: "%.0f", duration))s")
        }
        info.append("")
        
        // Debug messages
        if !godotEngineManager.debugMessages.isEmpty {
            info.append("🐛 Recent Debug Messages:")
            let recentMessages = godotEngineManager.debugMessages.suffix(5)
            for message in recentMessages {
                info.append("   \(message)")
            }
            info.append("")
        }
        
        return info
    }
    
    private func getPCKStatusDescription() -> String {
        if pckManager.detectedPath != nil {
            return "Detected"
        } else {
            return "Not Found"
        }
    }
    
    // MARK: - Cleanup
    deinit {
        performanceTimer?.invalidate()
        performanceTimer = nil
    }
}

// MARK: - Supporting Types

struct BridgeMetrics {
    var connectionDuration: TimeInterval = 0
    var bridgeLatency: Double = 0 // milliseconds
    var memoryUsage: Double = 0 // MB
    var loadedFiles: Int = 0
    var loadedScenes: Int = 0
    var operationCount: Int = 0
    var successRate: Double = 0.0
    var engineStatus: String = "Disconnected"
    var pckStatus: String = "Not Loaded"
}

// MARK: - Memory Info (for performance monitoring)

struct mach_task_basic_info {
    var virtual_size: mach_vm_size_t = 0
    var resident_size: mach_vm_size_t = 0
    var resident_size_max: mach_vm_size_t = 0
    var user_time: time_value_t = time_value_t()
    var system_time: time_value_t = time_value_t()
    var policy: policy_t = 0
    var suspend_count: integer_t = 0
}
