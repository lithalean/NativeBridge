//
//  GlassProgressSection.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassProgressSection.swift
//  NativeBridge
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
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .glassHeadline()
                
                Spacer()
                
                Text(currentPhase)
                    .glassStatusBadge(color: GlassColors.accent)
            }
            
            HStack(spacing: 12) {
                ForEach(0..<segmentCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .frame(height: 4)
                        .foregroundStyle(Double(index) < progress ? GlassColors.success : GlassColors.primary.opacity(0.3))
                }
            }
            .glassSpringAnimation(trigger: progress > 0)
        }
    }
}

#Preview {
    GlassProgressSection(title: "Development Progress", currentPhase: "Phase 2", progress: 2.5)
        .padding()
}