//
//  FeaturesListContainer.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  FeaturesListContainer.swift
//  NativeBridge
//

import SwiftUI

/// Features list container template
struct FeaturesListContainer: View {
    let features: [SidebarFeature]
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            GlassSectionHeader(
                title: "Features",
                icon: "list.bullet.circle",
                iconColor: GlassColors.accent
            )
            
            VStack(spacing: 8) {
                ForEach(features, id: \.title) { feature in
                    ModernSidebarPhaseRow(feature: feature)
                }
            }
        }
        .padding(GlassConstants.largeSpacing)
        .pureGlassOverlay()
    }
}

#Preview {
    FeaturesListContainer(features: [
        SidebarFeature(title: "User Authentication", isComplete: true),
        SidebarFeature(title: "Data Sync", isComplete: false),
        SidebarFeature(title: "Push Notifications", isComplete: false)
    ])
    .padding()
}