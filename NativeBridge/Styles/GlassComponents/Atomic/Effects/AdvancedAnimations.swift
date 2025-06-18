//
//  AdvancedAnimations.swift
//  NativeBridge
//
//  Advanced Glass Animation Effects
//  Location: Styles/GlassDesignSystem/Atomic/Effects/AdvancedAnimations.swift
//

import SwiftUI

// MARK: - Scale & Movement Animations

public struct GlassScaleAnimation: ViewModifier {
    let isPressed: Bool
    let scale: CGFloat
    let duration: Double
    
    public init(isPressed: Bool, scale: CGFloat = 0.95, duration: Double = 0.1) {
        self.isPressed = isPressed
        self.scale = scale
        self.duration = duration
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(.easeInOut(duration: duration), value: isPressed)
    }
}

public struct GlassSlideAnimation: ViewModifier {
    let isVisible: Bool
    let edge: Edge
    let distance: CGFloat
    
    public init(isVisible: Bool, edge: Edge = .leading, distance: CGFloat = 300) {
        self.isVisible = isVisible
        self.edge = edge
        self.distance = distance
    }
    
    public func body(content: Content) -> some View {
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
        case .top, .bottom:
            return 0
        }
    }
}

// MARK: - Effect Animations

public struct GlassShimmerAnimation: ViewModifier {
    let isActive: Bool
    let duration: Double
    let color: Color
    
    @State private var shimmerOffset: CGFloat = -1
    
    public init(isActive: Bool, duration: Double = 1.0, color: Color = .white) {
        self.isActive = isActive
        self.duration = duration
        self.color = color
    }
    
    public func body(content: Content) -> some View {
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

// MARK: - Pulse Animation

public struct GlassPulseAnimation: ViewModifier {
    @State private var pulse = false
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(pulse ? 1.05 : 0.95)
            .animation(
                .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                value: pulse
            )
            .onAppear {
                pulse = true
            }
    }
}

// MARK: - Rotation Animation

public struct GlassRotationAnimation: ViewModifier {
    @State private var rotate = false
    
    public func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotate ? 360 : 0))
            .animation(
                .linear(duration: 2.0).repeatForever(autoreverses: false),
                value: rotate
            )
            .onAppear {
                rotate = true
            }
    }
}

// MARK: - Loading Animation

public struct GlassLoadingAnimation: ViewModifier {
    @State private var loading = false
    
    public func body(content: Content) -> some View {
        content
            .opacity(loading ? 1.0 : 0.3)
            .scaleEffect(loading ? 1.0 : 0.8)
            .animation(
                .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                value: loading
            )
            .onAppear {
                loading = true
            }
    }
}

// MARK: - Success Animation

public struct GlassSuccessAnimation: ViewModifier {
    @State private var success = false
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(success ? 1.0 : 0.0)
            .opacity(success ? 1.0 : 0.0)
            .animation(
                .spring(response: GlassConstants.springResponse,
                        dampingFraction: GlassConstants.springDamping),
                value: success
            )
            .onAppear {
                success = true
            }
    }
}

// Additional animations follow the same pattern...
