//
//  GlassButtons.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//


import SwiftUI

// MARK: - WWDC 25 Glass Button Styles
struct GlassButtons {
    
    // MARK: - Modern Glass Button Style
    struct ModernGlassButton: ButtonStyle {
        let color: Color
        let isEnabled: Bool
        
        init(color: Color = GlassColors.accent, isEnabled: Bool = true) {
            self.color = color
            self.isEnabled = isEnabled
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isEnabled ? GlassColors.primary : GlassColors.secondary)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background {
                    ZStack {
                        // Base glass background
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(color.opacity(0.1))
                            }
                        
                        // Shimmer overlay when pressed
                        if configuration.isPressed {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .clear,
                                            color.opacity(0.3),
                                            .clear
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: false), value: configuration.isPressed)
                        }
                        
                        // Border
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color.opacity(0.4), lineWidth: 1)
                    }
                }
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .opacity(isEnabled ? 1.0 : 0.6)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: configuration.isPressed)
                .disabled(!isEnabled)
        }
    }
    
    // MARK: - Circular Glass Button Style
    struct CircularGlassButton: ButtonStyle {
        let color: Color
        let size: CGFloat
        
        init(color: Color = GlassColors.accent, size: CGFloat = 44) {
            self.color = color
            self.size = size
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.title2.weight(.medium))
                .foregroundStyle(GlassColors.primary)
                .frame(width: size, height: size)
                .background {
                    ZStack {
                        // Base glass background
                        Circle()
                            .fill(.ultraThinMaterial)
                            .background {
                                Circle()
                                    .fill(color.opacity(0.15))
                            }
                        
                        // Shimmer effect when pressed
                        if configuration.isPressed {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            color.opacity(0.4),
                                            .clear
                                        ],
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: size/2
                                    )
                                )
                                .animation(.easeInOut(duration: 0.4), value: configuration.isPressed)
                        }
                        
                        // Border with glow
                        Circle()
                            .stroke(color.opacity(0.5), lineWidth: 1.5)
                            .shadow(color: color.opacity(0.3), radius: configuration.isPressed ? 8 : 4)
                    }
                }
                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
        }
    }
    
    // MARK: - Action Card Button Style
    struct ActionCardButton: ButtonStyle {
        let color: Color
        let isEnabled: Bool
        
        init(color: Color = GlassColors.accent, isEnabled: Bool = true) {
            self.color = color
            self.isEnabled = isEnabled
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background {
                    ZStack {
                        // Base background
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                        
                        // Color tint
                        RoundedRectangle(cornerRadius: 16)
                            .fill(color.opacity(0.08))
                        
                        // Shimmer wave when pressed
                        if configuration.isPressed {
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .clear,
                                                color.opacity(0.4),
                                                color.opacity(0.6),
                                                color.opacity(0.4),
                                                .clear
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .mask(
                                        Rectangle()
                                            .offset(x: configuration.isPressed ? geometry.size.width : -geometry.size.width)
                                            .animation(.easeInOut(duration: 0.8), value: configuration.isPressed)
                                    )
                            }
                        }
                        
                        // Border
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    }
                }
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                .opacity(isEnabled ? 1.0 : 0.5)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: configuration.isPressed)
                .disabled(!isEnabled)
        }
    }
    
    // MARK: - Floating Action Button Style
    struct FloatingActionButton: ButtonStyle {
        let color: Color
        
        init(color: Color = GlassColors.accent) {
            self.color = color
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background {
                    ZStack {
                        // Base gradient background
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [color, color.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        // Shimmer overlay
                        if configuration.isPressed {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .clear,
                                            .white.opacity(0.3),
                                            .clear
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .animation(.easeInOut(duration: 0.5), value: configuration.isPressed)
                        }
                        
                        // Glow effect
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                            .shadow(color: color.opacity(0.4), radius: configuration.isPressed ? 12 : 6)
                    }
                }
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
        }
    }
    
    // MARK: - Minimal Glass Button Style
    struct MinimalGlassButton: ButtonStyle {
        let color: Color
        
        init(color: Color = GlassColors.accent) {
            self.color = color
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.caption.weight(.medium))
                .foregroundStyle(color)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background {
                    ZStack {
                        Capsule()
                            .fill(color.opacity(0.1))
                        
                        if configuration.isPressed {
                            Capsule()
                                .fill(color.opacity(0.2))
                                .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
                        }
                        
                        Capsule()
                            .stroke(color.opacity(0.4), lineWidth: 1)
                    }
                }
                .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
        }
    }
}

// MARK: - View Extensions for Easy Usage
extension View {
    func modernGlassButton(color: Color = GlassColors.accent, isEnabled: Bool = true) -> some View {
        self.buttonStyle(GlassButtons.ModernGlassButton(color: color, isEnabled: isEnabled))
    }
    
    func circularGlassButton(color: Color = GlassColors.accent, size: CGFloat = 44) -> some View {
        self.buttonStyle(GlassButtons.CircularGlassButton(color: color, size: size))
    }
    
    func actionCardButton(color: Color = GlassColors.accent, isEnabled: Bool = true) -> some View {
        self.buttonStyle(GlassButtons.ActionCardButton(color: color, isEnabled: isEnabled))
    }
    
    func floatingActionButton(color: Color = GlassColors.accent) -> some View {
        self.buttonStyle(GlassButtons.FloatingActionButton(color: color))
    }
    
    func minimalGlassButton(color: Color = GlassColors.accent) -> some View {
        self.buttonStyle(GlassButtons.MinimalGlassButton(color: color))
    }
}