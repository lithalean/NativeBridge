//
//  LiquidGlassMaterial.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


import SwiftUI

public struct LiquidGlassMaterial: ViewModifier {
    let opacity: Double
    let cornerRadius: CGFloat
    
    public init(opacity: Double = 0.8, cornerRadius: CGFloat = GlassConstants.largeRadius) {
        self.opacity = opacity
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .background(.regularMaterial.opacity(opacity), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
    }
}