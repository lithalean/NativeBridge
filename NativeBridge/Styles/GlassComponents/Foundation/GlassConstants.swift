//
//  GlassConstants.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


// Combines constants from LiquidGlassStyles.swift + DesignTokens.swift
import SwiftUI

public struct GlassConstants {
    // From LiquidGlassStyles
    static let smallRadius: CGFloat = 12
    static let mediumRadius: CGFloat = 16
    static let largeRadius: CGFloat = 20
    static let xlRadius: CGFloat = 24
    
    // From DesignTokens (Extended)
    static let tightRadius: CGFloat = 8
    static let xxlRadius: CGFloat = 32
    
    // Spacing (merged)
    static let tightSpacing: CGFloat = 4
    static let smallSpacing: CGFloat = 8
    static let mediumSpacing: CGFloat = 16
    static let largeSpacing: CGFloat = 24
    static let xlSpacing: CGFloat = 32
    static let xxlSpacing: CGFloat = 48
    
    // ... rest of merged constants
}