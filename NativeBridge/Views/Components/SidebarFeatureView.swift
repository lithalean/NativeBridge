//
//  SidebarFeatureView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


import SwiftUI

struct SidebarFeatureView: View {
    let feature: SidebarFeatureModel
    
    var body: some View {
        Button(action: {
            feature.action()
        }) {
            Label(feature.title, systemImage: feature.icon)
                .labelStyle(.titleAndIcon)
                .font(.body.weight(.medium))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white.opacity(0.05))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(feature.isComplete ? Color.green.opacity(0.5) : Color.red.opacity(0.5), lineWidth: 1)
                )
                .foregroundStyle(.white.opacity(0.9))
        }
        .buttonStyle(.plain)
        .hoverEffect(.highlight)
    }
}
