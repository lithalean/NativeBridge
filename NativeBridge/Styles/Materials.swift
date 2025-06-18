//
//  Materials.swift
//  NativeBridge
//
//  WWDC 25 Liquid Glass Material System - Modular Implementation
//  Note: Core materials already exist in LiquidGlassStyles.swift
//  This file provides EXTENSIONS and ADDITIONAL material features only
//

import SwiftUI

// MARK: - Advanced Glass Materials (Extensions to existing materials)

struct UltraGlassMaterial: ViewModifier {
    let cornerRadius: CGFloat
    let tintColor: Color
    
    init(cornerRadius: CGFloat = 16, tintColor: Color = .clear) {
        self.cornerRadius = cornerRadius
        self.tintColor = tintColor
    }
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .background(tintColor.opacity(0.1), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(GlassColors.glassBorder, lineWidth: 1)
            )
    }
}

struct GlassButtonMaterial: ViewModifier {
    let color: Color
    let isPressed: Bool
    let cornerRadius: CGFloat
    
    init(color: Color = Color.blue, isPressed: Bool = false, cornerRadius: CGFloat = 12) { // Use Color.blue instead of GlassColors.accent
        self.color = color
        self.isPressed = isPressed
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .background(color.opacity(0.1), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color.opacity(0.4), lineWidth: 1)
            )
            .overlay(
                // Shimmer effect when pressed
                Group {
                    if isPressed {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(color.opacity(0.2))
                    }
                }
            )
    }
}

struct GlassCardMaterial: ViewModifier {
    let style: CardStyle
    let tintColor: Color
    
    enum CardStyle {
        case floating
        case embedded
        case overlay
    }
    
    init(style: CardStyle = .floating, tintColor: Color = .clear) {
        self.style = style
        self.tintColor = tintColor
    }
    
    func body(content: Content) -> some View {
        switch style {
        case .floating:
            content
                .modifier(FloatingGlassCard()) // Use existing modifier directly
                .background(tintColor.opacity(0.05))
        case .embedded:
            content
                .modifier(LiquidGlassCard()) // Use existing modifier directly
                .background(tintColor.opacity(0.08))
        case .overlay:
            content
                .modifier(PureGlassOverlay()) // Use existing modifier directly
                .background(tintColor.opacity(0.1))
        }
    }
}

struct GlassBlurMaterial: ViewModifier {
    let intensity: BlurIntensity
    let cornerRadius: CGFloat
    
    enum BlurIntensity {
        case light, medium, heavy
        
        var material: Material {
            switch self {
            case .light: return .ultraThinMaterial
            case .medium: return .thinMaterial
            case .heavy: return .regularMaterial
            }
        }
    }
    
    init(intensity: BlurIntensity = .medium, cornerRadius: CGFloat = 16) {
        self.intensity = intensity
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(intensity.material, in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(GlassColors.glassBorder, lineWidth: 1)
            )
    }
}

struct GlassGradientMaterial: ViewModifier {
    let gradient: LinearGradient
    let cornerRadius: CGFloat
    
    init(gradient: LinearGradient, cornerRadius: CGFloat = 16) {
        self.gradient = gradient
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .background(gradient.opacity(0.3), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(GlassColors.glassBorder, lineWidth: 1)
            )
    }
}

// MARK: - Material Extensions (New ones that don't conflict)

extension View {
    // Advanced materials (new)
    func ultraGlassMaterial(cornerRadius: CGFloat = 16, tintColor: Color = .clear) -> some View {
        modifier(UltraGlassMaterial(cornerRadius: cornerRadius, tintColor: tintColor))
    }
    
    func glassButtonMaterial(color: Color = Color.blue, isPressed: Bool = false, cornerRadius: CGFloat = 12) -> some View {
        modifier(GlassButtonMaterial(color: color, isPressed: isPressed, cornerRadius: cornerRadius))
    }
    
    func glassCardMaterial(style: GlassCardMaterial.CardStyle = .floating, tintColor: Color = .clear) -> some View {
        modifier(GlassCardMaterial(style: style, tintColor: tintColor))
    }
    
    func glassBlurMaterial(intensity: GlassBlurMaterial.BlurIntensity = .medium, cornerRadius: CGFloat = 16) -> some View {
        modifier(GlassBlurMaterial(intensity: intensity, cornerRadius: cornerRadius))
    }
    
    func glassGradientMaterial(gradient: LinearGradient, cornerRadius: CGFloat = 16) -> some View {
        modifier(GlassGradientMaterial(gradient: gradient, cornerRadius: cornerRadius))
    }
}

// MARK: - Material Utilities

extension Material {
    static var liquidGlass: Material {
        .ultraThin
    }
    
    static var floatingGlass: Material {
        .thin
    }
    
    static var solidGlass: Material {
        .regular
    }
    
    static var heavyGlass: Material {
        .thick
    }
}

// MARK: - Preset Glass Materials

struct GlassMaterialPresets {
    // Success states
    static let successCard = GlassGradientMaterial(
        gradient: LinearGradient(
            colors: [Color.green.opacity(0.3), Color.green.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
    
    // Warning states
    static let warningCard = GlassGradientMaterial(
        gradient: LinearGradient(
            colors: [Color.orange.opacity(0.3), Color.orange.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
    
    // Error states
    static let errorCard = GlassGradientMaterial(
        gradient: LinearGradient(
            colors: [Color.red.opacity(0.3), Color.red.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
    
    // Info states
    static let infoCard = GlassGradientMaterial(
        gradient: LinearGradient(
            colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
}
