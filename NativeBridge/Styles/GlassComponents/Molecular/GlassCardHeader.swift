//
//  GlassCardHeader.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassCardHeader.swift
//  NativeBridge
//

import SwiftUI

/// Card header with icon and optional status indicator
struct GlassCardHeader: View {
    let icon: String
    let title: String
    let iconColor: Color
    let showStatus: Bool
    let isActive: Bool
    
    init(icon: String, title: String = "", iconColor: Color = GlassColors.primary, showStatus: Bool = false, isActive: Bool = false) {
        self.icon = icon
        self.title = title
        self.iconColor = iconColor
        self.showStatus = showStatus
        self.isActive = isActive
    }
    
    var body: some View {
        HStack {
            GlassIcon(icon, color: iconColor)
            
            if !title.isEmpty {
                Text(title)
                    .glassHeadline()
            }
            
            Spacer()
            
            if showStatus {
                GlassStatusIndicator(isActive: isActive, color: iconColor)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        GlassCardHeader(icon: "star.fill", iconColor: .blue, showStatus: true, isActive: true)
        GlassCardHeader(icon: "gear", title: "Settings", iconColor: .gray)
    }
    .padding()
}