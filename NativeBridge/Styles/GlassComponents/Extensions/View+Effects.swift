//
//  View+Effects.swift
//  NativeBridge
//
//  Glass Animation View Extensions
//  Location: Styles/GlassDesignSystem/Extensions/View+Effects.swift
//

import SwiftUI

public extension View {
    // MARK: - Core Animations (from LiquidGlassStyles)
    
    func glassSpringAnimation(trigger: Bool) -> some View {
        modifier(GlassSpringAnimation(trigger: trigger))
    }
    
    func glassFadeTransition() -> some View {
        modifier(GlassFadeTransition())
    }
    
    // MARK: - Advanced Animations (from Animations.swift)
    
    func glassScaleAnimation(isPressed: Bool, scale: CGFloat = 0.95, duration: Double = 0.1) -> some View {
        modifier(GlassScaleAnimation(isPressed: isPressed, scale: scale, duration: duration))
    }
    
    func glassSlideAnimation(isVisible: Bool, edge: Edge = .leading, distance: CGFloat = 300) -> some View {
        modifier(GlassSlideAnimation(isVisible: isVisible, edge: edge, distance: distance))
    }
    
    func glassShimmerAnimation(isActive: Bool, duration: Double = 1.0, color: Color = .white) -> some View {
        modifier(GlassShimmerAnimation(isActive: isActive, duration: duration, color: color))
    }
    
    func glassPulseAnimation(isActive: Bool, scale: CGFloat = 1.05, opacity: Double = 0.7, duration: Double = 1.0) -> some View {
        modifier(GlassPulseAnimation(isActive: isActive, scale: scale, opacity: opacity, duration: duration))
    }
    
    func glassRotationAnimation(isActive: Bool, duration: Double = 2.0) -> some View {
        modifier(GlassRotationAnimation(isActive: isActive, duration: duration))
    }
    
    func glassLoadingAnimation(isLoading: Bool) -> some View {
        modifier(GlassLoadingAnimation(isLoading: isLoading))
    }
    
    func glassSuccessAnimation(showSuccess: Bool) -> some View {
        modifier(GlassSuccessAnimation(showSuccess: showSuccess))
    }
}
