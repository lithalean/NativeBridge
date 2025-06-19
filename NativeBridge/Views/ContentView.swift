//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//

import SwiftUI
import GameController

// MARK: - Controller UI Navigation Manager
@MainActor
class ControllerUIManager: ObservableObject {
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

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var pckManager = PCKManager()
    @State private var showingLeftSidebar = false
    @State private var showingRightSidebar = false
    
    // Controller UI Manager
    @StateObject private var controllerUIManager: ControllerUIManager
    
    init() {
        let bridgeManager = BridgeManager()
        _bridgeManager = StateObject(wrappedValue: bridgeManager)
        _pckManager = StateObject(wrappedValue: PCKManager())
        _controllerUIManager = StateObject(wrappedValue: ControllerUIManager(bridgeManager: bridgeManager))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Apple Car Dashboard Background
                AppleCarBackground()
                
                // Main Dashboard Area (Never pushed, sidebars float above)
                mainDashboard
                    .padding(.horizontal, GlassConstants.screenPadding)
                
                // Floating Left Sidebar (Mission Control) - Narrower for icons only
                if showingLeftSidebar {
                    HStack {
                        LeftMissionControlSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleLeftSidebar() }
                        )
                        .frame(width: 80) // Much narrower for icon-only
                        .padding(.leading, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 0)
                        Spacer()
                    }
                    .zIndex(100)
                }
                
                // Floating Right Sidebar (Debug Console) - Wider now
                if showingRightSidebar {
                    HStack {
                        Spacer()
                        RightDebuggerSidebar(
                            bridgeManager: bridgeManager,
                            onClose: { toggleRightSidebar() }
                        )
                        .frame(width: showingLeftSidebar ?
                               geometry.size.width - 120 : // Leave space for narrow left sidebar
                               geometry.size.width * 0.45)  // Wider when alone
                        .padding(.trailing, GlassConstants.mediumSpacing)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: -5, y: 0)
                    }
                    .zIndex(100)
                }
                
                // Floating Sidebar Controls
                VStack {
                    HStack {
                        // Left Sidebar Toggle (only show when sidebar is closed)
                        if !showingLeftSidebar {
                            Button(action: { toggleLeftSidebar() }) {
                                GlassIcon("sidebar.left", size: .title2)
                            }
                            .buttonStyle(GlassButtons.CircularGlassButton())
                            .padding(.leading, GlassConstants.screenPadding)
                            .padding(.top, 60)
                        }
                        
                        Spacer()
                        
                        // Right Sidebar Toggle (only show when sidebar is closed)
                        if !showingRightSidebar {
                            Button(action: { toggleRightSidebar() }) {
                                GlassIcon("terminal", size: .title2)
                            }
                            .buttonStyle(GlassButtons.CircularGlassButton())
                            .padding(.trailing, GlassConstants.screenPadding)
                            .padding(.top, 60)
                        }
                    }
                    Spacer()
                }
                .zIndex(1000)
            }
        }
        .glassSpring(trigger: showingLeftSidebar || showingRightSidebar)
        .environmentObject(controllerUIManager)
        .onAppear {
            controllerUIManager.setupControllerNavigation()
        }
    }
    
    // MARK: - Apple Car Dashboard
    private var mainDashboard: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.xlSpacing) {
                GlassSpacer(.vertical, size: 100)
                
                // Combined System Status & Health Rings
                AppleCarSystemStatusAndHealth(bridgeManager: bridgeManager)
                
                // REMOVED: ControllerStatusCard - now using ring in grid
                
                GlassSpacer(.vertical, size: GlassConstants.xlSpacing)
            }
        }
    }
    
    private func toggleLeftSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingLeftSidebar.toggle()
        }
    }
    
    private func toggleRightSidebar() {
        withAnimation(.spring(response: GlassConstants.springResponse, dampingFraction: GlassConstants.springDamping)) {
            showingRightSidebar.toggle()
        }
    }
}

// MARK: - Apple Car Background (Same as before)
struct AppleCarBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.05, green: 0.05, blue: 0.1),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            AppleCarGridPattern()
            AppleCarAmbientGlow()
        }
    }
}

