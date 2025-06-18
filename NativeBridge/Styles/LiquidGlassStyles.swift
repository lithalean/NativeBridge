//
//  LiquidGlassStyles.swift
//  NativeBridge
//
//  WWDC 25 Liquid Glass Design System - Modular Components
//

import SwiftUI

// MARK: - Core Glass Materials and Effects

struct LiquidGlassCard: ViewModifier {
    let opacity: Double
    let cornerRadius: CGFloat
    
    init(opacity: Double = 0.8, cornerRadius: CGFloat = 20) {
        self.opacity = opacity
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial.opacity(opacity), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
    }
}

struct FloatingGlassCard: ViewModifier {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    init(cornerRadius: CGFloat = 16, shadowRadius: CGFloat = 8) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial.opacity(0.8), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: shadowRadius, x: 0, y: 4)
    }
}

struct PureGlassOverlay: ViewModifier {
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat = 20) {
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial.opacity(0.9), in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
    }
}

// MARK: - Glass Button Styles

struct GlassActionButton: ButtonStyle {
    let color: Color
    let isEnabled: Bool
    
    init(color: Color = .blue, isEnabled: Bool = true) {
        self.color = color
        self.isEnabled = isEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(isEnabled ? .white : .gray)
            .background(
                .ultraThinMaterial.opacity(isEnabled ? 0.8 : 0.4),
                in: RoundedRectangle(cornerRadius: 16)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white.opacity(isEnabled ? 0.1 : 0.05), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct GlassCircularButton: ButtonStyle {
    let size: CGFloat
    
    init(size: CGFloat = 50) {
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(.ultraThinMaterial, in: Circle())
            .overlay(
                Circle()
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

// MARK: - Glass Typography

struct GlassTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.white)
    }
}

struct GlassSubtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.white.opacity(0.8))
            .textCase(.uppercase)
            .tracking(1)
    }
}

struct GlassHeadline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold))
            .foregroundStyle(.white)
    }
}

struct GlassCaption: ViewModifier {
    let opacity: Double
    
    init(opacity: Double = 0.7) {
        self.opacity = opacity
    }
    
    func body(content: Content) -> some View {
        content
            .font(.caption.weight(.medium))
            .foregroundStyle(.white.opacity(opacity))
    }
}

// MARK: - Glass Status Indicators

struct GlassStatusBadge: ViewModifier {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(.caption.weight(.bold))
            .foregroundStyle(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(color.opacity(0.2), in: Capsule())
            .overlay(
                Capsule()
                    .stroke(color.opacity(0.5), lineWidth: 1)
            )
    }
}

struct GlassProgressBar: View {
    let progress: Double
    let color: Color
    
    init(progress: Double, color: Color = .blue) {
        self.progress = progress
        self.color = color
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 4)
                
                Capsule()
                    .fill(color.opacity(0.6))
                    .frame(width: geometry.size.width * progress, height: 4)
            }
        }
        .frame(height: 4)
    }
}

// MARK: - Glass Animations

struct GlassSpringAnimation: ViewModifier {
    let trigger: Bool
    
    func body(content: Content) -> some View {
        content
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: trigger)
    }
}

struct GlassFadeTransition: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
    }
}

// MARK: - Glass Layout Helpers

struct GlassGrid: View {
    let columns: Int
    let spacing: CGFloat
    let content: AnyView
    
    init<Content: View>(columns: Int = 2, spacing: CGFloat = 12, @ViewBuilder content: () -> Content) {
        self.columns = columns
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns), spacing: spacing) {
            content
        }
    }
}

struct GlassSpacer: View {
    let height: CGFloat
    
    init(height: CGFloat = 20) {
        self.height = height
    }
    
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

// MARK: - Convenient Extensions

extension View {
    // Glass Card Modifiers
    func liquidGlassCard(opacity: Double = 0.8, cornerRadius: CGFloat = 20) -> some View {
        modifier(LiquidGlassCard(opacity: opacity, cornerRadius: cornerRadius))
    }
    
    func floatingGlassCard(cornerRadius: CGFloat = 16, shadowRadius: CGFloat = 8) -> some View {
        modifier(FloatingGlassCard(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
    
    func pureGlassOverlay(cornerRadius: CGFloat = 20) -> some View {
        modifier(PureGlassOverlay(cornerRadius: cornerRadius))
    }
    
    // Typography Modifiers
    func glassTitle() -> some View {
        modifier(GlassTitle())
    }
    
    func glassSubtitle() -> some View {
        modifier(GlassSubtitle())
    }
    
    func glassHeadline() -> some View {
        modifier(GlassHeadline())
    }
    
    func glassCaption(opacity: Double = 0.7) -> some View {
        modifier(GlassCaption(opacity: opacity))
    }
    
    // Status Modifiers
    func glassStatusBadge(color: Color) -> some View {
        modifier(GlassStatusBadge(color: color))
    }
    
    // Animation Modifiers
    func glassSpringAnimation(trigger: Bool) -> some View {
        modifier(GlassSpringAnimation(trigger: trigger))
    }
    
    func glassFadeTransition() -> some View {
        modifier(GlassFadeTransition())
    }
}

// MARK: - Glass Color Palette

struct GlassColors {
    static let primary = Color.white
    static let secondary = Color.white.opacity(0.8)
    static let tertiary = Color.white.opacity(0.6)
    static let accent = Color.blue
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.cyan
    static let purple = Color.purple
    
    // Glass background gradients
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
}

// MARK: - Glass Constants

struct GlassConstants {
    // Corner Radius
    static let smallRadius: CGFloat = 12
    static let mediumRadius: CGFloat = 16
    static let largeRadius: CGFloat = 20
    static let xlRadius: CGFloat = 24
    
    // Spacing
    static let smallSpacing: CGFloat = 8
    static let mediumSpacing: CGFloat = 16
    static let largeSpacing: CGFloat = 24
    static let xlSpacing: CGFloat = 32
    
    // Padding
    static let cardPadding: CGFloat = 24
    static let itemPadding: CGFloat = 16
    static let compactPadding: CGFloat = 12
    
    // Animation
    static let springResponse: Double = 0.6
    static let springDamping: Double = 0.8
    static let fastAnimation: Double = 0.1
    static let mediumAnimation: Double = 0.3
}
