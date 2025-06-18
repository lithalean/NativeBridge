//
//  GlassContentSection.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassContentSection.swift
//  NativeBridge
//

import SwiftUI

/// Content section with title and subtitle
struct GlassContentSection: View {
    let title: String
    let subtitle: String
    let titleColor: Color
    let subtitleColor: Color
    let alignment: HorizontalAlignment
    
    init(title: String, subtitle: String, titleColor: Color = GlassColors.primary, subtitleColor: Color = GlassColors.tertiary, alignment: HorizontalAlignment = .leading) {
        self.title = title
        self.subtitle = subtitle
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(titleColor)
                .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : .center)
            
            Text(subtitle)
                .font(.caption2.weight(.medium))
                .foregroundStyle(subtitleColor)
                .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : .center)
                .lineLimit(2)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        GlassContentSection(title: "Title", subtitle: "Subtitle description")
        GlassContentSection(title: "Centered", subtitle: "Center aligned", alignment: .center)
    }
    .padding()
}