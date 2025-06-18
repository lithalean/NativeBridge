//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//  Updated to use modular glass system
//

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
                            .padding(.leading, DesignTokens.mediumSpacing)
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: { toggleSidebar() }) {
                            Image(systemName: showingSidebar ? "xmark.circle.fill" : "sidebar.left")
                                .font(.title2.weight(.medium))
                        }
                        .circularGlassButton(color: GlassColors.accent, size: 50)
                        .padding(.leading, DesignTokens.screenPadding)
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
        GlassScrollView {
            AdaptiveGlassSpacer(compact: 60, regular: 80)
            
            titleSection
            bridgeStatusSection
            pckManagementSection
            developmentToolsSection
            performanceSection
            debugConsoleSection
        }
    }
    
    private var titleSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                HStack {
                    Image(systemName: "link.circle.fill")
                        .font(.title.weight(.bold))
                        .foregroundStyle(GlassColors.accentGradient)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("NativeBridge")
                            .glassTitle()
                        
                        Text("Darwin ARM64 Bridge Technology")
                            .glassSubtitle()
                    }
                    
                    Spacer()
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: DesignTokens.smallRadius)
                        .fill(GlassColors.successGradient)
                        .frame(width: 4, height: 32)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Status")
                            .glassCaption()
                        Text("Phase 1 Complete")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(GlassColors.success)
                    }
                    
                    Spacer()
                    
                    Text("✅")
                        .font(.title2)
                }
            }
        }
    }
    
    private var bridgeStatusSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                GlassSectionHeader(
                    title: "Bridge Components",
                    icon: "link",
                    iconColor: GlassColors.success
                )
                
                AdaptiveGlassGrid(compactColumns: 1, regularColumns: 2) {
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
                            isConnected: bridgeManager.isPCKLoaded,
                            displayName: bridgeManager.isPCKLoaded ? "Loaded" : "Ready"
                        ),
                        icon: "doc.badge.gearshape"
                    )
                }
            }
        }
    }
    
    private var pckManagementSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                GlassSectionHeader(
                    title: "Package Management",
                    icon: "cube.box",
                    iconColor: GlassColors.warning
                )
                
                VStack(spacing: DesignTokens.mediumSpacing) {
                    Button(action: {
                        Task {
                            await bridgeManager.loadPCKBundle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.down")
                                .font(.title3)
                                .foregroundStyle(GlassColors.warning)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Load PCK Bundle")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Find game.pck in app bundle")
                                    .glassCaption()
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(GlassColors.secondary)
                        }
                        .padding(DesignTokens.itemPadding)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.warning, isEnabled: bridgeManager.isEngineConnected)
                    
                    HStack(spacing: DesignTokens.mediumSpacing) {
                        Button(action: {
                            pckManager.debugBundleContents()
                        }) {
                            VStack(spacing: DesignTokens.smallSpacing) {
                                Image(systemName: "folder.badge.questionmark")
                                    .font(.title2)
                                    .foregroundStyle(GlassColors.purple)
                                
                                VStack(spacing: 2) {
                                    Text("Bundle Debug")
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("Inspect contents")
                                        .font(.caption2)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                            }
                            .padding(DesignTokens.compactPadding)
                            .frame(maxWidth: .infinity)
                        }
                        .actionCardButton(color: GlassColors.purple, isEnabled: true)
                        
                        Button(action: {
                            Task {
                                await bridgeManager.inspectProjectStructure()
                            }
                        }) {
                            VStack(spacing: DesignTokens.smallSpacing) {
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.title2)
                                    .foregroundStyle(GlassColors.accent)
                                
                                VStack(spacing: 2) {
                                    Text("Project Structure")
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("View loaded details")
                                        .font(.caption2)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                            }
                            .padding(DesignTokens.compactPadding)
                            .frame(maxWidth: .infinity)
                        }
                        .actionCardButton(color: GlassColors.accent, isEnabled: true)
                    }
                }
            }
        }
    }
    
    private var developmentToolsSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                GlassSectionHeader(
                    title: "Development Tools",
                    icon: "wrench.and.screwdriver",
                    iconColor: GlassColors.success
                )
                
                AdaptiveGlassGrid(compactColumns: 1, regularColumns: 2) {
                    Button(action: {
                        bridgeManager.connectGameEngine()
                    }) {
                        VStack(spacing: DesignTokens.smallSpacing) {
                            Image(systemName: "play.circle")
                                .font(.title2)
                                .foregroundStyle(GlassColors.success)
                            
                            VStack(spacing: 2) {
                                Text("Connect Engine")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Initialize bridge")
                                    .font(.caption2)
                                    .foregroundStyle(GlassColors.secondary)
                            }
                        }
                        .padding(DesignTokens.compactPadding)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.success, isEnabled: !bridgeManager.isEngineConnected)
                    
                    Button(action: {
                        bridgeManager.sendTestMessage()
                    }) {
                        VStack(spacing: DesignTokens.smallSpacing) {
                            Image(systemName: "checkmark.circle")
                                .font(.title2)
                                .foregroundStyle(GlassColors.accent)
                            
                            VStack(spacing: 2) {
                                Text("Test Bridge")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Verify connection")
                                    .font(.caption2)
                                    .foregroundStyle(GlassColors.secondary)
                            }
                        }
                        .padding(DesignTokens.compactPadding)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.accent, isEnabled: bridgeManager.isEngineConnected)
                    
                    Button(action: {
                        bridgeManager.startPerformanceMonitoring()
                    }) {
                        VStack(spacing: DesignTokens.smallSpacing) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.title2)
                                .foregroundStyle(GlassColors.purple)
                            
                            VStack(spacing: 2) {
                                Text("Performance")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Monitor metrics")
                                    .font(.caption2)
                                    .foregroundStyle(GlassColors.secondary)
                            }
                        }
                        .padding(DesignTokens.compactPadding)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.purple, isEnabled: true)
                    
                    Button(action: {
                        bridgeManager.testProjectAccess()
                    }) {
                        VStack(spacing: DesignTokens.smallSpacing) {
                            Image(systemName: "ant")
                                .font(.title2)
                                .foregroundStyle(GlassColors.warning)
                            
                            VStack(spacing: 2) {
                                Text("Debug Bridge")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Inspect state")
                                    .font(.caption2)
                                    .foregroundStyle(GlassColors.secondary)
                            }
                        }
                        .padding(DesignTokens.compactPadding)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.warning, isEnabled: bridgeManager.isEngineConnected)
                }
            }
        }
    }
    
    private var performanceSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                GlassSectionHeader(
                    title: "Performance Metrics",
                    icon: "speedometer",
                    iconColor: GlassColors.info
                )
                
                AdaptiveGlassGrid(compactColumns: 1, regularColumns: 2) {
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
        }
    }
    
    private var debugConsoleSection: some View {
        GlassCard(style: .floating) {
            VStack(spacing: DesignTokens.mediumSpacing) {
                HStack {
                    Text("Debug Console")
                        .glassHeadline()
                    
                    Spacer()
                    
                    Button("Clear") {
                        bridgeManager.clearDebugMessages()
                    }
                    .minimalGlassButton(color: GlassColors.accent)
                }
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(bridgeManager.debugMessages.suffix(20), id: \.self) { message in
                            Text(message)
                                .glassMonospace()
                                .foregroundStyle(getMessageColor(for: message))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(DesignTokens.itemPadding)
                }
                .frame(height: 160)
                .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: DesignTokens.mediumRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.mediumRadius)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                )
            }
        }
    }
    
    private var sidebarContent: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DesignTokens.largeSpacing) {
                AdaptiveGlassSpacer(compact: 30, regular: 40)
                
                // Development Phase Control Card
                GlassCard(style: .floating) {
                    VStack(spacing: DesignTokens.mediumSpacing) {
                        HStack {
                            Image(systemName: "hammer.circle.fill")
                                .font(.title)
                                .foregroundStyle(GlassColors.warningGradient)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Development")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Phase Control")
                                    .glassCaption()
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            RoundedRectangle(cornerRadius: DesignTokens.smallRadius)
                                .fill(GlassColors.accentGradient)
                                .frame(width: 4, height: 32)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Active Phase")
                                    .glassCaption()
                                Text("Foundation + PCK Loading")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(GlassColors.primary)
                            }
                            
                            Spacer()
                            
                            Text("100%")
                                .glassStatusBadge(color: GlassColors.success)
                        }
                    }
                }
                
                // Development Progress Card
                GlassCard(style: .floating) {
                    VStack(spacing: DesignTokens.mediumSpacing) {
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.title)
                                .foregroundStyle(GlassColors.accentGradient)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Progress")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(GlassColors.primary)
                                Text("Development Phases")
                                    .glassCaption()
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: DesignTokens.mediumSpacing) {
                            // Phase 1
                            HStack {
                                Circle()
                                    .fill(GlassColors.success)
                                    .frame(width: 12, height: 12)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phase 1: Foundation")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("Bridge + Glass UI")
                                        .font(.caption)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                                
                                Spacer()
                                
                                Text("✅")
                                    .font(.caption)
                            }
                            
                            // Phase 2
                            HStack {
                                Circle()
                                    .fill(GlassColors.warning)
                                    .frame(width: 12, height: 12)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phase 2: Runtime")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("Enhanced Communication")
                                        .font(.caption)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                                
                                Spacer()
                                
                                Text("🔄")
                                    .font(.caption)
                            }
                            
                            // Phase 3
                            HStack {
                                Circle()
                                    .fill(GlassColors.secondary)
                                    .frame(width: 12, height: 12)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phase 3: Advanced")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("Scene Integration")
                                        .font(.caption)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                                
                                Spacer()
                                
                                Text("📋")
                                    .font(.caption)
                            }
                            
                            // Phase 4
                            HStack {
                                Circle()
                                    .fill(GlassColors.secondary)
                                    .frame(width: 12, height: 12)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phase 4: Production")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(GlassColors.primary)
                                    Text("Optimization & Deploy")
                                        .font(.caption)
                                        .foregroundStyle(GlassColors.secondary)
                                }
                                
                                Spacer()
                                
                                Text("🚀")
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                // Bridge Status Summary Card
                GlassCard(style: .floating) {
                    VStack(spacing: DesignTokens.mediumSpacing) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                                .font(.title)
                                .foregroundStyle(bridgeManager.isEngineConnected ? GlassColors.success : GlassColors.error)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Bridge Status")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(GlassColors.primary)
                                Text(bridgeManager.isEngineConnected ? "Connected" : "Disconnected")
                                    .glassCaption()
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: DesignTokens.smallSpacing) {
                            HStack {
                                Text("Engine")
                                    .font(.caption)
                                    .foregroundStyle(GlassColors.secondary)
                                Spacer()
                                Text(bridgeManager.isEngineConnected ? "✅ Active" : "❌ Inactive")
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(bridgeManager.isEngineConnected ? GlassColors.success : GlassColors.error)
                            }
                            
                            HStack {
                                Text("PCK Package")
                                    .font(.caption)
                                    .foregroundStyle(GlassColors.secondary)
                                Spacer()
                                Text(bridgeManager.isPCKLoaded ? "✅ Loaded" : "⏳ Ready")
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(bridgeManager.isPCKLoaded ? GlassColors.success : GlassColors.warning)
                            }
                            
                            HStack {
                                Text("Latency")
                                    .font(.caption)
                                    .foregroundStyle(GlassColors.secondary)
                                Spacer()
                                Text(String(format: "%.1f ms", bridgeManager.bridgeMetrics.bridgeLatency))
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(GlassColors.info)
                            }
                        }
                    }
                }
                
                ResponsiveGlassSpacer(baseHeight: 60, scaleFactor: 1.5)
            }
            .padding(.horizontal, DesignTokens.screenPadding)
        }
        .glassFadeTransition()
    }
    
    private func toggleSidebar() {
        withAnimation(DesignTokens.mediumSpring) {
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
