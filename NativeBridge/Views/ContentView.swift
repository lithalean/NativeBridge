//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var pckManager = PCKManager()
    @State private var showingLeftSidebar = false
    @State private var showingRightSidebar = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Apple Car Dashboard Background
                AppleCarBackground()
                
                // Main Dashboard Area (Never pushed, sidebars float above)
                mainDashboard
                    .padding(.horizontal, GlassConstants.screenPadding)
                
                // Floating Left Sidebar (Mission Control) - Narrower for icons only
                if showingLeftSidebar {
                    HStack {
                        LeftMissionControlSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleLeftSidebar() }
                        )
                        .frame(width: 80) // Much narrower for icon-only
                        .padding(.leading, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 0)
                        Spacer()
                    }
                    .zIndex(100)
                }
                
                // Floating Right Sidebar (Debug Console) - Wider now
                if showingRightSidebar {
                    HStack {
                        Spacer()
                        RightDebuggerSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleRightSidebar() }
                        )
                        .frame(width: showingLeftSidebar ?
                               geometry.size.width - 120 : // Leave space for narrow left sidebar
                               geometry.size.width * 0.45)  // Wider when alone
                        .padding(.trailing, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: -5, y: 0)
                    }
                    .zIndex(100)
                }
                
                // Floating Sidebar Controls
                VStack {
                    HStack {
                        // Left Sidebar Toggle (only show when sidebar is closed)
                        if !showingLeftSidebar {
                            Button(action: { toggleLeftSidebar() }) {
                                GlassIcon("sidebar.left", size: .title2)
                            }
                            .buttonStyle(GlassButtons.CircularGlassButton())
                            .padding(.leading, GlassConstants.screenPadding)
                            .padding(.top, 60)
                        }
                        
                        Spacer()
                        
                        // Right Sidebar Toggle (only show when sidebar is closed)
                        if !showingRightSidebar {
                            Button(action: { toggleRightSidebar() }) {
                                GlassIcon("terminal", size: .title2)
                            }
                            .buttonStyle(GlassButtons.CircularGlassButton())
                            .padding(.trailing, GlassConstants.screenPadding)
                            .padding(.top, 60)
                        }
                    }
                    Spacer()
                }
                .zIndex(1000)
            }
        }
        .glassSpring(trigger: showingLeftSidebar || showingRightSidebar)
    }
    
    // MARK: - Apple Car Dashboard
    private var mainDashboard: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.xlSpacing) {
                GlassSpacer(.vertical, size: 100)
                
                // Combined System Status & Health Rings
                AppleCarSystemStatusAndHealth(bridgeManager: bridgeManager)
                
                GlassSpacer(.vertical, size: GlassConstants.xlSpacing)
            }
        }
    }
    
    private func toggleLeftSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingLeftSidebar.toggle()
        }
    }
    
    private func toggleRightSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingRightSidebar.toggle()
        }
    }
}

// MARK: - Apple Car Background (Same as before)
struct AppleCarBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.05, green: 0.05, blue: 0.1),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            AppleCarGridPattern()
            AppleCarAmbientGlow()
        }
    }
}

