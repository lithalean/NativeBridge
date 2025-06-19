//
//  TabBar.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    let bridgeManager: BridgeManager
    let onToggleDrawer: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                bridgeManager.connectGameEngine()
            }) {
                Label("Start Engine", systemImage: "play.fill")
                    .labelStyle(.iconOnly)
            }
            
            Button(action: {
                bridgeManager.connectGameEngine()
            }) {
                Label("Establish Bridge", systemImage: "link")
                    .labelStyle(.iconOnly)
            }
            
            Button(action: {
                Task {
                    await bridgeManager.loadPCKBundle()
                }
            }) {
                Label("Load PCK", systemImage: "square.and.arrow.down")
                    .labelStyle(.iconOnly)
            }
            
            Divider().frame(height: 24).background(.white.opacity(0.1))
            
            ForEach(SidebarFeature.groups.indices, id: \.self) { groupIndex in
                let group = SidebarFeature.groups[groupIndex]
                
                HStack(spacing: 12) {
                    ForEach(group) { feature in
                        if feature == .debug || feature == .systemMonitor {
                            ModernSidebarPhaseRow(phase: feature)
                        } else {
                            SidebarFeatureTabView(feature: feature)
                        }
                    }
                }
                
                if groupIndex < SidebarFeature.groups.count - 1 {
                    Divider().frame(height: 24).background(.white.opacity(0.1))
                }
            }
            
            Divider().frame(height: 24).background(.white.opacity(0.1))
            
            Button(action: {
                onToggleDrawer()
            }) {
                Label("Toggle Debugger", systemImage: "chevron.up")
                    .labelStyle(.iconOnly)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .modifier(LiquidGlassMaterial(cornerRadius: GlassConstants.largeRadius))
        .clipShape(Capsule())
        .frame(maxWidth: .infinity)
        .padding(.top, 24)
    }
}
