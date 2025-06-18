//
//  GlassCircularProgress.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassCircularProgress.swift
//  NativeBridge
//

import SwiftUI

/// Circular progress indicator with glass styling
struct GlassCircularProgress: View {
    let isComplete: Bool
    let size: CGFloat
    
    init(isComplete: Bool, size: CGFloat = 32) {
        self.isComplete = isComplete
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isComplete ? AnyShapeStyle(GlassColors.success.gradient) : AnyShapeStyle(.gray.opacity(0.2)))
                .frame(width: size, height: size)
            
            Image(systemName: isComplete ? "checkmark" : "circle")
                .font(.caption.weight(.medium))
                .foregroundStyle(isComplete ? GlassColors.primary : .secondary)
        }
    }
}

#Preview {
    HStack(spacing: 20) {
        GlassCircularProgress(isComplete: true)
        GlassCircularProgress(isComplete: false)
        GlassCircularProgress(isComplete: true, size: 48)
    }
    .padding()
}