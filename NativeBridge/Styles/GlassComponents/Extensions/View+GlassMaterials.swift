//
//  View+GlassMaterials.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public extension View {
    func liquidGlassCard(opacity: Double = 0.8, cornerRadius: CGFloat = GlassConstants.largeRadius) -> some View {
        modifier(LiquidGlassMaterial(opacity: opacity, cornerRadius: cornerRadius))
    }
    
    func floatingGlassCard(cornerRadius: CGFloat = GlassConstants.mediumRadius, shadowRadius: CGFloat = 8) -> some View {
        modifier(FloatingGlassMaterial(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
    
    func pureGlassOverlay(cornerRadius: CGFloat = GlassConstants.largeRadius) -> some View {
        modifier(PureGlassMaterial(cornerRadius: cornerRadius))
    }
}
