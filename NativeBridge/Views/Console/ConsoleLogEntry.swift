//
//  ConsoleLogEntry.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  ConsoleLogEntry.swift
//  NativeBridge
//
//  Individual console log line component

import SwiftUI

struct ConsoleLogEntry: View {
    let lineNumber: Int
    let message: String
    let messageType: ConsoleMessageType
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // Line number
            Text(String(format: "%03d", lineNumber))
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(Color.secondary.opacity(0.7))
                .frame(width: 30, alignment: .trailing)
            
            // Message type indicator
            Text(messageType.prefix)
                .font(.caption2)
                .frame(width: 16, alignment: .center)
            
            // Message content
            Text(message)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(messageType.color)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 1)
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(messageType == .error ? Color.red.opacity(0.05) :
                      messageType == .warning ? Color.orange.opacity(0.05) :
                      messageType == .controller ? Color.mint.opacity(0.05) :
                      Color.clear)
        )
    }
}