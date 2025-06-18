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
                        .circularGlassButton(color: GlassColors.accent, size: 50)
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
                
                // Simple title section (progress moved to sidebar)
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
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "link.circle.fill")
                    .font(.title.weight(.bold))
                    .foregroundStyle(GlassColors.accent.gradient)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("NativeBridge")
                        .font(.title.weight(.bold))
                        .foregroundStyle(GlassColors.primary)
                    
                    Text("Darwin ARM64 Bridge Technology")
                        .glassSubtitle()
                }
                
                Spacer()
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(GlassColors.success.gradient)
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
        .padding(24)
        .liquidGlassCard()
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
                
                // Fixed PCK Package status - should be green when loaded
                ModernStatusCard(
                    title: "PCK Package",
                    status: ComponentStatus(
                        isConnected: bridgeManager.isPCKLoaded, // This should update when PCK is loaded
                        displayName: bridgeManager.isPCKLoaded ? "Loaded" : "Ready"
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
                    .padding(16)
                    .frame(maxWidth: .infinity)
                }
                .actionCardButton(color: GlassColors.warning, isEnabled: bridgeManager.isEngineConnected)
                
                HStack(spacing: 12) {
                    Button(action: {
                        pckManager.debugBundleContents()
                    }) {
                        VStack(spacing: 8) {
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
                        .padding(12)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.purple, isEnabled: true)
                    
                    Button(action: {
                        Task {
                            await bridgeManager.inspectProjectStructure()
                        }
                    }) {
                        VStack(spacing: 8) {
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
                        .padding(12)
                        .frame(maxWidth: .infinity)
                    }
                    .actionCardButton(color: GlassColors.accent, isEnabled: true)
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
                Button(action: {
                    bridgeManager.connectGameEngine()
                }) {
                    VStack(spacing: 8) {
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
                    .padding(12)
                    .frame(maxWidth: .infinity)
                }
                .actionCardButton(color: GlassColors.success, isEnabled: !bridgeManager.isEngineConnected)
                
                Button(action: {
                    bridgeManager.sendTestMessage()
                }) {
                    VStack(spacing: 8) {
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
                    .padding(12)
                    .frame(maxWidth: .infinity)
                }
                .actionCardButton(color: GlassColors.accent, isEnabled: bridgeManager.isEngineConnected)
                
                Button(action: {
                    bridgeManager.startPerformanceMonitoring()
                }) {
                    VStack(spacing: 8) {
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
                    .padding(12)
                    .frame(maxWidth: .infinity)
                }
                .actionCardButton(color: GlassColors.purple, isEnabled: true)
                
                Button(action: {
                    bridgeManager.testProjectAccess()
                }) {
                    VStack(spacing: 8) {
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
                    .padding(12)
                    .frame(maxWidth: .infinity)
                }
                .actionCardButton(color: GlassColors.warning, isEnabled: bridgeManager.isEngineConnected)
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
                .minimalGlassButton(color: GlassColors.accent)
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
                
                // Development Phase Control Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "hammer.circle.fill")
                            .font(.title)
                            .foregroundStyle(GlassColors.warning.gradient)
                        
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
                        
                        Text("100%")
                            .glassStatusBadge(color: GlassColors.success)
                    }
                }
                .padding(20)
                .pureGlassOverlay()
                
                // Development Progress Card (moved from main content)
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                            .font(.title)
                            .foregroundStyle(GlassColors.accent.gradient)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Progress")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(GlassColors.primary)
                            Text("Development Phases")
                                .glassCaption()
                        }
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 12) {
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
                .padding(20)
                .pureGlassOverlay()
                
                // Bridge Status Summary Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "link.circle.fill")
                            .font(.title)
                            .foregroundStyle(bridgeManager.isEngineConnected ? GlassColors.success.gradient : GlassColors.error.gradient)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Bridge Status")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(GlassColors.primary)
                            Text(bridgeManager.isEngineConnected ? "Connected" : "Disconnected")
                                .glassCaption()
                        }
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 8) {
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
