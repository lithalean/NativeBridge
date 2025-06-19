//
//  DetailedControllerStatus.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI
import GameController

struct DetailedControllerStatus: View {
    @ObservedObject var controllerManager: GameControllerManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                GlassIcon("gamecontroller.fill", size: .body)
                    .foregroundColor(.mint)
                
                Text("Controllers")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(controllerManager.connectedControllers.count)")
                    .font(.caption)
                    .foregroundColor(.mint)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.mint.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            if controllerManager.isControllerConnected {
                // Connected Controllers List
                ForEach(controllerManager.connectedControllers, id: \.self) { controller in
                    controllerRow(controller)
                }
                
                // Recent Input Summary
                if !controllerManager.inputEvents.isEmpty {
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Recent Input")
                            .font(.caption)
                            .foregroundColor(.mint)
                            .fontWeight(.medium)
                        
                        if let lastEvent = controllerManager.inputEvents.last {
                            Text("\(lastEvent.type.rawValue): \(String(format: "%.2f", lastEvent.value))")
                                .font(.system(.caption2, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                // No Controllers Message
                VStack(alignment: .leading, spacing: 8) {
                    Text("No Controllers Connected")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Connect a controller for enhanced navigation and gameplay")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .italic()
                    
                    Text("Supported: Xbox, PlayStation, MFi")
                        .font(.caption2)
                        .foregroundColor(.mint.opacity(0.7))
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.mint.opacity(0.3), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func controllerRow(_ controller: GCController) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // Controller Type Icon
                GlassIcon(
                    controllerManager.getControllerType(controller).icon,
                    size: .caption
                )
                .foregroundColor(.mint)
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(controllerManager.getControllerName(controller))
                        .font(.caption)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text(controllerManager.getControllerType(controller).rawValue)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Battery Info
                let batteryInfo = controllerManager.getControllerBatteryInfo(controller)
                if batteryInfo.level < 1.0 {
                    HStack(spacing: 2) {
                        GlassIcon(
                            batteryIcon(for: batteryInfo.level),
                            size: .caption2
                        )
                        .foregroundColor(batteryColor(for: batteryInfo.level))
                        
                        Text("\(Int(batteryInfo.level * 100))%")
                            .font(.system(.caption2, design: .monospaced))
                            .foregroundColor(batteryColor(for: batteryInfo.level))
                    }
                }
            }
            
            // Connection Status
            HStack(spacing: 4) {
                Circle()
                    .fill(Color.mint)
                    .frame(width: 4, height: 4)
                
                Text("Connected")
                    .font(.caption2)
                    .foregroundColor(.mint)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.mint.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.mint.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private func batteryIcon(for level: Float) -> String {
        switch level {
        case 0.75...1.0: return "battery.100"
        case 0.5..<0.75: return "battery.75"
        case 0.25..<0.5: return "battery.50"
        case 0.1..<0.25: return "battery.25"
        default: return "battery.0"
        }
    }
    
    private func batteryColor(for level: Float) -> Color {
        switch level {
        case 0.3...1.0: return .mint
        case 0.15..<0.3: return .orange
        default: return .red
        }
    }
}

#Preview {
    DetailedControllerStatus(controllerManager: GameControllerManager())
        .background(Color.black)
        .padding()
}
