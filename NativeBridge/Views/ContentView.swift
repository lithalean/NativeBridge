//
//  ContentView.swift
//  NativeBridge
//
//  Fixed to work with current BridgeManager + GodotBridge architecture
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var pckManager = PCKManager()
    @State private var showingSidebar = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Modern gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black,
                        Color.blue.opacity(0.2),
                        Color.purple.opacity(0.1),
                        Color.black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Main content with glassmorphism
                mainContent(geometry: geometry)
                
                // Floating sidebar overlay (WWDC 25 style)
                if showingSidebar {
                    // Backdrop
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            toggleSidebar()
                        }
                    
                    // Floating WWDC 25 Sidebar (pure glass cards)
                    HStack {
                        modernFloatingSidebar
                            .frame(width: 320)
                            .padding(.leading, 16)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                        
                        Spacer()
                    }
                }
                
                // Floating circular toggle button (independent, not tied to any header)
                VStack {
                    HStack {
                        Button(action: { toggleSidebar() }) {
                            Image(systemName: showingSidebar ? "xmark.circle.fill" : "sidebar.left")
                                .font(.title2.weight(.medium))
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 50)
                                .background(.ultraThinMaterial, in: Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, 20)
                        .padding(.top, 60) // Independent positioning
                        
                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(1000) // Always on top
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            // Set up the connection between managers
            bridgeManager.setupWithPCKManager(pckManager)
        }
    }
    
    // MARK: - Main Content
    
    @ViewBuilder
    private func mainContent(geometry: GeometryProxy) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                // Top spacing for floating button
                Spacer()
                    .frame(height: 80)
                
                // Merged NativeBridge + Development Phase (no header concept)
                modernTitlePhaseSection
                
                // Bridge components grid
                modernBridgeStatus
                
                // PCK management section
                modernPCKSection
                
                // Development tools
                modernDevTools
                
                // Performance dashboard
                modernPerformanceSection
                
                // Debug console with glassmorphism
                modernDebugConsole
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showingSidebar)
    }
    
    // MARK: - Merged Title + Phase Section (No Header)
    
    private var modernTitlePhaseSection: some View {
        VStack(spacing: 20) {
            // NativeBridge Title
            VStack(spacing: 8) {
                Text("NativeBridge")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Text("Phase 1: Foundation + PCK Loading")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .textCase(.uppercase)
                    .tracking(1)
            }
            .padding(.top, 8)
            
            // Development Phase Progress
            VStack(spacing: 16) {
                HStack {
                    Text("Development Progress")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text("Phase 1")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(.blue.opacity(0.2), in: Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.blue.opacity(0.5), lineWidth: 1)
                        )
                }
                
                // Progress indicators - Phase 1: Foundation + PCK Loading
                HStack(spacing: 12) {
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 4)
                            .foregroundStyle(index < 3 ? .green : .white.opacity(0.3))
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: bridgeManager.isEngineConnected)
            }
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern Bridge Status
    
    private var modernBridgeStatus: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Bridge Components")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Circle()
                    .fill(allComponentsConnected ? .green : .orange)
                    .frame(width: 8, height: 8)
                    .scaleEffect(allComponentsConnected ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: allComponentsConnected)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ModernStatusCard(
                    title: "GodotBridge",
                    status: ComponentStatus(isConnected: bridgeManager.isEngineConnected, displayName: bridgeManager.status),
                    icon: "link"
                )
                ModernStatusCard(
                    title: "Engine",
                    status: ComponentStatus(isConnected: bridgeManager.isEngineConnected, displayName: "Custom libgodot.xcframework"),
                    icon: "gear"
                )
                ModernStatusCard(
                    title: "Bridge",
                    status: ComponentStatus(isConnected: bridgeManager.isEngineConnected, displayName: bridgeManager.lastActivity),
                    icon: "arrow.left.arrow.right"
                )
                ModernStatusCard(
                    title: "PCK Package",
                    status: ComponentStatus(isConnected: pckManager.isLoaded, displayName: getPCKStatusText()),
                    icon: "doc.badge.gearshape"
                )
            }
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern PCK Section
    
    private var modernPCKSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Package Management")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "cube.box")
                    .font(.title3)
                    .foregroundStyle(.orange)
            }
            
            VStack(spacing: 12) {
                ModernActionCard(
                    title: "Load PCK Bundle",
                    subtitle: "Find game.pck in app bundle",
                    icon: "tray.and.arrow.down",
                    color: .orange,
                    isEnabled: bridgeManager.isEngineConnected && !pckManager.isLoaded,
                    action: {
                        Task {
                            await bridgeManager.loadPCKBundle()
                        }
                    }
                )
                
                HStack(spacing: 12) {
                    ModernActionCard(
                        title: "Bundle Debug",
                        subtitle: "Inspect contents",
                        icon: "folder.badge.questionmark",
                        color: .purple,
                        isEnabled: true,
                        action: {
                            pckManager.debugBundleContents()
                        }
                    )
                    
                    ModernActionCard(
                        title: "Project Structure",
                        subtitle: "View loaded details",
                        icon: "list.bullet.rectangle",
                        color: .blue,
                        isEnabled: pckManager.isLoaded,
                        action: {
                            Task {
                                await bridgeManager.inspectProjectStructure()
                            }
                        }
                    )
                }
            }
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern Dev Tools
    
    private var modernDevTools: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Development Tools")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "wrench.and.screwdriver")
                    .font(.title3)
                    .foregroundStyle(.green)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ModernActionCard(
                    title: "Connect Engine",
                    subtitle: "Initialize bridge",
                    icon: "play.circle",
                    color: .green,
                    isEnabled: !bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.connectGameEngine()
                    }
                )
                
                ModernActionCard(
                    title: "Test Bridge",
                    subtitle: "Verify connection",
                    icon: "checkmark.circle",
                    color: .blue,
                    isEnabled: bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.sendTestMessage()
                    }
                )
                
                ModernActionCard(
                    title: "Performance",
                    subtitle: "Monitor metrics",
                    icon: "chart.line.uptrend.xyaxis",
                    color: .purple,
                    isEnabled: true,
                    action: {
                        bridgeManager.startPerformanceMonitoring()
                    }
                )
                
                ModernActionCard(
                    title: "Debug Bridge",
                    subtitle: "Inspect state",
                    icon: "ant",
                    color: .orange,
                    isEnabled: bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.testProjectAccess()
                    }
                )
            }
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern Performance Section
    
    private var modernPerformanceSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Performance Metrics")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "speedometer")
                    .font(.title3)
                    .foregroundStyle(.cyan)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ModernMetricCard(
                    title: "Latency",
                    value: String(format: "%.1f ms", bridgeManager.bridgeMetrics.bridgeLatency),
                    trend: .stable,
                    icon: "timer"
                )
                
                ModernMetricCard(
                    title: "Memory",
                    value: String(format: "%.0f MB", bridgeManager.bridgeMetrics.memoryUsage),
                    trend: .stable,
                    icon: "memorychip"
                )
                
                ModernMetricCard(
                    title: "Files",
                    value: "\(bridgeManager.bridgeMetrics.loadedFiles)",
                    trend: .up,
                    icon: "doc"
                )
                
                ModernMetricCard(
                    title: "Uptime",
                    value: String(format: "%.0f s", bridgeManager.bridgeMetrics.connectionDuration),
                    trend: .up,
                    icon: "clock"
                )
            }
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern Debug Console
    
    private var modernDebugConsole: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Debug Console")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button("Clear") {
                    bridgeManager.clearDebugMessages()
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.blue.opacity(0.2), in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(.blue.opacity(0.5), lineWidth: 1)
                )
            }
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 2) {
                    ForEach(bridgeManager.debugMessages.suffix(15), id: \.self) { message in
                        Text(message)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Add PCK debug info
                    ForEach(pckManager.debugInfo.suffix(10), id: \.self) { message in
                        Text(message)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.orange.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(16)
            }
            .frame(height: 160)
            .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
        }
        .padding(24)
        .background(.regularMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Modern Floating Sidebar (WWDC 25 Style - No Headers)
    
    private var modernFloatingSidebar: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20) {
                // Top spacing for floating design
                Spacer()
                    .frame(height: 40)
                
                // Development Control Card (floating)
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "hammer.circle.fill")
                            .font(.title)
                            .foregroundStyle(.orange.gradient)
                        
                        VStack(alignment: .center, spacing: 2) {
                            Text("Development")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Phase Control")
                                .font(.caption.weight(.medium))
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        
                        Spacer()
                    }
                    
                    // Current phase indicator
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue.gradient)
                            .frame(width: 4, height: 32)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Active Phase")
                                .font(.caption.weight(.medium))
                                .foregroundStyle(.white.opacity(0.7))
                            Text("Foundation + PCK Loading")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        Text(getPhaseProgress())
                            .font(.caption.weight(.bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.blue.opacity(0.2), in: Capsule())
                            .foregroundStyle(.blue)
                            .overlay(
                                Capsule()
                                    .stroke(.blue.opacity(0.5), lineWidth: 1)
                            )
                    }
                }
                .padding(20)
                .background(.regularMaterial.opacity(0.9), in: RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                )
                
                // Features Card (floating)
                VStack(spacing: 16) {
                    HStack {
                        Text("Features")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(systemName: "list.bullet.circle")
                            .font(.title3)
                            .foregroundStyle(.blue)
                    }
                    
                    VStack(spacing: 8) {
                        ForEach(getSidebarFeatures(), id: \.title) { feature in
                            ModernSidebarPhaseRow(feature: feature)
                        }
                    }
                }
                .padding(20)
                .background(.regularMaterial.opacity(0.9), in: RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                )
                
                // Bottom spacing
                Spacer()
                    .frame(height: 60)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity)
    }
    
    // MARK: - Helper Methods
    
    private func toggleSidebar() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            showingSidebar.toggle()
        }
    }
    
    private var allComponentsConnected: Bool {
        bridgeManager.isEngineConnected && pckManager.isLoaded
    }
    
    private func getPCKStatusText() -> String {
        switch pckManager.status {
        case .loading:
            return "Loading..."
        case .found:
            return "Found"
        case .loaded:
            return "Loaded (\(pckManager.pckContents.count) files)"
        case .notFound:
            return "Not Found"
        case .error:
            return "Error"
        }
    }
    
    private func getPhaseProgress() -> String {
        let engineConnected = bridgeManager.isEngineConnected
        let pckLoaded = pckManager.isLoaded
        
        if engineConnected && pckLoaded {
            return "95%"
        } else if engineConnected {
            return "75%"
        } else {
            return "25%"
        }
    }
    
    private func getSidebarFeatures() -> [SidebarFeature] {
        [
            SidebarFeature(title: "GodotBridge Integration", isComplete: bridgeManager.isEngineConnected),
            SidebarFeature(title: "Bridge Communication", isComplete: bridgeManager.isEngineConnected),
            SidebarFeature(title: "PCK Loading", isComplete: pckManager.isLoaded),
            SidebarFeature(title: "Project Structure", isComplete: pckManager.isLoaded && !pckManager.pckContents.isEmpty),
            SidebarFeature(title: "Runtime Integration", isComplete: false),
            SidebarFeature(title: "Enhanced Messaging", isComplete: false)
        ]
    }
}

