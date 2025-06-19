//
//  ControlButtons.swift
//  NativeBridge
//
//  Button components for control sidebar

import SwiftUI

// MARK: - Primary Action Button
struct PrimaryActionButton: View {
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GlassIcon(icon, color: isEnabled ? color : .gray, size: .title2)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? color.opacity(0.15) : Color.gray.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isEnabled ? color.opacity(0.4) : Color.gray.opacity(0.3), lineWidth: 1.5)
                        )
                )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isEnabled ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

// MARK: - Icon Button
struct IconButton: View {
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GlassIcon(icon, color: isEnabled ? color : .gray, size: .title3)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? color.opacity(0.1) : Color.gray.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isEnabled ? color.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
                        )
                )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Compact Button
struct CompactButton: View {
    let title: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                GlassIcon(icon, color: isEnabled ? color : .gray, size: .caption)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(isEnabled ? .white : .gray)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isEnabled ? color.opacity(0.1) : Color.gray.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEnabled ? color.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
    }
}
