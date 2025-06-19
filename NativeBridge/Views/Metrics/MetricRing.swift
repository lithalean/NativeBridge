//
//  MetricRing.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  MetricRing.swift
//  NativeBridge
//
//  Generic metric ring component with controller selection support

import SwiftUI

struct MetricRing: View {
    let title: String
    let icon: String
    let isActive: Bool
    let progress: Double
    let color: Color
    let valueText: String?
    let isSelected: Bool // Selection state for controller navigation
    
    init(title: String, icon: String, isActive: Bool, progress: Double, color: Color, valueText: String? = nil, isSelected: Bool = false) {
        self.title = title
        self.icon = icon
        self.isActive = isActive
        self.progress = progress
        self.color = color
        self.valueText = valueText
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                // Base circle
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: progress)
                
                // Selection ring animation
                if isSelected {
                    Circle()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .frame(width: 72, height: 72)
                        .opacity(0.8)
                        .scaleEffect(1.0)
                        .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isSelected)
                }
                
                GlassIcon(icon, color: isActive ? .white : .gray, size: .body)
            }
            
            // Enhanced text styling for selection
            Text(title)
                .font(.caption2)
                .foregroundColor(isSelected ? .white : .secondary)
                .fontWeight(isSelected ? .bold : .regular)
                .animation(.easeInOut(duration: 0.3), value: isSelected)
            
            if let valueText = valueText {
                Text(valueText)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
        }
    }
}