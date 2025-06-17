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
    @State private var showSidebar = false
    
    // Add environment size classes for landscape detection
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Main content area
                detailView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Floating sidebar overlay (both orientations)
                if showSidebar {
                    // Backdrop
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showSidebar = false
                            }
                        }
                    
                    // Sidebar
                    HStack {
                        modernSidebarView
                            .frame(width: 320)
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
                            .padding(.leading, 16)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                        
                        Spacer()
                    }
                }
                
                // Floating sidebar toggle button
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showSidebar.toggle()
                            }
                        }) {
                            Image(systemName: showSidebar ? "xmark.circle.fill" : "sidebar.left")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(.ultraThinMaterial, in: Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .padding(.leading, 16)
                        .padding(.top, 8) // Much closer to top, out of the way
                        
                        Spacer()
                    }
                    Spacer()
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
    
    // Modern WWDC 25 style sidebar
    private var modernSidebarView: some View {
        VStack(spacing: 0) {
            // Header with glassmorphism
            VStack(spacing: 16) {
                Spacer()
                    .frame(height: 20) // Top spacing for close button
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "hammer.circle.fill")
                        .font(.title)
                        .foregroundStyle(.orange.gradient)
                    
                    VStack(alignment: .center, spacing: 2) {
                        Text("Development")
                            .font(.title2)
                            .bold()
                        Text("Phase Control")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Current phase indicator
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue.gradient)
                        .frame(width: 4, height: 32)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Active Phase")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(selectedPhase.title)
                            .font(.subheadline)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Text("\(selectedPhase.progress)%")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.blue.opacity(0.2))
                        .foregroundStyle(.blue)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .background(.ultraThinMaterial)
            
            Divider()
                .opacity(0.5)
            
            // Phase list
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(DevelopmentPhase.allCases, id: \.self) { phase in
                        Button(action: {
                            selectedPhase = phase
                            withAnimation(.spring()) {
                                showSidebar = false
                            }
                        }) {
                            ModernPhaseRow(phase: phase, isActive: phase == selectedPhase)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
    
    // Extract detail view as computed property for reuse
    private var detailView: some View {
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
                    
                    // Development Tools Section - UPDATED
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
                                title: "Connect Engine",
                                icon: "play.circle.fill",
                                color: .green,
                                action: {
                                    Task {
                                        await bridgeManager.connectGameEngine()
                                    }
                                }
                            )
                            
                            DevToolCard(
                                title: "Test Bridge",
                                icon: "link.circle.fill",
                                color: .blue,
                                action: {
                                    Task {
                                        await bridgeManager.testGameEngineBridge()
                                    }
                                }
                            )
                            
                            DevToolCard(
                                title: "Memory Check",
                                icon: "memorychip.fill",
                                color: .orange,
                                action: { bridgeManager.checkMemoryUsage() }
                            )
                            
                            DevToolCard(
                                title: "Hot Reload",
                                icon: "arrow.clockwise.circle.fill",
                                color: .purple,
                                action: { bridgeManager.testHotReload() }
                            )
                            
                            DevToolCard(
                                title: "Disconnect",
                                icon: "stop.circle.fill",
                                color: .red,
                                action: { bridgeManager.disconnectGameEngine() }
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

struct ModernPhaseRow: View {
    let phase: DevelopmentPhase
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Phase number with modern styling
            ZStack {
                Circle()
                    .fill(isActive ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.gray.opacity(0.2)))
                    .frame(width: 32, height: 32)
                
                Text(phase.number)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(isActive ? .white : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(phase.title)
                    .font(.subheadline)
                    .bold(isActive)
                    .foregroundStyle(isActive ? .primary : .secondary)
                
                // Progress bar
                HStack {
                    Text("\(phase.progress)% complete")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
                
                // Modern progress indicator
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(isActive ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.gray.opacity(0.4)))
                            .frame(width: geometry.size.width * CGFloat(phase.progress) / 100, height: 4)
                    }
                }
                .frame(height: 4)
            }
            
            Spacer()
            
            // Status indicator
            if isActive {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isActive ? .blue.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isActive ? .blue.opacity(0.3) : Color.clear, lineWidth: 1)
        )
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

#Preview {
    ContentView()
}
