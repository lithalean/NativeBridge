//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @State private var showDebugConsole = false
    @State private var selectedPhase = DevelopmentPhase.foundation
    
    var body: some View {
        NavigationView {
            // Development Phase Sidebar
            List(DevelopmentPhase.allCases, id: \.self) { phase in
                Button(action: {
                    selectedPhase = phase
                }) {
                    PhaseRow(phase: phase, isActive: phase == selectedPhase)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Development")
            
            // Detail View
            ZStack {
                // Dark development theme
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Header Section
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "hammer.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.orange)
                                
                                VStack(alignment: .leading) {
                                    Text("NativeBridge")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("Development Platform")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                // Live status indicator
                                HStack {
                                    Circle()
                                        .fill(bridgeManager.isActive ? .green : .red)
                                        .frame(width: 8, height: 8)
                                    Text(bridgeManager.isActive ? "Active" : "Inactive")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // Current phase banner
                            HStack {
                                Text("Phase \(selectedPhase.number): \(selectedPhase.title)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(selectedPhase.progress)% Complete")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.blue.opacity(0.3))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        // Bridge Status Grid
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                            BridgeStatusCard(
                                title: "SwiftGodot",
                                status: bridgeManager.swiftGodotStatus,
                                icon: "swift",
                                color: .orange
                            )
                            
                            BridgeStatusCard(
                                title: "GameEngine",
                                status: bridgeManager.gameEngineStatus,
                                icon: "engine.combustion.fill",
                                color: .blue
                            )
                            
                            BridgeStatusCard(
                                title: "EngineRuntime",
                                status: bridgeManager.runtimeStatus,
                                icon: "gearshape.2.fill",
                                color: .green
                            )
                            
                            BridgeStatusCard(
                                title: "Bridge Layer",
                                status: bridgeManager.bridgeStatus,
                                icon: "link",
                                color: .purple
                            )
                        }
                        
                        // Development Tools Section
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("Development Tools")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Button("Refresh All") {
                                    bridgeManager.refreshStatus()
                                }
                                .buttonStyle(.bordered)
                                .controlSize(.small)
                            }
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                                DevToolCard(
                                    title: "Bridge Test",
                                    icon: "play.circle.fill",
                                    color: .green,
                                    action: { bridgeManager.runBridgeTest() }
                                )
                                
                                DevToolCard(
                                    title: "Performance",
                                    icon: "speedometer",
                                    color: .orange,
                                    action: { bridgeManager.runPerformanceTest() }
                                )
                                
                                DevToolCard(
                                    title: "Memory Check",
                                    icon: "memorychip.fill",
                                    color: .blue,
                                    action: { bridgeManager.checkMemoryUsage() }
                                )
                                
                                DevToolCard(
                                    title: "Hot Reload",
                                    icon: "arrow.clockwise.circle.fill",
                                    color: .purple,
                                    action: { bridgeManager.testHotReload() }
                                )
                                
                                DevToolCard(
                                    title: "Export Test",
                                    icon: "square.and.arrow.up.circle.fill",
                                    color: .indigo,
                                    action: { bridgeManager.testExport() }
                                )
                                
                                DevToolCard(
                                    title: "Debug Log",
                                    icon: "terminal.fill",
                                    color: .gray,
                                    action: { showDebugConsole.toggle() }
                                )
                            }
                        }
                        
                        // Phase-specific content
                        selectedPhase.contentView(bridgeManager: bridgeManager)
                        
                        // Performance Metrics
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Real-time Metrics")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack(spacing: 20) {
                                MetricView(
                                    title: "Bridge Latency",
                                    value: String(format: "%.1f", bridgeManager.bridgeLatency) + "ms",
                                    trend: bridgeManager.latencyTrend
                                )
                                
                                MetricView(
                                    title: "Memory Usage",
                                    value: String(format: "%.1f", bridgeManager.memoryUsage) + "MB",
                                    trend: bridgeManager.memoryTrend
                                )
                                
                                MetricView(
                                    title: "Frame Rate",
                                    value: "\(Int(bridgeManager.frameRate)) FPS",
                                    trend: bridgeManager.frameTrend
                                )
                                
                                MetricView(
                                    title: "Build Time",
                                    value: String(format: "%.1f", bridgeManager.buildTime) + "s",
                                    trend: bridgeManager.buildTrend
                                )
                            }
                        }
                        .padding()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding()
                }
            }
            .navigationTitle(selectedPhase.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Clear Logs") { bridgeManager.clearLogs() }
                        Button("Reset Metrics") { bridgeManager.resetMetrics() }
                        Divider()
                        Button("Export Report") { bridgeManager.exportReport() }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showDebugConsole) {
            DebugConsoleView(bridgeManager: bridgeManager)
        }
        .onAppear {
            bridgeManager.startMonitoring()
        }
    }
}

// MARK: - Development Phases

