//
//  ModernSidebarPhaseRow.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// Sidebar phase row with completion indicator
struct ModernSidebarPhaseRow: View {
    let feature: SidebarFeature
    
    var body: some View {
        HStack(spacing: GlassConstants.mediumSpacing) {
            
            GlassCircularProgress(isComplete: feature.isComplete)
            
            VStack(alignment: .leading, spacing: GlassConstants.smallSpacing) {
                Text(feature.title)
                    .font(.subheadline.weight(feature.isComplete ? .semibold : .medium))
                    .foregroundStyle(feature.isComplete ? GlassColors.primary : GlassColors.secondary)
                
                if !feature.isComplete {
                    ProgressView(value: 0.3)
                        .progressViewStyle(.linear)
                        .frame(height: 4)
                        .animation(.easeInOut(duration: GlassConstants.fastAnimation), value: 0.3)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, GlassConstants.itemPadding)
        .padding(.vertical, GlassConstants.compactPadding)
        .background(
            RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                .fill(feature.isComplete ? GlassColors.success.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                .stroke(feature.isComplete ? GlassColors.success.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: GlassConstants.mediumSpacing) {
        ModernSidebarPhaseRow(feature: SidebarFeature(title: "User Authentication", isComplete: true))
        ModernSidebarPhaseRow(feature: SidebarFeature(title: "Data Synchronization", isComplete: false))
    }
    .padding()
    .background(GlassColors.backgroundGradient)
}

