//
//  ControllerStatusCard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI
import GameController

struct ControllerStatusCard: View {
    @ObservedObject var controllerManager: GameControllerManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: GlassConstants.mediumSpacing) {
            // Header
            HStack {
                GlassIcon(
                    "gamecontroller.fill",
                    size: .title2
                )
                .foregroundColor(controllerManager.isControllerConnected ? GlassColors.accent : GlassColors.secondary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Game Controllers")
                        .font(.headline)
                        .foregroundColor(GlassColors.primary)
                    
                    Text(controllerManager.isControllerConnected ?
                         "\(controllerManager.connectedControllers.count) Connected" :
                         "No Controllers")
                        .font(.caption)
                        .foregroundColor(GlassColors.secondary)
                }
                
                Spacer()
                
                // Connection Status
                Circle()
                    .fill(controllerManager.isControllerConnected ? GlassColors.success : GlassColors.error)
                    .frame(width: 8, height: 8)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
            }
            
            if controllerManager.isControllerConnected {
                // Connected Controllers List
                ForEach(controllerManager.connectedControllers, id: \.self) { controller in
                    controllerRow(controller)
                }
                
                // Recent Input Activity
                if !controllerManager.inputEvents.isEmpty {
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent Input")
                            .font(.subheadline)
                            .foregroundColor(GlassColors.primary)
                        
                        LazyVStack(spacing: 4) {
                            ForEach(controllerManager.inputEvents.suffix(3)) { event in
                                inputEventRow(event)
                            }
                        }
                    }
                }
            } else {
                // No Controllers Message
                VStack(spacing: 12) {
                    Text("Connect a game controller to enhance your experience")
                        .font(.body)
                        .foregroundColor(GlassColors.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text("Supported: Xbox, PlayStation, MFi Controllers")
                        .font(.caption)
                        .foregroundColor(GlassColors.tertiary)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, GlassConstants.mediumSpacing)
            }
        }
        .padding(GlassConstants.mediumSpacing)
        .cardGlass()
    }
    
    @ViewBuilder
    private func controllerRow(_ controller: GCController) -> some View {
        HStack {
            // Controller Type Icon
            GlassIcon(
                controllerManager.getControllerType(controller).icon,
                size: .body
            )
            .foregroundColor(GlassColors.accent)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(controllerManager.getControllerName(controller))
                    .font(.body)
                    .foregroundColor(GlassColors.primary)
                
                Text(controllerManager.getControllerType(controller).rawValue)
                    .font(.caption)
                    .foregroundColor(GlassColors.secondary)
            }
            
            Spacer()
            
            // Battery Info
            let batteryInfo = controllerManager.getControllerBatteryInfo(controller)
            if batteryInfo.level < 1.0 {
                HStack(spacing: 4) {
                    GlassIcon(
                        batteryIcon(for: batteryInfo.level),
                        size: .caption
                    )
                    .foregroundColor(batteryColor(for: batteryInfo.level))
                    
                    Text("\(Int(batteryInfo.level * 100))%")
                        .font(.caption)
                        .foregroundColor(GlassColors.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private func inputEventRow(_ event: GameControllerManager.ControllerInputEvent) -> some View {
        HStack {
            Text(event.type.rawValue)
                .font(.caption)
                .foregroundColor(GlassColors.secondary)
            
            Spacer()
            
            Text(String(format: "%.2f", event.value))
                .font(.caption)
                .foregroundColor(GlassColors.primary)
                .monospacedDigit()
            
            Text(timeFormatter.string(from: event.timestamp))
                .font(.caption2)
                .foregroundColor(GlassColors.tertiary)
        }
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
        case 0.3...1.0: return GlassColors.success
        case 0.15..<0.3: return GlassColors.warning
        default: return GlassColors.error
        }
    }
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}

#Preview {
    ControllerStatusCard(controllerManager: GameControllerManager())
        .background(GlassColors.backgroundGradient)
}
