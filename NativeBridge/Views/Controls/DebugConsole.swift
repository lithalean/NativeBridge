//
//  DebugConsole.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  DebugConsole.swift
//  NativeBridge
//
//  Professional debug console

import SwiftUI

struct DebugConsole: View {
    @ObservedObject var bridgeManager: BridgeManager
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Console Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Debug Console")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Text("\(bridgeManager.debugMessages.count) messages")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        // Controller Status in Debug Header
                        if bridgeManager.controllerManager.isControllerConnected {
                            Text("• \(bridgeManager.controllerManager.connectedControllers.count) controller(s)")
                                .font(.caption2)
                                .foregroundColor(.mint)
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: { bridgeManager.clearDebugMessages() }) {
                        GlassIcon("trash", size: .caption)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                    
                    Button(action: onClose) {
                        GlassIcon("xmark.circle.fill", size: .body)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                }
            }
            .padding(GlassConstants.smallSpacing)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Console Output
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(Array(bridgeManager.debugMessages.enumerated()), id: \.offset) { index, message in
                            ConsoleLogEntry(
                                lineNumber: index + 1,
                                message: message,
                                messageType: getMessageType(message)
                            )
                            .id(index)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                }
                .onChange(of: bridgeManager.debugMessages.count) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(bridgeManager.debugMessages.count - 1, anchor: .bottom)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private func getMessageType(_ message: String) -> ConsoleMessageType {
        if message.contains("✅") { return .success }
        else if message.contains("❌") { return .error }
        else if message.contains("⚠️") { return .warning }
        else if message.contains("🔄") || message.contains("🔍") { return .info }
        else if message.contains("🎮") { return .controller }
        else { return .debug }
    }
}