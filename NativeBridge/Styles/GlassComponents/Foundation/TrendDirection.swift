//
//  TrendDirection.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  TrendDirection.swift
//  NativeBridge
//

import SwiftUI

/// Enum representing trend directions with associated styling
enum TrendDirection {
    case up, down, stable
    
    var icon: String {
        switch self {
        case .up: return "↗"
        case .down: return "↘"
        case .stable: return "→"
        }
    }
    
    var color: Color {
        switch self {
        case .up: return GlassColors.success
        case .down: return GlassColors.error
        case .stable: return GlassColors.accent
        }
    }
}