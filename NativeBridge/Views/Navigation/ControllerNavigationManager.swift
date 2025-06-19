//
//  ControllerNavigationManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  ControllerNavigationManager.swift
//  NativeBridge
//
//  Controller-based UI navigation management

import SwiftUI
import GameController

@MainActor
class ControllerNavigationManager: ObservableObject {
    @Published var selectedButton: Int = 0
    @Published var canNavigate: Bool = false
    
    private weak var bridgeManager: BridgeManager?
    private weak var controllerManager: GameControllerManager?
    
    // UI Navigation State
    private let maxButtons = 8 // Number of main UI buttons/rings
    
    init(bridgeManager: BridgeManager) {
        self.bridgeManager = bridgeManager
        self.controllerManager = bridgeManager.controllerManager
        setupControllerNavigation()
    }
    
    func setupControllerNavigation() {
        guard let controllerManager = controllerManager else { return }
        
        // Enable navigation when controller connects
        canNavigate = controllerManager.isControllerConnected
        
        // Setup UI navigation for connected controllers
        for controller in controllerManager.connectedControllers {
            if let gamepad = controller.extendedGamepad {
                setupUINavigation(gamepad)
            }
        }
    }
    
    private func setupUINavigation(_ gamepad: GCExtendedGamepad) {
        // D-Pad for main navigation
        gamepad.dpad.valueChangedHandler = { [weak self] (dpad: GCControllerDirectionPad, xValue: Float, yValue: Float) in
            guard let self = self, self.canNavigate else { return }
            
            if abs(xValue) > 0.5 {
                // Horizontal navigation (left/right through rings)
                if xValue > 0.5 {
                    self.navigateRight()
                } else if xValue < -0.5 {
                    self.navigateLeft()
                }
            }
            
            // Add debug message for navigation
            self.bridgeManager?.addDebugMessage("🎮 UI Navigation: \(xValue > 0 ? "Right" : "Left")")
        }
        
        // A Button for selection/activation
        gamepad.buttonA.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            guard let self = self, pressed, self.canNavigate else { return }
            self.activateSelected()
        }
        
        // B Button for back/cancel
        gamepad.buttonB.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            guard let self = self, pressed, self.canNavigate else { return }
            self.cancelAction()
        }
        
        // Menu button for sidebar toggle
        gamepad.buttonMenu.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            guard let self = self, pressed else { return }
            self.toggleSidebar()
        }
    }
    
    private func navigateRight() {
        selectedButton = min(selectedButton + 1, maxButtons - 1)
        triggerSelectionFeedback()
    }
    
    private func navigateLeft() {
        selectedButton = max(selectedButton - 1, 0)
        triggerSelectionFeedback()
    }
    
    private func activateSelected() {
        // Trigger action based on selected button
        guard let bridgeManager = bridgeManager else { return }
        
        switch selectedButton {
        case 0: // Bridge
            if !bridgeManager.isEngineConnected {
                bridgeManager.connectGameEngine()
            }
        case 1: // Engine
            if bridgeManager.isEngineConnected {
                bridgeManager.disconnectGameEngine()
            }
        case 2: // PCK
            if bridgeManager.isEngineConnected && !bridgeManager.isPCKLoaded {
                Task {
                    await bridgeManager.loadPCKBundle()
                }
            }
        case 3: // Controller
            if bridgeManager.controllerManager.isControllerConnected {
                bridgeManager.controllerManager.triggerHapticFeedback(1.0)
            }
        case 4: // Test Communication
            if bridgeManager.isEngineConnected {
                bridgeManager.sendTestMessage()
            }
        default:
            break
        }
        
        triggerActionFeedback()
        bridgeManager.addDebugMessage("🎮 Controller activated: Ring \(selectedButton)")
    }
    
    private func cancelAction() {
        bridgeManager?.addDebugMessage("🎮 Controller cancel action")
        triggerCancelFeedback()
    }
    
    private func toggleSidebar() {
        bridgeManager?.addDebugMessage("🎮 Controller sidebar toggle")
        triggerMenuFeedback()
        // This will be implemented to toggle sidebars
    }
    
    private func triggerSelectionFeedback() {
        controllerManager?.triggerHapticFeedback(0.3)
    }
    
    private func triggerActionFeedback() {
        controllerManager?.triggerHapticFeedback(0.7)
    }
    
    private func triggerCancelFeedback() {
        controllerManager?.triggerHapticFeedback(0.5)
    }
    
    private func triggerMenuFeedback() {
        controllerManager?.triggerHapticFeedback(1.0)
    }
}