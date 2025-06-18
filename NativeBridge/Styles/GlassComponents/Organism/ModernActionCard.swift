//
//  ModernActionCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  ModernActionCard.swift
//  NativeBridge
//

import SwiftUI

/// Modern action card with glass styling
struct ModernActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                GlassCardHeader(
                    icon: icon,
                    iconColor: isEnabled ? color : .gray
                )
                
                GlassContentSection(
                    title: title,
                    subtitle: subtitle,
                    titleColor: isEnabled ? GlassColors.primary : .gray,
                    subtitleColor: isEnabled ? GlassColors.tertiary : .gray.opacity(0.7)
                )
            }
            .padding(GlassConstants.itemPadding)
        }
        .buttonStyle(GlassActionButton(isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

#Preview {
    HStack {
        ModernActionCard(
            title: "Deploy",
            subtitle: "Deploy to production",
            icon: "arrow.up.circle.fill",
            color: .green,
            isEnabled: true,
            action: {}
        )
        
        ModernActionCard(
            title: "Rollback",
            subtitle: "Rollback changes",
            icon: "arrow.uturn.backward",
            color: .red,
            isEnabled: false,
            action: {}
        )
    }
    .padding()
}