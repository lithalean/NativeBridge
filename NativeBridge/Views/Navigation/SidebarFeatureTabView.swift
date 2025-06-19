//
//  SidebarFeatureView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

struct SidebarFeatureTabView: View {
    let feature: SidebarFeature
    
    var body: some View {
        Button(action: {
            feature.action()
        }) {
            Image(systemName: feature.icon)
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 32, height: 32)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.white.opacity(0.15), lineWidth: 1)
                )
                .foregroundStyle(.white.opacity(0.9))
        }
        .buttonStyle(.plain)
        .hoverEffect(.highlight)
    }
}
