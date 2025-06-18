//
//  CoreAnimations.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

// MARK: - Core Glass Animations (from LiquidGlassStyles)

public struct GlassSpringAnimation: ViewModifier {
    let trigger: Bool
    
    public init(trigger: Bool) {
        self.trigger = trigger
    }
    
    public func body(content: Content) -> some View {
        content
            .animation(
                .spring(
                    response: GlassConstants.springResponse,
                    dampingFraction: GlassConstants.springDamping
                ),
                value: trigger
            )
    }
}

public struct GlassFadeTransition: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .transition(.asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
    }
}
