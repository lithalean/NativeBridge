//
//  ConsoleMessageType.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  ConsoleMessageType.swift
//  NativeBridge
//
//  Console message categorization and styling

import SwiftUI

enum ConsoleMessageType {
    case success, error, warning, info, debug, controller
    
    var color: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        case .info: return .blue
        case .controller: return .mint
        case .debug: return .secondary
        }
    }
    
    var prefix: String {
        switch self {
        case .success: return "✅"
        case .error: return "❌"
        case .warning: return "⚠️"
        case .info: return "ℹ️"
        case .controller: return "🎮"
        case .debug: return "🔧"
        }
    }
}