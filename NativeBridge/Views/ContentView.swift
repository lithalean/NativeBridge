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
                        .buttonStyle(GlassButtons.CircularGlassButton())
                        .padding(.leading, GlassConstants.screenPadding)
                        .padding(.top, 60)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(1000)
            }
        }
        .glassSpring(trigger: showingSidebar)
    }
    
    private var mainContent: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.mediumSpacing) {
                GlassSpacer(.vertical, size: 80)
                
                titleSection
                // other sections can follow here...
                
                GlassSpacer(.vertical, size: GlassConstants.xlSpacing)
            }
            .padding(.horizontal, GlassConstants.screenPadding)
        }
    }
    
    private var titleSection: some View {
        PhaseProgressCard(
            title: "NativeBridge",
            subtitle: "Darwin ARM64 Bridge Technology",
            features: [
                "Darwin ARM64",
                "Liquid Glass",
                "Godot Bridge"
            ],
            progress: 1.0,
            currentPhase: "Phase 1 Complete"
        )
    }
    
    private func toggleSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingSidebar.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
