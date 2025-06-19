//
//  GameControllerManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import Foundation
import GameController
import SwiftUI

@MainActor
class GameControllerManager: ObservableObject {
    // MARK: - Published Properties
    @Published var connectedControllers: [GCController] = []
    @Published var isControllerConnected: Bool = false
    @Published var primaryController: GCController?
    @Published var controllerBatteryLevel: Float = 1.0
    @Published var lastInputTime: Date = Date()
    @Published var inputEvents: [ControllerInputEvent] = []
    
    // MARK: - Controller Types
    enum ControllerType: String, CaseIterable {
        case xbox = "Xbox Controller"
        case playstation = "PlayStation Controller"
        case mfi = "MFi Controller"
        case unknown = "Unknown Controller"
        
        var icon: String {
            switch self {
            case .xbox: return "gamecontroller.fill"
            case .playstation: return "gamecontroller.fill"
            case .mfi: return "gamecontroller"
            case .unknown: return "questionmark.circle"
            }
        }
    }
    
    // MARK: - Input Event Structure
    struct ControllerInputEvent: Identifiable {
        let id = UUID()
        let timestamp: Date
        let type: InputType
        let value: Float
        let controllerName: String
        
        enum InputType: String {
            case buttonA = "A Button"
            case buttonB = "B Button"
            case buttonX = "X Button"
            case buttonY = "Y Button"
            case leftThumbstick = "Left Stick"
            case rightThumbstick = "Right Stick"
            case leftTrigger = "Left Trigger"
            case rightTrigger = "Right Trigger"
            case dpad = "D-Pad"
            case menu = "Menu Button"
        }
    }
    
    // MARK: - Enhanced Initialization with Discovery
    init() {
        print("🎮 GameControllerManager: Initializing...")
        setupControllerNotifications()
        checkForConnectedControllers()
        startControllerDiscovery()
    }
    
