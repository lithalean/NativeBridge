//
//  DebugConsoleHeader.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  DebugConsoleHeader.swift
//  NativeBridge
//

import SwiftUI

/// Debug console header with clear button
struct DebugConsoleHeader: View {
    let onClear: () -> Void
    
    var body: some View {
        HStack {
            Text("Debug Console")
                .glassHeadline()
            
            Spacer()
            
            Button("Clear", action: onClear)
                .font(.caption.weight(.medium))
                .foregroundStyle(GlassColors.accent)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(GlassColors.accent.opacity(0.2), in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(GlassColors.accent.opacity(0.5), lineWidth: 1)
                )
        }
    }
}

#Preview {
    DebugConsoleHeader(onClear: {})
        .padding()
}