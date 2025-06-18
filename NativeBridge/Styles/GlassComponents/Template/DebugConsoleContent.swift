//
//  DebugConsoleContent.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  DebugConsoleContent.swift
//  NativeBridge
//

import SwiftUI

/// Debug console content area
struct DebugConsoleContent: View {
    let messages: [String]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(messages.suffix(25), id: \.self) { message in
                    DebugConsoleMessage(message: message)
                }
            }
            .padding(GlassConstants.itemPadding)
        }
        .frame(height: 160)
        .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: GlassConstants.compactPadding))
        .overlay(
            RoundedRectangle(cornerRadius: GlassConstants.compactPadding)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    DebugConsoleContent(messages: [
        "✅ Connection established",
        "🔄 Processing request...",
        "❌ Error occurred",
        "📦 Data received"
    ])
    .padding()
}