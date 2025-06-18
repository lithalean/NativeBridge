//
//  View+GlassMaterials.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public extension View {

    // MARK: - Toolbar Glass
    
    func toolbarGlass(cornerRadius: CGFloat = GlassConstants.mediumRadius) -> some View {
        self
            .background(GlassConstants.toolbarGlassMaterial)
            .cornerRadius(cornerRadius)
    }

    // MARK: - Card Glass
    
    func cardGlass(cornerRadius: CGFloat = GlassConstants.largeRadius) -> some View {
        self
            .background(GlassConstants.cardGlassMaterial)
            .cornerRadius(cornerRadius)
            .shadow(radius: 10)
    }

    // MARK: - Floating Glass
    
    func floatingGlass(cornerRadius: CGFloat = GlassConstants.mediumRadius, shadowRadius: CGFloat = 12) -> some View {
        self
            .background(GlassConstants.toolbarGlassMaterial)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }

    // MARK: - Pure Glass Overlay
    
    func pureGlassOverlay(opacity: Double = 0.9, cornerRadius: CGFloat = GlassConstants.largeRadius) -> some View {
        self
            .background(.ultraThinMaterial)
            .opacity(opacity)
            .cornerRadius(cornerRadius)
    }
}
