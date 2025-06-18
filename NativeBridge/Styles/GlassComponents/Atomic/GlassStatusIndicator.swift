//
//  GlassStatusIndicator.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassStatusIndicator.swift
//  NativeBridge
//

import SwiftUI

/// Basic status indicator with glass styling
struct GlassStatusIndicator: View {
    let isActive: Bool
    let color: Color
    
    var body: some View {
        Circle()
            .fill(isActive ? color : GlassColors.error)
            .frame(width: 8, height: 8)
    }
}

#Preview {
    HStack(spacing: 20) {
        GlassStatusIndicator(isActive: true, color: .green)
        GlassStatusIndicator(isActive: false, color: .blue)
    }
    .padding()
}