// MARK: - Modern Supporting Views

struct ComponentStatus {
    let isConnected: Bool
    let displayName: String
}

struct ModernStatusCard: View {
    let title: String
    let status: ComponentStatus
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(status.isConnected ? .green : .red)
                
                Spacer()
                
                Circle()
                    .fill(status.isConnected ? .green : .red)
                    .frame(width: 8, height: 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(status.displayName)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .background(.ultraThinMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct ModernActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(isEnabled ? color : .gray)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(isEnabled ? .white : .gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(subtitle)
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(isEnabled ? .white.opacity(0.7) : .gray.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(16)
            .background(.ultraThinMaterial.opacity(isEnabled ? 0.8 : 0.4), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white.opacity(isEnabled ? 0.1 : 0.05), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }
}

enum TrendDirection {
    case up, down, stable
    
    var icon: String {
        switch self {
        case .up: return "↗"
        case .down: return "↘"
        case .stable: return "→"
        }
    }
    
    var color: Color {
        switch self {
        case .up: return .green
        case .down: return .red
        case .stable: return .blue
        }
    }
}

struct ModernMetricCard: View {
    let title: String
    let value: String
    let trend: TrendDirection
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.cyan)
                
                Spacer()
                
                Text(trend.icon)
                    .font(.caption2)
                    .foregroundStyle(trend.color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(title)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(.ultraThinMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct ModernSidebarPhaseRow: View {
    let feature: SidebarFeature
    
    var body: some View {
        HStack(spacing: 16) {
            // Feature status with circular design
            ZStack {
                Circle()
                    .fill(feature.isComplete ? AnyShapeStyle(.green.gradient) : AnyShapeStyle(.gray.opacity(0.2)))
                    .frame(width: 32, height: 32)
                
                Image(systemName: feature.isComplete ? "checkmark" : "circle")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(feature.isComplete ? .white : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.subheadline.weight(feature.isComplete ? .semibold : .medium))
                    .foregroundStyle(feature.isComplete ? .white : .white.opacity(0.7))
                
                // Progress indicator for incomplete items
                if !feature.isComplete {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 3)
                            
                            Capsule()
                                .fill(.blue.opacity(0.6))
                                .frame(width: geometry.size.width * 0.3, height: 3) // 30% progress
                        }
                    }
                    .frame(height: 3)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(feature.isComplete ? .green.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(feature.isComplete ? .green.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

struct SidebarFeature {
    let title: String
    let isComplete: Bool
}

// MARK: - BridgeManager Extension

extension BridgeManager {
    func setupWithPCKManager(_ pckManager: PCKManager) {
        // This method should exist in BridgeManager to set up the connection
        // If it doesn't exist, you can add it or handle the connection differently
    }
}