struct AppleCarGridPattern: View {
    var body: some View {
        Canvas { context, size in
            let gridSpacing: CGFloat = 40
            
            context.stroke(
                Path { path in
                    for x in stride(from: 0, through: size.width, by: gridSpacing) {
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for y in stride(from: 0, through: size.height, by: gridSpacing) {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                    }
                },
                with: .color(.white.opacity(0.02)),
                lineWidth: 0.5
            )
        }
        .allowsHitTesting(false)
    }
}

struct AppleCarAmbientGlow: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.blue.opacity(0.1), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .position(x: 200, y: 100)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 600, height: 600)
                .position(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Combined System Status & Health
struct AppleCarSystemStatusAndHealth: View {
    @ObservedObject var bridgeManager: BridgeManager
    
    var body: some View {
        VStack(spacing: 30) {
            Text("System Performance Monitor")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Performance Grid - Device Adaptive
            PerformanceMetricsGrid(bridgeManager: bridgeManager)
        }
    }
}

struct PerformanceMetricsGrid: View {
    @ObservedObject var bridgeManager: BridgeManager
    
    var body: some View {
        let coreCount = ProcessInfo.processInfo.processorCount
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        
        LazyVGrid(columns: gridColumns(for: coreCount, isIPad: isIPad), spacing: 20) {
            // Core Performance Rings
            ForEach(0..<min(coreCount, isIPad ? 8 : 6), id: \.self) { core in
                CorePerformanceRing(
                    coreNumber: core,
                    usage: Double.random(in: 0.1...0.9), // Simulated - replace with real data
                    frequency: Double.random(in: 2.0...3.5) // GHz
                )
            }
            
            // System Metrics
            SystemHealthRing(
                title: "Bridge",
                icon: "link.circle",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .cyan
            )
            
            SystemHealthRing(
                title: "Engine",
                icon: "engine.combustion",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .green
            )
            
            SystemHealthRing(
                title: "PCK",
                icon: "folder.badge.gearshape",
                isActive: bridgeManager.isPCKLoaded,
                progress: bridgeManager.isPCKLoaded ? 1.0 : 0.0,
                color: .blue
            )
            
            SystemHealthRing(
                title: "Memory",
                icon: "memorychip",
                isActive: true,
                progress: min(bridgeManager.bridgeMetrics.memoryUsage / 100, 1.0),
                color: .orange,
                valueText: String(format: "%.0f MB", bridgeManager.bridgeMetrics.memoryUsage)
            )
            
            SystemHealthRing(
                title: "GPU",
                icon: "cpu.fill",
                isActive: bridgeManager.isEngineConnected,
                progress: Double.random(in: 0.3...0.8), // Simulated GPU usage
                color: .purple,
                valueText: "Metal"
            )
            
            SystemHealthRing(
                title: "Latency",
                icon: "wifi",
                isActive: bridgeManager.isEngineConnected,
                progress: max(0.0, 1.0 - (bridgeManager.bridgeMetrics.bridgeLatency / 20.0)),
                color: .indigo,
                valueText: String(format: "%.1f ms", bridgeManager.bridgeMetrics.bridgeLatency)
            )
        }
    }
    
    private func gridColumns(for coreCount: Int, isIPad: Bool) -> [GridItem] {
        let columns = isIPad ? 6 : 4
        return Array(repeating: GridItem(.flexible()), count: columns)
    }
}

struct CorePerformanceRing: View {
    let coreNumber: Int
    let usage: Double
    let frequency: Double
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: usage)
                    .stroke(coreColor(for: usage), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: usage)
                
                VStack(spacing: 1) {
                    Text("C\(coreNumber)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(Int(usage * 100))%")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(String(format: "%.1f GHz", frequency))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    private func coreColor(for usage: Double) -> Color {
        switch usage {
        case 0.8...:
            return .red
        case 0.6...:
            return .orange
        case 0.4...:
            return .yellow
        default:
            return .green
        }
    }
}

struct SystemHealthRing: View {
    let title: String
    let icon: String
    let isActive: Bool
    let progress: Double
    let color: Color
    let valueText: String?
    
    init(title: String, icon: String, isActive: Bool, progress: Double, color: Color, valueText: String? = nil) {
        self.title = title
        self.icon = icon
        self.isActive = isActive
        self.progress = progress
        self.color = color
        self.valueText = valueText
    }
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: progress)
                
                GlassIcon(icon, color: isActive ? .white : .gray, size: .body)
            }
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            
            if let valueText = valueText {
                Text(valueText)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
        }
    }
}

