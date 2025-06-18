//
//  AnimationPresets.swift
//  NativeBridge
//
//  Glass Animation Presets and Constants
//  Location: Styles/GlassDesignSystem/Atomic/Effects/AnimationPresets.swift
//

import SwiftUI

// MARK: - Animation Presets (from Animations.swift)

public struct GlassAnimations {
    // Button press animations
    public static let buttonPress = Animation.spring(response: 0.3, dampingFraction: 0.7)
    public static let quickPress = Animation.easeInOut(duration: 0.1)
    
    // Card animations
    public static let cardAppear = Animation.spring(response: 0.6, dampingFraction: 0.8)
    public static let cardSlide = Animation.spring(response: 0.5, dampingFraction: 0.9)
    
    // Sidebar animations
    public static let sidebarSlide = Animation.spring(response: 0.6, dampingFraction: 0.8)
    public static let sidebarFade = Animation.easeInOut(duration: 0.4)
    
    // Status animations
    public static let statusChange = Animation.spring(response: 0.4, dampingFraction: 0.8)
    public static let successPulse = Animation.spring(response: 0.3, dampingFraction: 0.6)
    
    // Loading animations
    public static let shimmer = Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
    public static let pulse = Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)
    public static let rotation = Animation.linear(duration: 2.0).repeatForever(autoreverses: false)
}
