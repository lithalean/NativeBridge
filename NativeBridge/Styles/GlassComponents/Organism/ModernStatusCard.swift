//
//  ModernStatusCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  ModernStatusCard.swift
//  NativeBridge
//

import SwiftUI

/// Modern status card with glass styling
struct ModernStatusCard: View {
    let title: String
    let status: ComponentStatus
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            GlassCardHeader(
                icon: icon,
                iconColor: status.isConnected ? GlassColors.success : GlassColors.error,
                showStatus: true,
                isActive: status.isConnected
            )
            
            GlassContentSection(
                title: title,
                subtitle: status.displayName
            )
        }
        .padding(GlassConstants.itemPadding)
        .cardGlass()
    }
}

#Preview {
    ModernStatusCard(
        title: "Database Connection",
        status: ComponentStatus(isConnected: true, displayName: "Connected to primary server"),
        icon: "server.rack"
    )
    .padding()
}
