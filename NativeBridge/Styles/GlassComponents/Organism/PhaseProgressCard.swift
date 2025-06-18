//
//  PhaseProgressCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

struct PhaseProgressCard: View {
    let title: String
    let subtitle: String
    let features: [String]
    let progress: Double
    let currentPhase: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: GlassConstants.mediumSpacing) {
            
            // Title + Subtitle
            VStack(alignment: .leading, spacing: GlassConstants.smallSpacing) {
                Text(title)
                    .font(.title.bold())
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // Progress bar
            ProgressView(value: progress)
                .progressViewStyle(.linear)
            
            // Current phase
            Text(currentPhase)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            // Feature list
            HStack {
                ForEach(features, id: \.self) { feature in
                    Label(feature, systemImage: "checkmark.seal.fill")
                        .font(.caption2)
                        .padding(.horizontal, GlassConstants.compactPadding)
                        .padding(.vertical, GlassConstants.compactPadding / 2)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: GlassConstants.mediumRadius))
                }
            }
        }
        .padding(GlassConstants.cardPadding)
        .cardGlass()
    }
}

#Preview {
    PhaseProgressCard(
        title: "NativeBridge",
        subtitle: "Darwin ARM64 Bridge Technology",
        features: [
            "Darwin ARM64",
            "Liquid Glass",
            "Godot Bridge"
        ],
        progress: 1.0,
        currentPhase: "Phase 1 Complete"
    )
}
