//
//  ModernSidebarPhaseRow.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  ModernSidebarPhaseRow.swift
//  NativeBridge
//

import SwiftUI

/// Sidebar phase row with completion indicator
struct ModernSidebarPhaseRow: View {
    let feature: SidebarFeature
    
    var body: some View {
        HStack(spacing: 16) {
            GlassCircularProgress(isComplete: feature.isComplete)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.subheadline.weight(feature.isComplete ? .semibold : .medium))
                    .foregroundStyle(feature.isComplete ? GlassColors.primary : GlassColors.secondary)
                
                if !feature.isComplete {
                    GlassProgressBar(progress: 0.3, color: GlassColors.accent)
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
    VStack {
        ModernSidebarPhaseRow(feature: SidebarFeature(title: "User Authentication", isComplete: true))
        ModernSidebarPhaseRow(feature: SidebarFeature(title: "Data Synchronization", isComplete: false))
    }
    .padding()
}