    // MARK: - Enhanced Controller Discovery
    private func startControllerDiscovery() {
        print("🎮 GameControllerManager: Starting controller discovery...")
        
        // Enable controller discovery
        GCController.startWirelessControllerDiscovery {
            Task { @MainActor in
                print("🎮 GameControllerManager: Wireless discovery completed")
                self.checkForConnectedControllers()
            }
        }
        
        // Check every 3 seconds for new controllers
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.checkForConnectedControllers()
            }
        }
    }
    
    // MARK: - Controller Setup
    private func setupControllerNotifications() {
        NotificationCenter.default.addObserver(
            forName: .GCControllerDidConnect,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let controller = notification.object as? GCController {
                Task { @MainActor in
                    self?.handleControllerConnected(controller)
                }
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: .GCControllerDidDisconnect,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let controller = notification.object as? GCController {
                Task { @MainActor in
                    self?.handleControllerDisconnected(controller)
                }
            }
        }
    }
    
    // MARK: - Enhanced Controller Detection with Detailed Logging
    func checkForConnectedControllers() {
        let previousCount = connectedControllers.count
        connectedControllers = GCController.controllers()
        
        print("🎮 GameControllerManager: Found \(connectedControllers.count) controllers")
        
        for (index, controller) in connectedControllers.enumerated() {
            print("🎮 Controller \(index): \(controller.vendorName ?? "Unknown")")
            print("🎮   - Product Category: \(controller.productCategory)")
            print("🎮   - Extended Gamepad: \(controller.extendedGamepad != nil)")
            print("🎮   - Micro Gamepad: \(controller.microGamepad != nil)")
            
            if let battery = controller.battery {
                print("🎮   - Battery: \(Int(battery.batteryLevel * 100))%")
            }
        }
        
        isControllerConnected = !connectedControllers.isEmpty
        primaryController = connectedControllers.first
        
        if let primary = primaryController {
            print("🎮 Setting up input handlers for primary controller...")
            setupControllerInputHandlers(primary)
        }
        
        // Update battery level if available
        if let battery = primaryController?.battery {
            controllerBatteryLevel = battery.batteryLevel
        }
        
        if previousCount != connectedControllers.count {
            print("🎮 Controller count changed: \(previousCount) → \(connectedControllers.count)")
        }
    }
    
    // MARK: - Controller Connection Handling
    private func handleControllerConnected(_ controller: GCController) {
        connectedControllers.append(controller)
        isControllerConnected = true
        
        if primaryController == nil {
            primaryController = controller
            setupControllerInputHandlers(controller)
        }
        
        // Update battery level if available
        if let battery = controller.battery {
            controllerBatteryLevel = battery.batteryLevel
        }
        
        print("🎮 Controller connected: \(controller.vendorName ?? "Unknown")")
    }
    
    private func handleControllerDisconnected(_ controller: GCController) {
        connectedControllers.removeAll { $0 == controller }
        isControllerConnected = !connectedControllers.isEmpty
        
        if controller == primaryController {
            primaryController = connectedControllers.first
            if let newPrimary = primaryController {
                setupControllerInputHandlers(newPrimary)
            }
        }
        
        print("🎮 Controller disconnected: \(controller.vendorName ?? "Unknown")")
    }
    
    // MARK: - Enhanced Input Handling
    private func setupControllerInputHandlers(_ controller: GCController) {
        print("🎮 Setting up input handlers for: \(controller.vendorName ?? "Unknown")")
        
        // Extended Gamepad (Most common)
        if let extendedGamepad = controller.extendedGamepad {
            print("🎮 Setting up Extended Gamepad handlers")
            setupExtendedGamepadHandlers(extendedGamepad, controller: controller)
        }
        // Micro Gamepad (Siri Remote, etc.)
        else if let microGamepad = controller.microGamepad {
            print("🎮 Setting up Micro Gamepad handlers")
            setupMicroGamepadHandlers(microGamepad, controller: controller)
        }
        else {
            print("🎮 ⚠️ Controller has no supported gamepad interface")
        }
    }
    
    // MARK: - Enhanced Extended Gamepad Handlers with Debugging
    private func setupExtendedGamepadHandlers(_ gamepad: GCExtendedGamepad, controller: GCController) {
        let controllerName = controller.vendorName ?? "Unknown Controller"
        print("🎮 Setting up extended gamepad handlers for: \(controllerName)")
        
        // Face Buttons with detailed logging
        gamepad.buttonA.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            print("🎮 Button A: value=\(value), pressed=\(pressed)")
            if pressed {
                self?.recordInputEvent(.buttonA, value: value, controller: controllerName)
                self?.sendInputToBridge("button_a", value: value)
            }
        }
        
        gamepad.buttonB.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            print("🎮 Button B: value=\(value), pressed=\(pressed)")
            if pressed {
                self?.recordInputEvent(.buttonB, value: value, controller: controllerName)
                self?.sendInputToBridge("button_b", value: value)
            }
        }
        
        gamepad.buttonX.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            print("🎮 Button X: value=\(value), pressed=\(pressed)")
            if pressed {
                self?.recordInputEvent(.buttonX, value: value, controller: controllerName)
                self?.sendInputToBridge("button_x", value: value)
            }
        }
        
        gamepad.buttonY.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            print("🎮 Button Y: value=\(value), pressed=\(pressed)")
            if pressed {
                self?.recordInputEvent(.buttonY, value: value, controller: controllerName)
                self?.sendInputToBridge("button_y", value: value)
            }
        }
        
        // Thumbsticks with dead zone and logging
        gamepad.leftThumbstick.valueChangedHandler = { [weak self] (thumbstick: GCControllerDirectionPad, xValue: Float, yValue: Float) in
            let magnitude = sqrt(xValue*xValue + yValue*yValue)
            if magnitude > 0.1 { // Dead zone
                print("🎮 Left Stick: x=\(xValue), y=\(yValue)")
                self?.recordInputEvent(.leftThumbstick, value: magnitude, controller: controllerName)
                self?.sendInputToBridge("left_stick", x: xValue, y: yValue)
            }
        }
        
        gamepad.rightThumbstick.valueChangedHandler = { [weak self] (thumbstick: GCControllerDirectionPad, xValue: Float, yValue: Float) in
            let magnitude = sqrt(xValue*xValue + yValue*yValue)
            if magnitude > 0.1 { // Dead zone
                print("🎮 Right Stick: x=\(xValue), y=\(yValue)")
                self?.recordInputEvent(.rightThumbstick, value: magnitude, controller: controllerName)
                self?.sendInputToBridge("right_stick", x: xValue, y: yValue)
            }
        }
        
        // Triggers with logging
        gamepad.leftTrigger.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            if value > 0.1 {
                print("🎮 Left Trigger: \(value)")
                self?.recordInputEvent(.leftTrigger, value: value, controller: controllerName)
                self?.sendInputToBridge("left_trigger", value: value)
            }
        }
        
        gamepad.rightTrigger.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            if value > 0.1 {
                print("🎮 Right Trigger: \(value)")
                self?.recordInputEvent(.rightTrigger, value: value, controller: controllerName)
                self?.sendInputToBridge("right_trigger", value: value)
            }
        }
        
        // D-Pad with logging
        gamepad.dpad.valueChangedHandler = { [weak self] (dpad: GCControllerDirectionPad, xValue: Float, yValue: Float) in
            if abs(xValue) > 0.1 || abs(yValue) > 0.1 {
                print("🎮 D-Pad: x=\(xValue), y=\(yValue)")
                self?.recordInputEvent(.dpad, value: sqrt(xValue*xValue + yValue*yValue), controller: controllerName)
                self?.sendInputToBridge("dpad", x: xValue, y: yValue)
            }
        }
        
        // Menu Button with logging
        gamepad.buttonMenu.valueChangedHandler = { [weak self] (button: GCControllerButtonInput, value: Float, pressed: Bool) in
            print("🎮 Menu Button: value=\(value), pressed=\(pressed)")
            if pressed {
                self?.recordInputEvent(.menu, value: value, controller: controllerName)
                self?.sendInputToBridge("menu_button", value: value)
            }
        }
        
        print("🎮 ✅ Extended gamepad handlers setup complete")
    }
    
    private func setupMicroGamepadHandlers(_ gamepad: GCMicroGamepad, controller: GCController) {
        let controllerName = controller.vendorName ?? "Micro Controller"
        
        gamepad.buttonA.valueChangedHandler = { [weak self] _, value, pressed in
            if pressed {
                self?.recordInputEvent(.buttonA, value: value, controller: controllerName)
                self?.sendInputToBridge("button_a", value: value)
            }
        }
        
        gamepad.buttonX.valueChangedHandler = { [weak self] _, value, pressed in
            if pressed {
                self?.recordInputEvent(.buttonX, value: value, controller: controllerName)
                self?.sendInputToBridge("button_x", value: value)
            }
        }
        
        gamepad.dpad.valueChangedHandler = { [weak self] _, xValue, yValue in
            self?.recordInputEvent(.dpad, value: sqrt(xValue*xValue + yValue*yValue), controller: controllerName)
            self?.sendInputToBridge("dpad", x: xValue, y: yValue)
        }
    }
    
    // MARK: - Bridge Integration
    private func sendInputToBridge(_ action: String, value: Float) {
        // Send single value input to bridge
        // This will be integrated with your existing GodotBridge
        print("🎮 Bridge Input: \(action) = \(value)")
        
        // TODO: Integrate with GodotBridge.swift
        // GodotBridge.sendControllerInput(action, value)
    }
    
    private func sendInputToBridge(_ action: String, x: Float, y: Float) {
        // Send coordinate input to bridge
        print("🎮 Bridge Input: \(action) = (\(x), \(y))")
        
        // TODO: Integrate with GodotBridge.swift
        // GodotBridge.sendControllerInput(action, x, y)
    }
    
    // MARK: - Event Recording
    private func recordInputEvent(_ type: ControllerInputEvent.InputType, value: Float, controller: String) {
        lastInputTime = Date()
        
        let event = ControllerInputEvent(
            timestamp: Date(),
            type: type,
            value: value,
            controllerName: controller
        )
        
        inputEvents.append(event)
        
        // Keep only last 50 events for performance
        if inputEvents.count > 50 {
            inputEvents.removeFirst(inputEvents.count - 50)
        }
    }
    
    // MARK: - Controller Info
    func getControllerType(_ controller: GCController) -> ControllerType {
        guard let vendorName = controller.vendorName?.lowercased() else {
            return .unknown
        }
        
        if vendorName.contains("xbox") {
            return .xbox
        } else if vendorName.contains("playstation") || vendorName.contains("dualshock") || vendorName.contains("dualsense") {
            return .playstation
        } else if controller.extendedGamepad != nil || controller.microGamepad != nil {
            return .mfi
        } else {
            return .unknown
        }
    }
    
    func getControllerName(_ controller: GCController) -> String {
        return controller.vendorName ?? "Unknown Controller"
    }
    
    func getControllerBatteryInfo(_ controller: GCController) -> (level: Float, state: String) {
        guard let battery = controller.battery else {
            return (1.0, "Unknown")
        }
        
        let stateString: String
        switch battery.batteryState {
        case .unknown:
            stateString = "Unknown"
        case .discharging:
            stateString = "Discharging"
        case .charging:
            stateString = "Charging"
        case .full:
            stateString = "Full"
        @unknown default:
            stateString = "Unknown"
        }
        
        return (battery.batteryLevel, stateString)
    }
    
    // MARK: - Haptic Feedback
    func triggerHapticFeedback(_ intensity: Float = 1.0) {
        guard primaryController != nil else { return }
        
        // Use UIImpactFeedbackGenerator for iOS haptics
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred(intensity: CGFloat(intensity))
        
        print("🎮 Haptic feedback triggered with intensity: \(intensity)")
    }
    
    // MARK: - Debug Methods
    func forceControllerScan() {
        print("🎮 Forcing controller scan...")
        checkForConnectedControllers()
    }
    
    func printDebugInfo() {
        print("🎮 === CONTROLLER DEBUG INFO ===")
        print("🎮 System Controllers: \(GCController.controllers().count)")
        print("🎮 Manager Controllers: \(connectedControllers.count)")
        print("🎮 Is Connected: \(isControllerConnected)")
        print("🎮 Primary Controller: \(primaryController?.vendorName ?? "None")")
        
        for (index, controller) in GCController.controllers().enumerated() {
            print("🎮 System Controller \(index):")
            print("🎮   - Name: \(controller.vendorName ?? "Unknown")")
            print("🎮   - Category: \(controller.productCategory)")
            print("🎮   - Extended: \(controller.extendedGamepad != nil)")
            print("🎮   - Micro: \(controller.microGamepad != nil)")
        }
        print("🎮 === END DEBUG INFO ===")
    }
    
    // MARK: - Cleanup
    deinit {
        NotificationCenter.default.removeObserver(self)
        GCController.stopWirelessControllerDiscovery()
    }
}
