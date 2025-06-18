//
//  DevelopmentControlPanel.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// Development control panel template
struct DevelopmentControlPanel: View {
    let currentPhase: String
    let progress: String
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            
            HStack {
                Spacer()
                
                GlassIcon("hammer.circle.fill", color: GlassColors.warning, size: .title)
                
                GlassContentSection(
                    title: "Development",
                    subtitle: "Phase Control",
                    alignment: .center
                )
                
                Spacer()
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(GlassColors.accent.gradient)
                    .frame(width: 4, height: 32)
                
                GlassContentSection(
                    title: currentPhase,
                    subtitle: "Active Phase"
                )
                
                Spacer()
                
                Label(progress, systemImage: "checkmark.seal.fill")
                    .font(.caption)
                    .labelStyle(.titleAndIcon)
                    .padding(.horizontal, GlassConstants.compactPadding)
                    .padding(.vertical, GlassConstants.compactPadding / 2)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: GlassConstants.mediumRadius))
            }
        }
        .padding(GlassConstants.largeSpacing)
        .pureGlassOverlay()
    }
}

#Preview {
    DevelopmentControlPanel(currentPhase: "Phase 2", progress: "60%")
        .padding()
        .background(GlassColors.backgroundGradient)
}

