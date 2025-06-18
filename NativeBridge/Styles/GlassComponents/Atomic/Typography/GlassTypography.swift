//
//  GlassTypography.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public struct GlassTitle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(GlassColors.primary)
    }
}

public struct GlassSubtitle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.subheadline.weight(.medium))
            .foregroundStyle(GlassColors.secondary)
            .textCase(.uppercase)
            .tracking(1)
    }
}

public struct GlassHeadline: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold))
            .foregroundStyle(GlassColors.primary)
    }
}

public struct GlassCaption: ViewModifier {
    let opacity: Double
    
    public init(opacity: Double = 0.7) {
        self.opacity = opacity
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.caption.weight(.medium))
            .foregroundStyle(.white.opacity(opacity))
    }
}
