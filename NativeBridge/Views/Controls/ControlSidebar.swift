//
//  ControlSidebar.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  ControlSidebar.swift
//  NativeBridge
//
//  Compact icon-only control sidebar

import SwiftUI

struct ControlSidebar: View {
    @ObservedObject var bridgeManager: BridgeManager
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Simple Header - Just Close Button
            HStack {
                Spacer()
                Button(action: onClose) {
                    GlassIcon("xmark.circle.fill", size: .body)
                }
                .buttonStyle(GlassButtons.CircularGlassButton())
            }
            .padding(GlassConstants.smallSpacing)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Icon-Only Controls
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: GlassConstants.smallSpacing) {
                    engineControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    pckManagement
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    controllerControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    testingControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    // Controller Status View
                    DetailedControllerStatus(controllerManager: bridgeManager.controllerManager)
                        .padding(.horizontal, 4)
                }
                .padding(.horizontal, GlassConstants.tightSpacing)
                .padding(.vertical, GlassConstants.smallSpacing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Engine Controls
    private var engineControls: some View {
        VStack(spacing: 4) {
            PrimaryActionButton(
                icon: "play.fill",
                color: .green,
                isEnabled: !bridgeManager.isEngineConnected,
                action: { bridgeManager.connectGameEngine() }
            )
            
            PrimaryActionButton(
                icon: "stop.fill",
                color: .red,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.disconnectGameEngine() }
            )
        }
    }
    
    // MARK: - PCK Management
    private var pckManagement: some View {
        VStack(spacing: 4) {
            PrimaryActionButton(
                icon: "doc.badge.plus",
                color: .blue,
                isEnabled: bridgeManager.isEngineConnected && !bridgeManager.isPCKLoaded,
                action: {
                    Task {
                        await bridgeManager.loadPCKBundle()
                    }
                }
            )
            
            if bridgeManager.isPCKLoaded {
                PrimaryActionButton(
                    icon: "doc.text.magnifyingglass",
                    color: .purple,
                    isEnabled: true,
                    action: {
                        Task {
                            await bridgeManager.inspectProjectStructure()
                        }
                    }
                )
            }
        }
    }
    
    // MARK: - Controller Controls
    private var controllerControls: some View {
        VStack(spacing: 4) {
            // Controller Detection Status
            PrimaryActionButton(
                icon: bridgeManager.controllerManager.isControllerConnected ? "gamecontroller.fill" : "gamecontroller",
                color: bridgeManager.controllerManager.isControllerConnected ? .mint : .gray,
                isEnabled: true,
                action: {
                    // Trigger haptic feedback if controller connected
                    if bridgeManager.controllerManager.isControllerConnected {
                        bridgeManager.controllerManager.triggerHapticFeedback(0.7)
                    }
                }
            )
            
            // Controller Test Button (only show if controller connected)
            if bridgeManager.controllerManager.isControllerConnected {
                PrimaryActionButton(
                    icon: "waveform.circle.fill",
                    color: .cyan,
                    isEnabled: true,
                    action: {
                        // Test controller haptic feedback
                        bridgeManager.controllerManager.triggerHapticFeedback(1.0)
                        
                        // Add debug message about controller test
                        let controllerCount = bridgeManager.controllerManager.connectedControllers.count
                        bridgeManager.addDebugMessage("🎮 Controller test - \(controllerCount) controller(s) responded")
                    }
                )
            }
        }
    }
    
    // MARK: - Testing Controls
    private var testingControls: some View {
        VStack(spacing: 4) {
            PrimaryActionButton(
                icon: "antenna.radiowaves.left.and.right",
                color: .orange,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.sendTestMessage() }
            )
            
            PrimaryActionButton(
                icon: "checkmark.shield.fill",
                color: .cyan,
                isEnabled: bridgeManager.isPCKLoaded,
                action: { bridgeManager.testProjectAccess() }
            )
        }
    }
}
