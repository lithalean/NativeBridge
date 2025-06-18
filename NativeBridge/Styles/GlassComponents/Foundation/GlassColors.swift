//
//  GlassColors.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


// Combines colors from LiquidGlassStyles.swift + Colors.swift
import SwiftUI

public struct GlassColors {
    // From LiquidGlassStyles
    static let primary = Color.white
    static let secondary = Color.white.opacity(0.8)
    static let tertiary = Color.white.opacity(0.6)
    static let accent = Color.blue
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.cyan
    static let purple = Color.purple
    
    // From Colors.swift (Extended)
    static let highlight = Color.yellow
    static let destructive = Color.red.opacity(0.8)
    static let constructive = Color.green.opacity(0.8)
    static let neutral = Color.gray
    
    // Glass Material Tints
    static let glassTint = Color.white.opacity(0.1)
    static let glassBorder = Color.white.opacity(0.1)
    static let glassOverlay = Color.white.opacity(0.05)
    
    // Status Color Variants
    static let successTint = success.opacity(0.2)
    static let warningTint = warning.opacity(0.2)
    static let errorTint = error.opacity(0.2)
    static let infoTint = info.opacity(0.2)
    static let purpleTint = purple.opacity(0.2)
    
    // Gradients
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.black,
            Color.blue.opacity(0.2),
            Color.purple.opacity(0.1),
            Color.black
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Additional gradients from Colors.swift
    static let accentGradient = LinearGradient(
        colors: [accent, accent.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    // ... etc
}