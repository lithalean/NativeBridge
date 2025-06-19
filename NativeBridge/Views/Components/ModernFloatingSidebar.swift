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

struct ModernFloatingSidebar: View {
    let bridgeManager: BridgeManager
    
    // Now uses SidebarFeatureModel — correct model for FloatingSidebar
    let features: [SidebarFeatureModel] = SidebarFeatureModel.sampleFeatures
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(features) { feature in
                SidebarFeatureView(feature: feature)
            }
            
            Spacer()
        }
        .padding()
        .modifier(LiquidGlassMaterial(cornerRadius: GlassConstants.largeRadius))
    }
}
