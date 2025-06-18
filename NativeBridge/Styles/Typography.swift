//
//  Typography.swift
//  NativeBridge
//
//  WWDC 25 Glass Typography System - Modular Implementation
//  Note: Core typography modifiers already exist in LiquidGlassStyles.swift
//  This file provides EXTENSIONS and ADDITIONAL typography features only
//

import SwiftUI

// MARK: - Extended Glass Typography (Additional styles not in LiquidGlassStyles)

struct GlassLargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold, design: .rounded))
            .foregroundStyle(GlassColors.primary)
    }
}

struct GlassFootnote: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.medium))
            .foregroundStyle(GlassColors.primary.opacity(0.6))
    }
}

struct GlassMonospace: ViewModifier {
    let size: Font.TextStyle
    
    init(size: Font.TextStyle = .caption) {
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size, design: .monospaced))
            .foregroundStyle(GlassColors.secondary)
    }
}

struct GlassCode: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.caption, design: .monospaced))
            .foregroundStyle(GlassColors.info)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(GlassColors.glassTint, in: RoundedRectangle(cornerRadius: 6))
    }
}

struct GlassBadgeText: ViewModifier {
    let color: Color
    
    init(color: Color = GlassColors.accent) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(.caption2.weight(.bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(color, in: Capsule())
    }
}

// MARK: - Typography Extensions (New ones that don't conflict)

extension View {
    // Extended typography (new)
    func glassLargeTitle() -> some View {
        modifier(GlassLargeTitle())
    }
    
    func glassFootnote() -> some View {
        modifier(GlassFootnote())
    }
    
    func glassMonospace(size: Font.TextStyle = .caption) -> some View {
        modifier(GlassMonospace(size: size))
    }
    
    func glassCode() -> some View {
        modifier(GlassCode())
    }
    
    func glassBadgeText(color: Color = GlassColors.accent) -> some View {
        modifier(GlassBadgeText(color: color))
    }
}

// MARK: - Enhanced Font System

extension Font {
    // Extended glass-specific fonts (additional to existing system)
    static let glassDisplay = Font.system(size: 48, weight: .black, design: .rounded)
    static let glassLargeTitleCustom = Font.system(size: 34, weight: .bold, design: .rounded)
    static let glassCodeFont = Font.system(size: 12, weight: .medium, design: .monospaced)
    static let glassBadgeFont = Font.system(size: 10, weight: .bold, design: .rounded)
}

// MARK: - Typography Utilities

struct TypographyUtils {
    static func dynamicSize(base: CGFloat, for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        switch sizeClass {
        case .compact:
            return base * 0.9
        case .regular, .none:
            return base
        @unknown default:
            return base
        }
    }
    
    static func lineSpacing(for font: Font) -> CGFloat {
        // Default line spacing recommendations for glass typography
        4.0
    }
    
    static func letterSpacing(for style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle, .title, .title2:
            return -0.5
        case .headline:
            return -0.3
        default:
            return 0
        }
    }
}
