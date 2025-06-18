//
//  ModernFloatingSidebar.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  ModernFloatingSidebar.swift
//  NativeBridge
//

import SwiftUI

/// Complete floating sidebar page component
struct ModernFloatingSidebar: View {
    let features: [SidebarFeature]
    let currentPhase: String
    let progress: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.largeSpacing) {
                GlassSpacer(height: 40)
                
                DevelopmentControlPanel(
                    currentPhase: currentPhase,
                    progress: progress
                )
                
                FeaturesListContainer(features: features)
                
                GlassSpacer(height: 60)
            }
            .padding(.horizontal, GlassConstants.mediumSpacing)
        }
        .frame(maxHeight: .infinity)
        .glassFadeTransition()
    }
}

#Preview {
    ModernFloatingSidebar(
        features: [
            SidebarFeature(title: "User Authentication", isComplete: true),
            SidebarFeature(title: "Data Synchronization", isComplete: false),
            SidebarFeature(title: "Push Notifications", isComplete: false)
        ],
        currentPhase: "Phase 2",
        progress: "60%"
    )
}