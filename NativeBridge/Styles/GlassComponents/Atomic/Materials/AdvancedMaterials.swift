//
//  AdvancedMaterials.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

// All materials from Materials.swift that extend the core ones
import SwiftUI

// MARK: - UltraGlassMaterial

public struct UltraGlassMaterial: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .cornerRadius(GlassConstants.mediumRadius)
    }
}

// MARK: - GlassButtonMaterial

public struct GlassButtonMaterial: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(GlassConstants.toolbarGlassMaterial)
            .cornerRadius(GlassConstants.mediumRadius)
            .overlay(
                RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                    .strokeBorder(.thinMaterial, lineWidth: 1)
            )
    }
}

// MARK: - GlassCardMaterial

public struct GlassCardMaterial: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(GlassConstants.cardGlassMaterial)
            .cornerRadius(GlassConstants.largeRadius)
            .shadow(radius: 10)
    }
}

// MARK: - GlassBlurMaterial

public struct GlassBlurMaterial: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(.thinMaterial)
            .cornerRadius(GlassConstants.mediumRadius)
            .blur(radius: 8)
    }
}

// MARK: - GlassGradientMaterial

public struct GlassGradientMaterial: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.25),
                        Color.white.opacity(0.05)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .background(.ultraThinMaterial)
            .cornerRadius(GlassConstants.mediumRadius)
    }
}
