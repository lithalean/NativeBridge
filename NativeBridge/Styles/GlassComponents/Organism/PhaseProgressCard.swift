//
//  PhaseProgressCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  PhaseProgressCard.swift
//  NativeBridge
//

import SwiftUI

/// Phase progress card with full progress section
struct PhaseProgressCard: View {
    let title: String
    let subtitle: String
    let progress: Double
    let currentPhase: String
    
    var body: some View {
        VStack(spacing: 16) {
            GlassContentSection(
                title: title,
                subtitle: subtitle,
                alignment: .center
            )
            .padding(.top, 8)
            
            GlassProgressSection(
                title: "Development Progress",
                currentPhase: currentPhase,
                progress: progress
            )
        }
        .padding(GlassConstants.cardPadding)
        .liquidGlassCard()
    }
}

#Preview {
    PhaseProgressCard(
        title: "NativeBridge Development",
        subtitle: "Cross-platform integration layer",
        progress: 2.0,
        currentPhase: "Phase 2"
    )
    .padding()
}