// MARK: - Floating Left Mission Control Sidebar (Icon-Only)
struct LeftMissionControlSidebar: View {
    @ObservedObject var bridgeManager: BridgeManager
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Simple Header - Just Close Button
            HStack {
                Spacer()
                Button(action: onClose) {
                    GlassIcon("xmark.circle.fill", size: .body)
                }
                .buttonStyle(GlassButtons.CircularGlassButton())
            }
            .padding(GlassConstants.smallSpacing)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Icon-Only Controls
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: GlassConstants.smallSpacing) { // Tighter spacing
                    iconEngineControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    iconPCKManagement
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    iconTesting
                }
                .padding(.horizontal, GlassConstants.tightSpacing)
                .padding(.vertical, GlassConstants.smallSpacing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Icon-Only Controls (Compact Apple Style)
    private var iconEngineControls: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
                icon: "play.fill",
                color: .green,
                isEnabled: !bridgeManager.isEngineConnected,
                action: { bridgeManager.connectGameEngine() }
            )
            
            BigIconButton(
                icon: "stop.fill",
                color: .red,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.disconnectGameEngine() }
            )
        }
    }
    
    private var iconPCKManagement: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
                icon: "doc.badge.plus",
                color: .blue,
                isEnabled: bridgeManager.isEngineConnected && !bridgeManager.isPCKLoaded,
                action: {
                    Task {
                        await bridgeManager.loadPCKBundle()
                    }
                }
            )
            
            if bridgeManager.isPCKLoaded {
                BigIconButton(
                    icon: "doc.text.magnifyingglass",
                    color: .purple,
                    isEnabled: true,
                    action: {
                        Task {
                            await bridgeManager.inspectProjectStructure()
                        }
                    }
                )
            }
        }
    }
    
    private var iconTesting: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
                icon: "antenna.radiowaves.left.and.right",
                color: .orange,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.sendTestMessage() }
            )
            
            BigIconButton(
                icon: "checkmark.shield.fill",
                color: .cyan,
                isEnabled: bridgeManager.isPCKLoaded,
                action: { bridgeManager.testProjectAccess() }
            )
        }
    }
}

struct BigIconButton: View {
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GlassIcon(icon, color: isEnabled ? color : .gray, size: .title2) // Slightly smaller
                .frame(width: 44, height: 44) // More compact
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? color.opacity(0.15) : Color.gray.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isEnabled ? color.opacity(0.4) : Color.gray.opacity(0.3), lineWidth: 1.5)
                        )
                )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isEnabled ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

struct IconOnlyButton: View {
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GlassIcon(icon, color: isEnabled ? color : .gray, size: .title3)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? color.opacity(0.1) : Color.gray.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isEnabled ? color.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
                        )
                )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
    }
}

struct CompactActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                GlassIcon(icon, color: isEnabled ? color : .gray, size: .caption)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(isEnabled ? .white : .gray)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isEnabled ? color.opacity(0.1) : Color.gray.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEnabled ? color.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Floating Right Debugger Sidebar
struct RightDebuggerSidebar: View {
    @ObservedObject var bridgeManager: BridgeManager
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Debugger Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Debug Console")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(bridgeManager.debugMessages.count) messages")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: { bridgeManager.clearDebugMessages() }) {
                        GlassIcon("trash", size: .caption)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                    
                    Button(action: onClose) {
                        GlassIcon("xmark.circle.fill", size: .body)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                }
            }
            .padding(GlassConstants.smallSpacing)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Debugger Console
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(Array(bridgeManager.debugMessages.enumerated()), id: \.offset) { index, message in
                            DebuggerLogLine(
                                lineNumber: index + 1,
                                message: message,
                                messageType: getMessageType(message)
                            )
                            .id(index)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                }
                .onChange(of: bridgeManager.debugMessages.count) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(bridgeManager.debugMessages.count - 1, anchor: .bottom)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private func getMessageType(_ message: String) -> DebugMessageType {
        if message.contains("✅") { return .success }
        else if message.contains("❌") { return .error }
        else if message.contains("⚠️") { return .warning }
        else if message.contains("🔄") || message.contains("🔍") { return .info }
        else { return .debug }
    }
}

enum DebugMessageType {
    case success, error, warning, info, debug
    
    var color: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        case .info: return .blue
        case .debug: return .secondary
        }
    }
    
    var prefix: String {
        switch self {
        case .success: return "✅"
        case .error: return "❌"
        case .warning: return "⚠️"
        case .info: return "ℹ️"
        case .debug: return "🔧"
        }
    }
}

struct DebuggerLogLine: View {
    let lineNumber: Int
    let message: String
    let messageType: DebugMessageType
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // Line number
            Text(String(format: "%03d", lineNumber))
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(Color.secondary.opacity(0.7))
                .frame(width: 30, alignment: .trailing)
            
            // Message type indicator
            Text(messageType.prefix)
                .font(.caption2)
                .frame(width: 16, alignment: .center)
            
            // Message content
            Text(message)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(messageType.color)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 1)
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(messageType == .error ? Color.red.opacity(0.05) :
                      messageType == .warning ? Color.orange.opacity(0.05) :
                      Color.clear)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
