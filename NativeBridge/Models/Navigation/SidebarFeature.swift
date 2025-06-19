//
//  SidebarFeature.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import Foundation

/// Enum model for sidebar feature items
enum SidebarFeature: CaseIterable, Identifiable {
    case settings
    case debug
    case help
    case systemMonitor
    case console
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .settings: return "Settings"
        case .debug: return "Debug"
        case .help: return "Help"
        case .systemMonitor: return "System Monitor"
        case .console: return "Console"
        }
    }
    
    var icon: String {
        switch self {
        case .settings: return "gearshape"
        case .debug: return "ladybug"
        case .help: return "questionmark.circle"
        case .systemMonitor: return "waveform.path.ecg"
        case .console: return "terminal"
        }
    }
    
    var isComplete: Bool {
        switch self {
        case .settings: return true
        case .debug: return false
        case .help: return true
        case .systemMonitor: return true
        case .console: return true
        }
    }
    
    var action: () -> Void {
        switch self {
        case .settings:
            return { print("Settings tapped") }
        case .debug:
            return { print("Debug tapped") }
        case .help:
            return { print("Help tapped") }
        case .systemMonitor:
            return { print("System Monitor tapped") }
        case .console:
            return { print("Console tapped") }
        }
    }
    
    // MARK: - Groupings
    
    static var groups: [[SidebarFeature]] {
        [
            [ .settings, .help ],
            [ .systemMonitor, .debug ],
            [ .console ]
        ]
    }
}
