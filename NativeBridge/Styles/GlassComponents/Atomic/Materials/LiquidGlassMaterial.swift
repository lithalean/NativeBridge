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
            .background(.ultraThinMaterial.opacity(opacity), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.12), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 8)
    }
}
