//
//  SidebarFeatureModel.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

/// Struct model for Sidebar Feature (used in FloatingSidebar, FeatureLists)
struct SidebarFeatureModel: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let isComplete: Bool
    let action: () -> Void
    
    static let sampleFeatures: [SidebarFeatureModel] = [
        SidebarFeatureModel(
            title: "Settings",
            icon: "gearshape",
            isComplete: true,
            action: { print("Settings tapped") }
        ),
        SidebarFeatureModel(
            title: "Debug",
            icon: "ladybug",
            isComplete: false,
            action: { print("Debug tapped") }
        ),
        SidebarFeatureModel(
            title: "Help",
            icon: "questionmark.circle",
            isComplete: true,
            action: { print("Help tapped") }
        ),
        SidebarFeatureModel(
            title: "System Monitor",
            icon: "waveform.path.ecg",
            isComplete: true,
            action: { print("System Monitor tapped") }
        ),
        SidebarFeatureModel(
            title: "Console",
            icon: "terminal",
            isComplete: true,
            action: { print("Console tapped") }
        )
    ]
}
