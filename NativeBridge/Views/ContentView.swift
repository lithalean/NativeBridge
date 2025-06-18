import SwiftUI

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var pckManager = PCKManager()
    @State private var showingSidebar = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GlassColors.backgroundGradient
                    .ignoresSafeArea()
                
                mainContent
                
                if showingSidebar {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            toggleSidebar()
                        }
                    
                    HStack {
                        sidebarContent
                            .frame(width: 320)
                            .padding(.leading, 16)
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: { toggleSidebar() }) {
                            Image(systemName: showingSidebar ? "xmark.circle.fill" : "sidebar.left")
                                .font(.title2.weight(.medium))
                        }
                        .buttonStyle(GlassCircularButton())
                        .padding(.leading, 20)
                        .padding(.top, 60)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(1000)
            }
        }
        .preferredColorScheme(.dark)
        .glassSpringAnimation(trigger: showingSidebar)
    }
    
    private var mainContent: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                GlassSpacer(height: 80)
                
                titleSection
                bridgeStatusSection
                pckManagementSection
                developmentToolsSection
                performanceSection
                debugConsoleSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }
    
    private var titleSection: some View {
        PhaseProgressCard(
            title: "NativeBridge",
            subtitle: "Phase 1: Foundation + PCK Loading",
            progress: 0.75,
            currentPhase: "Phase 1"
        )
    }
    
    private var bridgeStatusSection: some View {
        VStack(spacing: 16) {
            GlassSectionHeader(
                title: "Bridge Components",
                icon: "link",
                iconColor: GlassColors.success
            )
            
            GlassGrid(columns: 2) {
                ModernStatusCard(
                    title: "GodotBridge",
                    status: ComponentStatus(
                        isConnected: bridgeManager.isEngineConnected,
                        displayName: bridgeManager.status
                    ),
                    icon: "link"
                )
                
                ModernStatusCard(
                    title: "Engine",
                    status: ComponentStatus(
                        isConnected: bridgeManager.isEngineConnected,
                        displayName: "libgodot framework"
                    ),
                    icon: "gear"
                )
                
                ModernStatusCard(
                    title: "Bridge",
                    status: ComponentStatus(
                        isConnected: bridgeManager.isEngineConnected,
                        displayName: bridgeManager.lastActivity
                    ),
                    icon: "arrow.left.arrow.right"
                )
                
                ModernStatusCard(
                    title: "PCK Package",
                    status: ComponentStatus(
                        isConnected: false,
                        displayName: "Ready"
                    ),
                    icon: "doc.badge.gearshape"
                )
            }
        }
        .padding(24)
        .liquidGlassCard()
    }
    
    private var pckManagementSection: some View {
        VStack(spacing: 16) {
            GlassSectionHeader(
                title: "Package Management",
                icon: "cube.box",
                iconColor: GlassColors.warning
            )
            
            VStack(spacing: 12) {
                ModernActionCard(
                    title: "Load PCK Bundle",
                    subtitle: "Find game.pck in app bundle",
                    icon: "tray.and.arrow.down",
                    color: GlassColors.warning,
                    isEnabled: bridgeManager.isEngineConnected,
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
                        color: GlassColors.purple,
                        isEnabled: true,
                        action: {
                            pckManager.debugBundleContents()
                        }
                    )
                    
                    ModernActionCard(
                        title: "Project Structure",
                        subtitle: "View loaded details",
                        icon: "list.bullet.rectangle",
                        color: GlassColors.accent,
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
        .padding(24)
        .liquidGlassCard()
    }
    
    private var developmentToolsSection: some View {
        VStack(spacing: 16) {
            GlassSectionHeader(
                title: "Development Tools",
                icon: "wrench.and.screwdriver",
                iconColor: GlassColors.success
            )
            
            GlassGrid(columns: 2) {
                ModernActionCard(
                    title: "Connect Engine",
                    subtitle: "Initialize bridge",
                    icon: "play.circle",
                    color: GlassColors.success,
                    isEnabled: !bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.connectGameEngine()
                    }
                )
                
                ModernActionCard(
                    title: "Test Bridge",
                    subtitle: "Verify connection",
                    icon: "checkmark.circle",
                    color: GlassColors.accent,
                    isEnabled: bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.sendTestMessage()
                    }
                )
                
                ModernActionCard(
                    title: "Performance",
                    subtitle: "Monitor metrics",
                    icon: "chart.line.uptrend.xyaxis",
                    color: GlassColors.purple,
                    isEnabled: true,
                    action: {
                        bridgeManager.startPerformanceMonitoring()
                    }
                )
                
                ModernActionCard(
                    title: "Debug Bridge",
                    subtitle: "Inspect state",
                    icon: "ant",
                    color: GlassColors.warning,
                    isEnabled: bridgeManager.isEngineConnected,
                    action: {
                        bridgeManager.testProjectAccess()
                    }
                )
            }
        }
        .padding(24)
        .liquidGlassCard()
    }
    
    private var performanceSection: some View {
        VStack(spacing: 16) {
            GlassSectionHeader(
                title: "Performance Metrics",
                icon: "speedometer",
                iconColor: GlassColors.info
            )
            
            GlassGrid(columns: 2) {
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
        .liquidGlassCard()
    }
    
    private var debugConsoleSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Debug Console")
                    .glassHeadline()
                
                Spacer()
                
                Button("Clear") {
                    bridgeManager.clearDebugMessages()
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(GlassColors.accent)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(GlassColors.accent.opacity(0.2), in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(GlassColors.accent.opacity(0.5), lineWidth: 1)
                )
            }
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 2) {
                    ForEach(bridgeManager.debugMessages.suffix(20), id: \.self) { message in
                        Text(message)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(getMessageColor(for: message))
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
        .liquidGlassCard()
    }
    
    private var sidebarContent: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20) {
                GlassSpacer(height: 40)
                
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "hammer.circle.fill")
                            .font(.title)
                            .foregroundStyle(GlassColors.warning.gradient)
                        
                        VStack(spacing: 2) {
                            Text("Development")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(GlassColors.primary)
                            Text("Phase Control")
                                .glassCaption()
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(GlassColors.accent.gradient)
                            .frame(width: 4, height: 32)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Active Phase")
                                .glassCaption()
                            Text("Foundation + PCK Loading")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(GlassColors.primary)
                        }
                        
                        Spacer()
                        
                        Text("75%")
                            .glassStatusBadge(color: GlassColors.accent)
                    }
                }
                .padding(20)
                .pureGlassOverlay()
                
                GlassSpacer(height: 60)
            }
            .padding(.horizontal, 16)
        }
        .glassFadeTransition()
    }
    
    private func toggleSidebar() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            showingSidebar.toggle()
        }
    }
    
    private func getMessageColor(for message: String) -> Color {
        if message.contains("✅") {
            return GlassColors.success.opacity(0.8)
        } else if message.contains("❌") {
            return GlassColors.error.opacity(0.8)
        } else if message.contains("🔄") {
            return GlassColors.warning.opacity(0.8)
        } else if message.contains("📦") || message.contains("🎮") {
            return GlassColors.info.opacity(0.8)
        } else {
            return GlassColors.secondary
        }
    }
}
