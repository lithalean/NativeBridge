//
//  GlassProgressSection.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// Progress bar section with title and phase indicator
struct GlassProgressSection: View {
    let title: String
    let currentPhase: String
    let progress: Double
    let segmentCount: Int
    
    init(title: String, currentPhase: String, progress: Double, segmentCount: Int = 4) {
        self.title = title
        self.currentPhase = currentPhase
        self.progress = progress
        self.segmentCount = segmentCount
    }
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Label(currentPhase, systemImage: "checkmark.seal.fill")
                    .font(.caption)
                    .labelStyle(.titleAndIcon)
                    .padding(.horizontal, GlassConstants.compactPadding)
                    .padding(.vertical, GlassConstants.compactPadding / 2)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: GlassConstants.mediumRadius))
            }
            
            HStack(spacing: GlassConstants.smallSpacing) {
                ForEach(0..<segmentCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .frame(height: 4)
                        .foregroundStyle(Double(index + 1) <= progress ? GlassColors.success : GlassColors.primary.opacity(0.3))
                        .animation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping), value: progress)
                }
            }
        }
    }
}

#Preview {
    GlassProgressSection(
        title: "Development Progress",
        currentPhase: "Phase 2",
        progress: 2.5
    )
    .padding()
}

