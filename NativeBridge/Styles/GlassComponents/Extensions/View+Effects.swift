//
//  View+Effects.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

// MARK: - GlassEffects View Extension

public extension View {

    // MARK: Pulse
    
    func glassPulse() -> some View {
        self.modifier(GlassPulseAnimation())
    }
    
    // MARK: Rotation
    
    func glassRotate() -> some View {
        self.modifier(GlassRotationAnimation())
    }
    
    // MARK: Loading
    
    func glassLoading() -> some View {
        self.modifier(GlassLoadingAnimation())
    }
    
    // MARK: Success
    
    func glassSuccess() -> some View {
        self.modifier(GlassSuccessAnimation())
    }
    
    // MARK: Fade
    
    func glassFadeTransition() -> some View {
        self.modifier(GlassFadeTransition())
    }
    
    // MARK: Spring
    
    func glassSpring(trigger: Bool) -> some View {
        self.modifier(GlassSpringAnimation(trigger: trigger))
    }
}

