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
                // Use Foundation layer
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
                        // Use Pages layer component
                        ModernFloatingSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleSidebar() }
                        )
                        .frame(width: 320)
                        .padding(.leading, GlassConstants.mediumSpacing)
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: { toggleSidebar() }) {
                            GlassIcon(
                                systemName: showingSidebar ? "xmark.circle.fill" : "sidebar.left",
                                size: .large
                            )
                        }
                        .buttonStyle(GlassCircularButton(size: 50))
                        .padding(.leading, GlassConstants.screenPadding)
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
            LazyVStack(spacing: GlassConstants.mediumSpacing) {
                GlassSpacer(height: 80)
                
                titleSection
                bridgeStatusSection
                pckManagementSection
                developmentToolsSection
                performanceSection
                
                // Use Pages layer component
                GlassDebugConsole(
                    messages: bridgeManager.debugMessages,
                    onClear: { bridgeManager.clearDebugMessages() }
                )
                .padding(.horizontal, GlassConstants.screenPadding)
                
                GlassSpacer(height: GlassConstants.xlSpacing)
            }
            .padding(.horizontal, GlassConstants.screenPadding)
        }
    }
    
    private var titleSection: some View {
        // Use Organism layer component
        PhaseProgressCard(
            title: "NativeBridge",
            subtitle: "Darwin ARM64 Bridge Technology",
            phase: "Phase 1 Complete",
            progress: 1.0,
            status: .complete
        )
    }
    
    private var bridgeStatusSection: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            // Use Template layer component
            GlassSectionHeader(
                title: "Bridge Components",
                icon: "link",
                iconColor: GlassColors.success
            )
            
            GlassGrid(columns: 2, spacing: GlassConstants.gridSpacing) {
                // Use Organism layer components
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
        .liquidGlassCard()
        .padding(GlassConstants.cardPadding)
    }
    
    private var pckManagementSection: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            // Use Template layer component
            GlassSectionHeader(
                title: "Package Management",
                icon: "cube.box",
                iconColor: GlassColors.warning
            )
            
            VStack(spacing: GlassConstants.mediumSpacing) {
                // Main PCK loading action
                ModernActionCard(
                    title: "Load PCK Bundle",
                    description: "Find game.pck in app bundle",
                    icon: "tray.and.arrow.down",
                    color: GlassColors.warning,
                    isEnabled: bridgeManager.isEngineConnected,
                    action: {
                        Task {
                            await bridgeManager.loadPCKBundle()
                        }
                    }
                )
                
                HStack(spacing: GlassConstants.mediumSpacing) {
                    // Secondary actions
                    ModernActionCard(
                        title: "Bundle Debug",
                        description: "Inspect contents",
                        icon: "folder.badge.questionmark",
                        color: GlassColors.purple,
                        isCompact: true,
                        action: {
                            pckManager.debugBundleContents()
                        }
                    )
                    
                    ModernActionCard(
                        title: "Project Structure",
                        description: "View loaded details",
                        icon: "list.bullet.rectangle",
                        color: GlassColors.accent,
                        isCompact: true,
                        isEnabled: bridgeManager.isPCKLoaded,
                        action: {
                            Task {
                                await bridgeManager.inspectProjectStructure()
                            }
                        }
                    )
                }
            }
        }
        .liquidGlassCard()
        .padding(GlassConstants.cardPadding)
    }
    
    private var developmentToolsSection: some View {
        // Use Template layer component
        DevelopmentControlPanel(
            isEngineConnected: bridgeManager.isEngineConnected,
            onConnectEngine: { bridgeManager.connectGameEngine() },
            onTestBridge: { bridgeManager.sendTestMessage() },
            onPerformance: { bridgeManager.startPerformanceMonitoring() },
            onDebugBridge: { bridgeManager.testProjectAccess() }
        )
    }
    
    private var performanceSection: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            // Use Template layer component
            GlassSectionHeader(
                title: "Performance Metrics",
                icon: "speedometer",
                iconColor: GlassColors.info
            )
            
            GlassGrid(columns: 2, spacing: GlassConstants.gridSpacing) {
                // Use Organism layer components
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
        .liquidGlassCard()
        .padding(GlassConstants.cardPadding)
    }
    
    private func toggleSidebar() {
        withAnimation(GlassAnimations.sidebarSlide) {
            showingSidebar.toggle()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
