//
//  FloatingGlassMaterial.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


import SwiftUI

public struct FloatingGlassMaterial: ViewModifier {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    public init(cornerRadius: CGFloat = GlassConstants.mediumRadius, shadowRadius: CGFloat = 8) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: shadowRadius, x: 0, y: 4)
    }
}