enum DevelopmentPhase: String, CaseIterable {
    case foundation = "Foundation Bridge"
    case advanced = "Advanced APIs"
    case optimization = "Performance & Optimization"
    case devtools = "Developer Experience"
    
    var number: String {
        switch self {
        case .foundation: return "1"
        case .advanced: return "2"
        case .optimization: return "3"
        case .devtools: return "4"
        }
    }
    
    var title: String {
        return self.rawValue
    }
    
    var progress: Int {
        switch self {
        case .foundation: return 75  // Currently in progress
        case .advanced: return 0
        case .optimization: return 0
        case .devtools: return 0
        }
    }
    
    @ViewBuilder
    func contentView(bridgeManager: BridgeManager) -> some View {
        switch self {
        case .foundation:
            FoundationPhaseView(bridgeManager: bridgeManager)
        case .advanced:
            AdvancedPhaseView(bridgeManager: bridgeManager)
        case .optimization:
            OptimizationPhaseView(bridgeManager: bridgeManager)
        case .devtools:
            DevToolsPhaseView(bridgeManager: bridgeManager)
        }
    }
}

// MARK: - Component Views

struct PhaseRow: View {
    let phase: DevelopmentPhase
    let isActive: Bool
    
    var body: some View {
        HStack {
            Text(phase.number)
                .font(.caption)
                .bold()
                .frame(width: 20, height: 20)
                .background(isActive ? .blue : .gray.opacity(0.3))
                .foregroundColor(isActive ? .white : .secondary)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(phase.title)
                    .font(.subheadline)
                    .bold(isActive)
                
                Text("\(phase.progress)% complete")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct BridgeStatusCard: View {
    let title: String
    let status: BridgeComponentStatus
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.subheadline)
                    .bold()
                Spacer()
                statusIcon
            }
            
            Text(status.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    @ViewBuilder
    private var statusIcon: some View {
        switch status {
        case .connected:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
        case .connecting:
            ProgressView()
                .scaleEffect(0.7)
        case .error:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
        case .disconnected:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
    }
}

struct DevToolCard: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}

struct MetricView: View {
    let title: String
    let value: String
    let trend: MetricTrend
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                trendIcon
            }
            
            Text(value)
                .font(.headline)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var trendIcon: some View {
        switch trend {
        case .up:
            Image(systemName: "arrow.up.circle.fill")
                .foregroundColor(.red)
        case .down:
            Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(.green)
        case .stable:
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.blue)
        }
    }
}

// MARK: - Phase Content Views

struct FoundationPhaseView: View {
    let bridgeManager: BridgeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Foundation Bridge Tasks")
                .font(.headline)
            
            TaskChecklistView(tasks: [
                TaskItem(title: "SwiftGodot Integration", completed: true),
                TaskItem(title: "Basic Godot App Embedding", completed: false),
                TaskItem(title: "SwiftUI Wrapper Components", completed: false),
                TaskItem(title: "Message Passing System", completed: false),
                TaskItem(title: "Error Handling & Logging", completed: false)
            ])
            
            if !bridgeManager.foundationLogs.isEmpty {
                Text("Recent Activity")
                    .font(.subheadline)
                    .bold()
                
                LogView(logs: bridgeManager.foundationLogs)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct AdvancedPhaseView: View {
    let bridgeManager: BridgeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Advanced Bridge APIs")
                .font(.headline)
            
            Text("Coming in Phase 2...")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TaskChecklistView(tasks: [
                TaskItem(title: "Runtime Management", completed: false),
                TaskItem(title: "Developer Tools", completed: false),
                TaskItem(title: "Bridge API Framework", completed: false)
            ])
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct OptimizationPhaseView: View {
    let bridgeManager: BridgeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Performance & Optimization")
                .font(.headline)
            
            Text("Coming in Phase 3...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct DevToolsPhaseView: View {
    let bridgeManager: BridgeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Developer Experience")
                .font(.headline)
            
            Text("Coming in Phase 4...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TaskChecklistView: View {
    let tasks: [TaskItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(tasks, id: \.title) { task in
                HStack {
                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.completed ? .green : .gray)
                    Text(task.title)
                        .font(.subheadline)
                        .strikethrough(task.completed)
                    Spacer()
                }
            }
        }
    }
}

struct LogView: View {
    let logs: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(logs.prefix(5), id: \.self) { log in
                Text(log)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}

struct DebugConsoleView: View {
    let bridgeManager: BridgeManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(bridgeManager.allLogs, id: \.self) { log in
                        Text(log)
                            .font(.system(.caption, design: .monospaced))
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Debug Console")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        bridgeManager.clearLogs()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Data Models

struct TaskItem {
    let title: String
    let completed: Bool
}

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

// MARK: - Bridge Manager

@MainActor
class BridgeManager: ObservableObject {
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
}

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}

#Preview {
    ContentView()
}
