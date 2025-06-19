//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//
//  SLIM VERSION - All components modularized with proper Apple naming

import SwiftUI

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var pckManager = PCKManager()
    @State private var showingControlSidebar = false
    @State private var showingDebugConsole = false
    
    // Controller Navigation Manager
    @StateObject private var navigationManager: ControllerNavigationManager
    
    init() {
        let bridgeManager = BridgeManager()
        _bridgeManager = StateObject(wrappedValue: bridgeManager)
        _pckManager = StateObject(wrappedValue: PCKManager())
        _navigationManager = StateObject(wrappedValue: ControllerNavigationManager(bridgeManager: bridgeManager))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Dashboard Background
                DashboardBackground()
                
                // Main System Dashboard
                SystemDashboard(bridgeManager: bridgeManager)
                    .padding(.horizontal, GlassConstants.screenPadding)
                
                // Floating Control Sidebar (Left)
                if showingControlSidebar {
                    HStack {
                        ControlSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleControlSidebar() }
                        )
                        .frame(width: 80)
                        .padding(.leading, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 0)
                        Spacer()
                    }
                    .zIndex(100)
                }
                
                // Floating Debug Console (Right)
                if showingDebugConsole {
                    HStack {
                        Spacer()
                        DebugConsole(
                            bridgeManager: bridgeManager,
                            onClose: { toggleDebugConsole() }
                        )
                        .frame(width: showingControlSidebar ?
                               geometry.size.width - 120 :
                               geometry.size.width * 0.45)
                        .padding(.trailing, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: -5, y: 0)
                    }
                    .zIndex(100)
                }
                
                // Floating Sidebar Controls
                floatingSidebarControls
            }
        }
        .glassSpring(trigger: showingControlSidebar || showingDebugConsole)
        .environmentObject(navigationManager)
        .onAppear {
            navigationManager.setupControllerNavigation()
        }
    }
    
    // MARK: - Floating Controls
    private var floatingSidebarControls: some View {
        VStack {
            HStack {
                // Control Sidebar Toggle
                if !showingControlSidebar {
                    Button(action: { toggleControlSidebar() }) {
                        GlassIcon("sidebar.left", size: .title2)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                    .padding(.leading, GlassConstants.screenPadding)
                    .padding(.top, 60)
                }
                
                Spacer()
                
                // Debug Console Toggle
                if !showingDebugConsole {
                    Button(action: { toggleDebugConsole() }) {
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
    
    // MARK: - Actions
    private func toggleControlSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingControlSidebar.toggle()
        }
    }
    
    private func toggleDebugConsole() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingDebugConsole.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
