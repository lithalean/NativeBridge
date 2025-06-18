//
//  ModernMetricCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  ModernMetricCard.swift
//  NativeBridge
//

import SwiftUI

/// Modern metric card with trend indicator
struct ModernMetricCard: View {
    let title: String
    let value: String
    let trend: TrendDirection
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                GlassIcon(icon, color: GlassColors.info, size: .caption.weight(.medium))
                
                Spacer()
                
                Text(trend.icon)
                    .font(.caption2)
                    .foregroundStyle(trend.color)
            }
            
            GlassContentSection(
                title: value,
                subtitle: title
            )
        }
        .padding(GlassConstants.itemPadding)
        .cardGlass()
    }
}

#Preview {
    HStack {
        ModernMetricCard(
            title: "Active Users",
            value: "1,234",
            trend: .up,
            icon: "person.3.fill"
        )
        
        ModernMetricCard(
            title: "Server Load",
            value: "23%",
            trend: .down,
            icon: "cpu"
        )
    }
    .padding()
}
