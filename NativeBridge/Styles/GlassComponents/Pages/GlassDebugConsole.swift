//
//  GlassDebugConsole.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassDebugConsole.swift
//  NativeBridge
//

import SwiftUI

/// Complete debug console page component
struct GlassDebugConsole: View {
    let messages: [String]
    let onClear: () -> Void
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            DebugConsoleHeader(onClear: onClear)
            DebugConsoleContent(messages: messages)
        }
        .padding(GlassConstants.cardPadding)
        .cardGlass()
    }
}

#Preview {
    GlassDebugConsole(
        messages: [
            "✅ System initialized successfully",
            "🔄 Loading configuration...",
            "📦 Data fetched from API",
            "❌ Network timeout occurred",
            "🔄 Retrying connection..."
        ],
        onClear: {}
    )
    .padding()
}