struct AppleCarGridPattern: View {
    var body: some View {
        Canvas { context, size in
            let gridSpacing: CGFloat = 40
            
            context.stroke(
                Path { path in
                    for x in stride(from: 0, through: size.width, by: gridSpacing) {
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for y in stride(from: 0, through: size.height, by: gridSpacing) {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                    }
                },
                with: .color(.white.opacity(0.02)),
                lineWidth: 0.5
            )
        }
        .allowsHitTesting(false)
    }
}

struct AppleCarAmbientGlow: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.blue.opacity(0.1), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .position(x: 200, y: 100)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 600, height: 600)
                .position(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Combined System Status & Health
struct AppleCarSystemStatusAndHealth: View {
    @ObservedObject var bridgeManager: BridgeManager
    
    var body: some View {
        VStack(spacing: 30) {
            Text("System Performance Monitor")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Performance Grid - Device Adaptive
            PerformanceMetricsGrid(bridgeManager: bridgeManager)
        }
    }
}

struct PerformanceMetricsGrid: View {
    @ObservedObject var bridgeManager: BridgeManager
    @EnvironmentObject var controllerUIManager: ControllerUIManager
    
    var body: some View {
        let coreCount = ProcessInfo.processInfo.processorCount
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        
        LazyVGrid(columns: gridColumns(for: coreCount, isIPad: isIPad), spacing: 20) {
            // Core Performance Rings
            ForEach(0..<min(coreCount, isIPad ? 8 : 6), id: \.self) { core in
                CorePerformanceRing(
                    coreNumber: core,
                    usage: Double.random(in: 0.1...0.9), // Simulated - replace with real data
                    frequency: Double.random(in: 2.0...3.5) // GHz
                )
            }
            
            // System Metrics with Selection State
            SystemHealthRing(
                title: "Bridge",
                icon: "link.circle",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .cyan,
                isSelected: controllerUIManager.selectedButton == 0
            )
            
            SystemHealthRing(
                title: "Engine",
                icon: "engine.combustion",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .green,
                isSelected: controllerUIManager.selectedButton == 1
            )
            
            SystemHealthRing(
                title: "PCK",
                icon: "folder.badge.gearshape",
                isActive: bridgeManager.isPCKLoaded,
                progress: bridgeManager.isPCKLoaded ? 1.0 : 0.0,
                color: .blue,
                isSelected: controllerUIManager.selectedButton == 2
            )
            
            // Controller Health Ring with Selection
            SystemHealthRing(
                title: "Controller",
                icon: "gamecontroller.fill",
                isActive: bridgeManager.controllerManager.isControllerConnected,
                progress: bridgeManager.controllerManager.isControllerConnected ? 1.0 : 0.0,
                color: .mint,
                valueText: bridgeManager.controllerManager.isControllerConnected ?
                    "\(bridgeManager.controllerManager.connectedControllers.count)" : "0",
                isSelected: controllerUIManager.selectedButton == 3
            )
            
            SystemHealthRing(
                title: "Memory",
                icon: "memorychip",
                isActive: true,
                progress: min(bridgeManager.bridgeMetrics.memoryUsage / 100, 1.0),
                color: .orange,
                valueText: String(format: "%.0f MB", bridgeManager.bridgeMetrics.memoryUsage),
                isSelected: controllerUIManager.selectedButton == 4
            )
            
            SystemHealthRing(
                title: "GPU",
                icon: "cpu.fill",
                isActive: bridgeManager.isEngineConnected,
                progress: Double.random(in: 0.3...0.8), // Simulated GPU usage
                color: .purple,
                valueText: "Metal",
                isSelected: controllerUIManager.selectedButton == 5
            )
            
            SystemHealthRing(
                title: "Latency",
                icon: "wifi",
                isActive: bridgeManager.isEngineConnected,
                progress: max(0.0, 1.0 - (bridgeManager.bridgeMetrics.bridgeLatency / 20.0)),
                color: .indigo,
                valueText: String(format: "%.1f ms", bridgeManager.bridgeMetrics.bridgeLatency),
                isSelected: controllerUIManager.selectedButton == 6
            )
        }
    }
    
    private func gridColumns(for coreCount: Int, isIPad: Bool) -> [GridItem] {
        let columns = isIPad ? 6 : 4
        return Array(repeating: GridItem(.flexible()), count: columns)
    }
}

struct CorePerformanceRing: View {
    let coreNumber: Int
    let usage: Double
    let frequency: Double
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: usage)
                    .stroke(coreColor(for: usage), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: usage)
                
                VStack(spacing: 1) {
                    Text("C\(coreNumber)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(Int(usage * 100))%")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(String(format: "%.1f GHz", frequency))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    private func coreColor(for usage: Double) -> Color {
        switch usage {
        case 0.8...:
            return .red
        case 0.6...:
            return .orange
        case 0.4...:
            return .yellow
        default:
            return .green
        }
    }
}

struct SystemHealthRing: View {
    let title: String
    let icon: String
    let isActive: Bool
    let progress: Double
    let color: Color
    let valueText: String?
    let isSelected: Bool // NEW: Selection state for controller navigation
    
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
                
                // NEW: Selection ring animation
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
            
            // NEW: Enhanced text styling for selection
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

// MARK: - Floating Left Mission Control Sidebar (Icon-Only)
struct LeftMissionControlSidebar: View {
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
                LazyVStack(spacing: GlassConstants.smallSpacing) { // Tighter spacing
                    iconEngineControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    iconPCKManagement
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    // Controller Controls
                    iconControllerControls
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    iconTesting
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 4)
                    
                    // NEW: Detailed Controller Status for Sidebar
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
    
    // MARK: - Icon-Only Controls (Compact Apple Style)
    private var iconEngineControls: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
                icon: "play.fill",
                color: .green,
                isEnabled: !bridgeManager.isEngineConnected,
                action: { bridgeManager.connectGameEngine() }
            )
            
            BigIconButton(
                icon: "stop.fill",
                color: .red,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.disconnectGameEngine() }
            )
        }
    }
    
    private var iconPCKManagement: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
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
                BigIconButton(
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
    
    // Controller Controls Section
    private var iconControllerControls: some View {
        VStack(spacing: 4) {
            // Controller Detection Status
            BigIconButton(
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
                BigIconButton(
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
    
    private var iconTesting: some View {
        VStack(spacing: 4) { // Tighter spacing
            BigIconButton(
                icon: "antenna.radiowaves.left.and.right",
                color: .orange,
                isEnabled: bridgeManager.isEngineConnected,
                action: { bridgeManager.sendTestMessage() }
            )
            
            BigIconButton(
                icon: "checkmark.shield.fill",
                color: .cyan,
                isEnabled: bridgeManager.isPCKLoaded,
                action: { bridgeManager.testProjectAccess() }
            )
        }
    }
}

struct BigIconButton: View {
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GlassIcon(icon, color: isEnabled ? color : .gray, size: .title2) // Slightly smaller
                .frame(width: 44, height: 44) // More compact
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

struct IconOnlyButton: View {
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

struct CompactActionButton: View {
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

// MARK: - Floating Right Debugger Sidebar
struct RightDebuggerSidebar: View {
    @ObservedObject var bridgeManager: BridgeManager
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Debugger Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Debug Console")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Text("\(bridgeManager.debugMessages.count) messages")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        // Controller Status in Debug Header
                        if bridgeManager.controllerManager.isControllerConnected {
                            Text("• \(bridgeManager.controllerManager.connectedControllers.count) controller(s)")
                                .font(.caption2)
                                .foregroundColor(.mint)
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: { bridgeManager.clearDebugMessages() }) {
                        GlassIcon("trash", size: .caption)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                    
                    Button(action: onClose) {
                        GlassIcon("xmark.circle.fill", size: .body)
                    }
                    .buttonStyle(GlassButtons.CircularGlassButton())
                }
            }
            .padding(GlassConstants.smallSpacing)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Debugger Console
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(Array(bridgeManager.debugMessages.enumerated()), id: \.offset) { index, message in
                            DebuggerLogLine(
                                lineNumber: index + 1,
                                message: message,
                                messageType: getMessageType(message)
                            )
                            .id(index)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                }
                .onChange(of: bridgeManager.debugMessages.count) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(bridgeManager.debugMessages.count - 1, anchor: .bottom)
                    }
                }
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
    
    private func getMessageType(_ message: String) -> DebugMessageType {
        if message.contains("✅") { return .success }
        else if message.contains("❌") { return .error }
        else if message.contains("⚠️") { return .warning }
        else if message.contains("🔄") || message.contains("🔍") { return .info }
        else if message.contains("🎮") { return .controller }
        else { return .debug }
    }
}

enum DebugMessageType {
    case success, error, warning, info, debug, controller
    
    var color: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        case .info: return .blue
        case .controller: return .mint
        case .debug: return .secondary
        }
    }
    
    var prefix: String {
        switch self {
        case .success: return "✅"
        case .error: return "❌"
        case .warning: return "⚠️"
        case .info: return "ℹ️"
        case .controller: return "🎮"
        case .debug: return "🔧"
        }
    }
}

struct DebuggerLogLine: View {
    let lineNumber: Int
    let message: String
    let messageType: DebugMessageType
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // Line number
            Text(String(format: "%03d", lineNumber))
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(Color.secondary.opacity(0.7))
                .frame(width: 30, alignment: .trailing)
            
            // Message type indicator
            Text(messageType.prefix)
                .font(.caption2)
                .frame(width: 16, alignment: .center)
            
            // Message content
            Text(message)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(messageType.color)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 1)
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(messageType == .error ? Color.red.opacity(0.05) :
                      messageType == .warning ? Color.orange.opacity(0.05) :
                      messageType == .controller ? Color.mint.opacity(0.05) :
                      Color.clear)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
