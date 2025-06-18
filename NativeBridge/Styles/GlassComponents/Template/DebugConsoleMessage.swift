//
//  DebugConsoleMessage.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  DebugConsoleMessage.swift
//  NativeBridge
//

import SwiftUI

/// Individual debug console message with color coding
struct DebugConsoleMessage: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.system(.caption, design: .monospaced))
            .foregroundStyle(messageColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var messageColor: Color {
        if message.contains("✅") {
            return GlassColors.success.opacity(0.8)
        } else if message.contains("❌") {
            return GlassColors.error.opacity(0.8)
        } else if message.contains("🔄") {
            return GlassColors.warning.opacity(0.8)
        } else if message.contains("📦") || message.contains("🎮") {
            return GlassColors.info.opacity(0.8)
        } else {
            return GlassColors.secondary
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        DebugConsoleMessage(message: "✅ Success message")
        DebugConsoleMessage(message: "❌ Error message")
        DebugConsoleMessage(message: "🔄 Processing message")
        DebugConsoleMessage(message: "📦 Info message")
    }
    .padding()
}