//
//  View+GlassTypography.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public extension View {
    func glassTitle() -> some View {
        modifier(GlassTitle())
    }
    
    func glassSubtitle() -> some View {
        modifier(GlassSubtitle())
    }
    
    func glassHeadline() -> some View {
        modifier(GlassHeadline())
    }
    
    func glassCaption(opacity: Double = 0.7) -> some View {
        modifier(GlassCaption(opacity: opacity))
    }
}
