//
//  GlassSectionHeader.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassSectionHeader.swift
//  NativeBridge
//

import SwiftUI

/// Section header with customizable trailing content
struct GlassSectionHeader: View {
    let title: String
    let icon: String
    let iconColor: Color
    let trailing: AnyView?
    
    init(title: String, icon: String, iconColor: Color = GlassColors.accent, @ViewBuilder trailing: () -> some View = { EmptyView() }) {
        self.title = title
        self.icon = icon
        self.iconColor = iconColor
        self.trailing = AnyView(trailing())
    }
    
    var body: some View {
        HStack {
            Text(title)
                .glassHeadline()
            
            Spacer()
            
            if let trailing = trailing {
                trailing
            }
            
            GlassIcon(icon, color: iconColor)
        }
    }
}

#Preview {
    VStack {
        GlassSectionHeader(title: "Features", icon: "list.bullet.circle")
        
        GlassSectionHeader(title: "Settings", icon: "gear") {
            Button("Edit") {}
        }
    }
    .padding()
}