//
//  Colors.swift
//  NativeBridge
//
//  WWDC 25 Glass Color System - Modular Implementation
//

import SwiftUI

// MARK: - Extended Glass Color System (Additional colors not in LiquidGlassStyles)

extension GlassColors {
    // MARK: - Extended Semantic Colors
    static let highlight = Color.yellow
    static let destructive = Color.red.opacity(0.8)
    static let constructive = Color.green.opacity(0.8)
    static let neutral = Color.gray
    
    // MARK: - Glass Material Tints (New)
    static let glassTint = Color.white.opacity(0.1)
    static let glassBorder = Color.white.opacity(0.1)
    static let glassOverlay = Color.white.opacity(0.05)
    
    // MARK: - Status Color Variants (New)
    static let successTint = success.opacity(0.2)
    static let warningTint = warning.opacity(0.2)
    static let errorTint = error.opacity(0.2)
    static let infoTint = info.opacity(0.2)
    static let purpleTint = purple.opacity(0.2)
    
    // MARK: - Interactive States (New)
    static let pressedOverlay = Color.white.opacity(0.2)
    static let hoverOverlay = Color.white.opacity(0.1)
    static let disabledOverlay = Color.gray.opacity(0.3)
    
    // MARK: - Gradient Variants (New)
    static let accentGradient = LinearGradient(
        colors: [accent, accent.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let successGradient = LinearGradient(
        colors: [success, success.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let warningGradient = LinearGradient(
        colors: [warning, warning.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Color Extensions for Glass Effects

extension Color {
    // Glass-specific color modifiers
    func glassified(opacity: Double = 0.1) -> Color {
        self.opacity(opacity)
    }
    
    func glassTinted() -> Color {
        self.opacity(0.2)
    }
    
    func glassBordered() -> Color {
        self.opacity(0.4)
    }
    
    func glassPressed() -> Color {
        self.opacity(0.6)
    }
}

// MARK: - Semantic Color Helpers

struct SemanticColors {
    // Success states
    static let successLight = GlassColors.success.opacity(0.3)
    static let successMedium = GlassColors.success.opacity(0.6)
    static let successDark = GlassColors.success.opacity(0.9)
    
    // Warning states
    static let warningLight = GlassColors.warning.opacity(0.3)
    static let warningMedium = GlassColors.warning.opacity(0.6)
    static let warningDark = GlassColors.warning.opacity(0.9)
    
    // Error states
    static let errorLight = GlassColors.error.opacity(0.3)
    static let errorMedium = GlassColors.error.opacity(0.6)
    static let errorDark = GlassColors.error.opacity(0.9)
    
    // Info states
    static let infoLight = GlassColors.info.opacity(0.3)
    static let infoMedium = GlassColors.info.opacity(0.6)
    static let infoDark = GlassColors.info.opacity(0.9)
}
