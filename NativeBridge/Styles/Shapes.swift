//
//  Shapes.swift
//  NativeBridge
//
//  WWDC 25 Glass Shape System - Modular Implementation
//

import SwiftUI

// MARK: - Glass Shape System

struct FixedGlassShape: Shape {
    let radius: CGFloat
    
    init(radius: CGFloat = DesignTokens.cornerRadius) {
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: radius).path(in: rect)
    }
}

struct CapsuleGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        Capsule().path(in: rect)
    }
}

struct ConcentricGlassShape: Shape {
    let padding: CGFloat
    
    init(padding: CGFloat = 4) {
        self.padding = padding
    }
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2 - padding
        return RoundedRectangle(cornerRadius: radius).path(in: rect)
    }
}

struct CircularGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        Circle().path(in: rect)
    }
}

// MARK: - Glass Card Shapes

struct GlassCardShape: Shape {
    let cornerRadius: CGFloat
    let corners: UIRectCorner
    
    init(cornerRadius: CGFloat = DesignTokens.cornerRadius, corners: UIRectCorner = .allCorners) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Adaptive Shapes

struct AdaptiveGlassShape: Shape {
    let style: ShapeStyle
    
    enum ShapeStyle {
        case fixed(CGFloat)
        case capsule
        case concentric(CGFloat)
        case circle
    }
    
    func path(in rect: CGRect) -> Path {
        switch style {
        case .fixed(let radius):
            return FixedGlassShape(radius: radius).path(in: rect)
        case .capsule:
            return CapsuleGlassShape().path(in: rect)
        case .concentric(let padding):
            return ConcentricGlassShape(padding: padding).path(in: rect)
        case .circle:
            return CircularGlassShape().path(in: rect)
        }
    }
}

// MARK: - Shape Extensions

extension View {
    // Glass shape clipping
    func glassShape(_ shape: some Shape) -> some View {
        self.clipShape(shape)
    }
    
    func glassCardShape(
        cornerRadius: CGFloat = DesignTokens.cornerRadius,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        self.clipShape(GlassCardShape(cornerRadius: cornerRadius, corners: corners))
    }
    
    func glassCircle() -> some View {
        self.clipShape(Circle())
    }
    
    func glassCapsule() -> some View {
        self.clipShape(Capsule())
    }
    
    func glassRoundedRect(radius: CGFloat = DesignTokens.cornerRadius) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

// MARK: - Shape Stroke Modifiers

extension Shape {
    func glassStroke(
        color: Color = GlassColors.glassBorder,
        lineWidth: CGFloat = 1
    ) -> some View {
        self.stroke(color, lineWidth: lineWidth)
    }
    
    func glassFill(color: Color = GlassColors.glassTint) -> some View {
        self.fill(color)
    }
    
    func glassOverlay(
        color: Color = GlassColors.glassOverlay,
        stroke: Color = GlassColors.glassBorder,
        lineWidth: CGFloat = 1
    ) -> some View {
        self.fill(color)
            .overlay(self.stroke(stroke, lineWidth: lineWidth))
    }
}
