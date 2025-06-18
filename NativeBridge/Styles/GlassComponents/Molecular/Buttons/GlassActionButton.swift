//
//  GlassActionButton.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public struct GlassActionButton: ButtonStyle {
    
    // Apple-style: static let default value (avoid internal in param)
    public static let defaultColor = GlassColors.accent

    let color: Color
    let isEnabled: Bool
    
    public init(color: Color = GlassActionButton.defaultColor, isEnabled: Bool = true) {
        self.color = color
        self.isEnabled = isEnabled
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(isEnabled ? GlassColors.primary : Color.gray)
            .background(
                .ultraThinMaterial.opacity(isEnabled ? 0.8 : 0.4),
                in: RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                    .stroke(.white.opacity(isEnabled ? 0.1 : 0.05), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: GlassConstants.fastAnimation), value: configuration.isPressed)
    }
}

#Preview {
    Button(action: {}) {
        Label("Action", systemImage: "play.fill")
    }
    .buttonStyle(GlassActionButton())
    .frame(width: 200)
}
