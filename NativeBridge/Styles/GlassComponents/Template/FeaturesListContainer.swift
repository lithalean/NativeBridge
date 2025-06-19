//
//  FeaturesListContainer.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// Features list container template — WWDC25 style
struct FeaturesListContainer: View {
    let features: [SidebarFeatureModel]
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            GlassSectionHeader(
                title: "Features",
                icon: "list.bullet.circle",
                iconColor: GlassColors.accent
            )
            
            VStack(spacing: 8) {
                ForEach(features) { feature in
                    SidebarFeatureView(feature: feature)
                }
            }
        }
        .padding(GlassConstants.largeSpacing)
        .pureGlassOverlay()
    }
}

#Preview {
    FeaturesListContainer(features: SidebarFeatureModel.sampleFeatures)
        .padding()
}
