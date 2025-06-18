//
//  Animations.swift
//  NativeBridge
//
//  WWDC 25 Glass Animation System - Modular Implementation
//

import SwiftUI

// MARK: - Advanced Glass Animation Modifiers (New ones not in LiquidGlassStyles)

struct GlassScaleAnimation: ViewModifier {
    let isPressed: Bool
    let scale: CGFloat
    let duration: Double
    
    init(isPressed: Bool, scale: CGFloat = 0.95, duration: Double = 0.1) {
        self.isPressed = isPressed
        self.scale = scale
        self.duration = duration
    }
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(.easeInOut(duration: duration), value: isPressed)
    }
}

struct GlassSlideAnimation: ViewModifier {
    let isVisible: Bool
    let edge: Edge
    let distance: CGFloat
    
    init(isVisible: Bool, edge: Edge = .leading, distance: CGFloat = 300) {
        self.isVisible = isVisible
        self.edge = edge
        self.distance = distance
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: offsetForEdge())
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isVisible)
    }
    
    private func offsetForEdge() -> CGFloat {
        guard !isVisible else { return 0 }
        
        switch edge {
        case .leading:
            return -distance
        case .trailing:
            return distance
        case .top:
            return -distance
        case .bottom:
            return distance
        }
    }
}

struct GlassShimmerAnimation: ViewModifier {
    let isActive: Bool
    let duration: Double
    let color: Color
    
    @State private var shimmerOffset: CGFloat = -1
    
    init(isActive: Bool, duration: Double = 1.0, color: Color = .white) {
        self.isActive = isActive
        self.duration = duration
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    if isActive {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        color.opacity(0.3),
                                        color.opacity(0.6),
                                        color.opacity(0.3),
                                        .clear
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * 0.3)
                            .offset(x: shimmerOffset * (geometry.size.width + geometry.size.width * 0.3))
                            .onAppear {
                                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                                    shimmerOffset = 1
                                }
                            }
                    }
                }
                .mask(content)
            )
    }
}

struct GlassPulseAnimation: ViewModifier {
    let isActive: Bool
    let scale: CGFloat
    let opacity: Double
    let duration: Double
    
    @State private var isPulsing = false
    
    init(isActive: Bool, scale: CGFloat = 1.05, opacity: Double = 0.7, duration: Double = 1.0) {
        self.isActive = isActive
        self.scale = scale
        self.opacity = opacity
        self.duration = duration
    }
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive && isPulsing ? scale : 1.0)
            .opacity(isActive && isPulsing ? opacity : 1.0)
            .onAppear {
                if isActive {
                    withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
                        isPulsing = true
                    }
                }
            }
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
                        isPulsing = true
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPulsing = false
                    }
                }
            }
    }
}

struct GlassRotationAnimation: ViewModifier {
    let isActive: Bool
    let duration: Double
    
    @State private var rotation: Double = 0
    
    init(isActive: Bool, duration: Double = 2.0) {
        self.isActive = isActive
        self.duration = duration
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .onAppear {
                if isActive {
                    withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            }
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.5)) {
                        rotation = 0
                    }
                }
            }
    }
}

// MARK: - Complex Glass Animations

struct GlassLoadingAnimation: ViewModifier {
    let isLoading: Bool
    
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isLoading {
                        ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                            
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .clear,
                                            Color.blue.opacity(0.3), // Use Color.blue instead of GlassColors.accent
                                            .clear
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .offset(x: phase)
                                .onAppear {
                                    withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                        phase = 300
                                    }
                                }
                        }
                        .transition(.opacity)
                    }
                }
            )
    }
}

struct GlassSuccessAnimation: ViewModifier {
    let showSuccess: Bool
    
    @State private var scale: CGFloat = 0
    @State private var checkmarkScale: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if showSuccess {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.2)) // Use Color.green instead of GlassColors.success
                                .scaleEffect(scale)
                            
                            Image(systemName: "checkmark")
                                .font(.title.weight(.bold))
                                .foregroundStyle(Color.green) // Use Color.green instead of GlassColors.success
                                .scaleEffect(checkmarkScale)
                        }
                        .onAppear {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                scale = 1.0
                            }
                            
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.2)) {
                                checkmarkScale = 1.0
                            }
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
            )
    }
}

// MARK: - Animation Extensions (New ones that don't conflict)

extension View {
    // Advanced glass animations (new)
    func glassScaleAnimation(isPressed: Bool, scale: CGFloat = 0.95, duration: Double = 0.1) -> some View {
        modifier(GlassScaleAnimation(isPressed: isPressed, scale: scale, duration: duration))
    }
    
    func glassSlideAnimation(isVisible: Bool, edge: Edge = .leading, distance: CGFloat = 300) -> some View {
        modifier(GlassSlideAnimation(isVisible: isVisible, edge: edge, distance: distance))
    }
    
    // Effect animations
    func glassShimmerAnimation(isActive: Bool, duration: Double = 1.0, color: Color = .white) -> some View {
        modifier(GlassShimmerAnimation(isActive: isActive, duration: duration, color: color))
    }
    
    func glassPulseAnimation(isActive: Bool, scale: CGFloat = 1.05, opacity: Double = 0.7, duration: Double = 1.0) -> some View {
        modifier(GlassPulseAnimation(isActive: isActive, scale: scale, opacity: opacity, duration: duration))
    }
    
    func glassRotationAnimation(isActive: Bool, duration: Double = 2.0) -> some View {
        modifier(GlassRotationAnimation(isActive: isActive, duration: duration))
    }
    
    // Complex animations
    func glassLoadingAnimation(isLoading: Bool) -> some View {
        modifier(GlassLoadingAnimation(isLoading: isLoading))
    }
    
    func glassSuccessAnimation(showSuccess: Bool) -> some View {
        modifier(GlassSuccessAnimation(showSuccess: showSuccess))
    }
}

// MARK: - Animation Presets

struct GlassAnimations {
    // Button press animations
    static let buttonPress = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let quickPress = Animation.easeInOut(duration: 0.1)
    
    // Card animations
    static let cardAppear = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let cardSlide = Animation.spring(response: 0.5, dampingFraction: 0.9)
    
    // Sidebar animations
    static let sidebarSlide = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let sidebarFade = Animation.easeInOut(duration: 0.4)
    
    // Status animations
    static let statusChange = Animation.spring(response: 0.4, dampingFraction: 0.8)
    static let successPulse = Animation.spring(response: 0.3, dampingFraction: 0.6)
    
    // Loading animations
    static let shimmer = Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
    static let pulse = Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)
    static let rotation = Animation.linear(duration: 2.0).repeatForever(autoreverses: false)
}
