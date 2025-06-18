//
//  GlassIcon.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassIcon.swift
//  NativeBridge
//

import SwiftUI

/// Reusable icon with consistent glass styling
struct GlassIcon: View {
    let systemName: String
    let color: Color
    let size: Font
    
    init(_ systemName: String, color: Color = GlassColors.primary, size: Font = .title3) {
        self.systemName = systemName
        self.color = color
        self.size = size
    }
    
    var body: some View {
        Image(systemName: systemName)
            .font(size)
            .foregroundStyle(color)
    }
}

#Preview {
    VStack(spacing: 20) {
        GlassIcon("star.fill", color: .blue)
        GlassIcon("heart.fill", color: .red, size: .largeTitle)
        GlassIcon("gear", color: .gray, size: .caption)
    }
    .padding()
}