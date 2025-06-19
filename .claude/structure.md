# NativeBridge Project Structure
*AI-focused project reference*

> **Last Updated**: June 19, 2025  
> **Location**: `/.claude/structure.md`
> **Status**: System Dashboard Architecture ✅ | Controller Navigation ✅ | Dual Floating Sidebars ✅

## 📁 Project Overview
```
NativeBridge/
├── .claude/                    # AI collaboration docs
├── NativeBridge/              # Main app
├── NativeBridge.xcodeproj     # Xcode project
├── libgodot.xcframework/      # Custom engine bridge
├── GameContent/game.pck       # Test PCK (Bundle resource)
└── ReadMe.md                  # Documentation
```

## 🏗️ Enhanced App Structure (Modularized)
```
NativeBridge/NativeBridge/
├── Assets.xcassets            # Resources
├── NativeBridgeApp.swift      # App entry point
├── Item.swift                 # SwiftData model
│
├── Views/
│   ├── ContentView.swift      # Main orchestrator (slim ~100 lines)
│   ├── Dashboard/
│   │   ├── SystemDashboard.swift        # Main dashboard component
│   │   ├── DashboardBackground.swift    # Background effects
│   │   └── MetricsGrid.swift            # Performance metrics grid
│   ├── Metrics/
│   │   ├── ProcessorCoreRing.swift      # CPU core visualization
│   │   └── MetricRing.swift             # Generic metric ring
│   ├── Controls/
│   │   ├── ControlSidebar.swift         # Left control panel
│   │   ├── DebugConsole.swift           # Right debug console
│   │   └── Components/
│   │       └── ControlButtons.swift     # PrimaryActionButton, IconButton, CompactButton
│   ├── Console/
│   │   ├── ConsoleMessageType.swift     # Message categorization
│   │   └── ConsoleLogEntry.swift        # Console line component
│   └── Navigation/
│       └── ControllerNavigationManager.swift # Controller UI navigation
│
├── Managers/                  # Enhanced Bridge System
│   ├── BridgeManager.swift    # Main orchestrator (@MainActor, enhanced with controller)
│   ├── GodotEngineManager.swift # Engine operations (14KB)
│   ├── PCKManager.swift       # Bundle PCK detection (9KB)
│   ├── GodotBridge.swift      # Swift ↔ libgodot interface
│   └── GameControllerManager.swift # Controller detection & input handling
│
└── Styles/GlassComponents/    # ATOMIC GLASS DESIGN SYSTEM (50+ components)
    ├── Foundation/            # Design tokens
    │   ├── GlassConstants.swift     # Spacing, animation configs
    │   ├── GlassColors.swift        # Color palette
    │   ├── TrendDirection.swift     # Enum: .up/.down for metrics
    │   ├── SidebarFeature.swift     # Data structure
    │   └── ComponentStatus.swift    # Status data structure
    │
    ├── Atomic/                # Basic components
    │   ├── GlassIcon.swift          # Icon system with color/size
    │   ├── GlassStatusIndicator.swift   # Animated status dots
    │   ├── GlassCircularProgress.swift  # Progress rings
    │   ├── GlassSpacer.swift        # Layout spacing
    │   ├── Materials/               # Glass background effects
    │   ├── Typography/              # Text styling
    │   └── Effects/                 # Animation presets
    │
    ├── Molecular/             # Compound components
    │   ├── Buttons/
    │   │   ├── AdvancedButtons.swift    # GlassButtons library (5 styles)
    │   │   └── GlassActionButton.swift  # Single action button
    │   ├── GlassContentSection.swift   # Content layouts
    │   ├── GlassCardHeader.swift       # Card headers
    │   └── GlassProgressSection.swift  # Progress displays
    │
    ├── Organism/              # Complex components
    │   ├── ModernActionCard.swift      # Action buttons with glass
    │   ├── ModernMetricCard.swift      # Metrics with trend indicators
    │   ├── ModernStatusCard.swift      # Status displays
    │   ├── PhaseProgressCard.swift     # Development phase tracking
    │   ├── ModernSidebarPhaseRow.swift # Sidebar feature rows
    │   ├── ControllerStatusCard.swift  # Controller information display
    │   └── DetailedControllerStatus.swift # Detailed controller info (renamed to ControllerStatusView in use)
    │
    ├── Template/              # Layout templates
    │   ├── DebugConsoleContent.swift   # Console layout
    │   ├── DebugConsoleHeader.swift    # Console header
    │   ├── DebugConsoleMessage.swift   # Message formatting
    │   ├── GlassSectionHeader.swift    # Section headers
    │   ├── FeaturesListContainer.swift # Feature lists
    │   └── DevelopmentControlPanel.swift # Control layouts
    │
    ├── Pages/                 # Full page components
    │   ├── ModernFloatingSidebar.swift # Complete sidebar (legacy)
    │   └── GlassDebugConsole.swift     # Complete console (available)
    │
    └── Extensions/            # SwiftUI modifiers
        ├── View+GlassMaterials.swift   # .cardGlass(), .glassSpring() ✅ USED
        ├── View+Effects.swift          # Animation modifiers
        └── View+GlassTypography.swift  # Text styling
```

## 🎯 Current Implementation (System Dashboard Architecture)

### ContentView.swift Architecture (Modularized)
```swift
ContentView (Slim Orchestrator ~100 lines)
├── DashboardBackground                  # Grid pattern + ambient glow effects
│   ├── GridPattern                     # 40px grid with subtle white lines
│   └── AmbientGlow                     # Blue/purple radial gradient orbs
│
├── SystemDashboard                     # Main dashboard ScrollView
│   └── SystemStatusView                # Container for metrics
│       └── MetricsGrid                 # Adaptive performance monitoring
│           ├── ProcessorCoreRing (x6-8) # CPU core utilization rings
│           └── MetricRing (x7)         # System status rings with selection
│               ├── Bridge ring         # Bridge connection status
│               ├── Engine ring         # Engine status
│               ├── PCK ring            # PCK loading status
│               ├── Controller ring     # Controller connection status
│               ├── Memory ring         # Memory usage
│               ├── GPU ring            # GPU status
│               └── Latency ring        # Bridge latency
│
├── ControlSidebar (80px)               # Icon-only control panel
│   ├── Engine controls                 # Play/stop with status awareness
│   ├── PCK management                  # Load/inspect with conditional visibility
│   ├── Controller controls             # Status + haptic test buttons
│   ├── Testing controls                # Communication + access tests
│   └── ControllerStatusView            # Controller info card
│
├── DebugConsole (45% width)            # Professional debug console
│   ├── Debug header                    # Message count + controller status
│   ├── Live scrolling console          # Color-coded debug messages
│   ├── ConsoleLogEntry components      # Individual message formatting
│   └── Debug controls                  # Clear + controller diagnostics
│
├── ControllerNavigationManager         # Controller navigation system
│   ├── Ring selection logic            # Navigate between metric rings
│   ├── Haptic feedback integration     # Different intensities per action
│   ├── Action mapping                  # D-pad, A/B buttons, Menu
│   └── Debug logging                   # All controller interactions
│
└── Floating toggle controls            # Sidebar show/hide buttons

// Architecture Evolution:
- From: 900-line monolithic implementation
- To: Modularized system with 11 separate components
- Components: 15+ specialized components properly organized
- Functionality: Professional system monitoring interface
```

### Layout Specifications (Enhanced)
```swift
// Sophisticated Dual Sidebar System
ControlSidebar: 80px icon-only width
DebugConsole: 45% screen width (adaptive with control sidebar)
MetricsGrid: Adaptive 4-6 columns (iPhone vs iPad)
Ring Selection: Pulsing white outline with 0.6s animation
Controller Navigation: 7 navigable metric rings

// Dashboard Background Effects
Grid Pattern: 40px spacing with 0.02 opacity white lines
Ambient Glow: Blue (200px radius) + Purple (300px radius) gradients
Material System: .ultraThinMaterial for sidebars + glass overlays

// Spacing (Enhanced Foundation Design Tokens)
Icon spacing: GlassConstants.smallSpacing (8px) for compact controls
Card spacing: GlassConstants.mediumSpacing (16px) for content
Screen margins: GlassConstants.screenPadding (20px) for layout
Section spacing: GlassConstants.xlSpacing (32px) for major divisions
Ring spacing: 20px grid spacing for performance visualization
```

## 🔧 Enhanced Tech Stack

### Dependencies
- **iOS 18.0+** deployment target
- **Swift 6.0** language mode (with concurrency compliance)
- **SwiftUI + SwiftData** (Foundation, SwiftUI only)
- **GameController Framework** for controller support
- **No external packages** - Pure Apple ecosystem

### Enhanced Bridge Integration
```swift
// Manager Hierarchy (Enhanced)
BridgeManager (@MainActor)
├── GodotEngineManager          # Engine lifecycle
├── PCKManager                  # Bundle resource detection
├── GodotBridge                 # Native interface
└── GameControllerManager       # Controller detection & input handling

// Extended Properties (Integrated with System Dashboard)
BridgeManager.isEngineConnected: Bool       # → MetricRing status
BridgeManager.isPCKLoaded: Bool             # → MetricRing progress
BridgeManager.debugMessages: [String]       # → DebugConsole content
BridgeManager.bridgeMetrics: BridgeMetrics  # → Performance ring data
BridgeManager.controllerManager             # → Controller system integration

// Controller Integration
GameControllerManager.isControllerConnected: Bool    # → Controller ring status
GameControllerManager.connectedControllers: [GCController] # → Controller count
GameControllerManager.inputEvents: [ControllerInputEvent]  # → Debug logging
GameControllerManager.primaryController: GCController?     # → Primary device
```

### Enhanced Performance Monitoring
```swift
// Real System Data (Actively Used in System Dashboard)
ProcessInfo.processInfo.processorCount  # → ProcessorCoreRing count (6-8 rings)
UIDevice.current.userInterfaceIdiom    # → Adaptive grid layout (4-6 columns)
mach_task_basic_info                    # → Memory ring real-time data
Timer-based metrics (1.0s interval)    # → All ring progress updates
GCController.controllers()              # → Controller detection every 3s
Controller battery monitoring           # → Battery level in detailed view
```

## 🎮 Controller System Integration

### Controller Components
```swift
// From Views/Navigation
ControllerNavigationManager             # UI navigation with controller input

// From Managers
GameControllerManager                   # Controller detection & input handling

// From Organism (in GlassComponents)
ControllerStatusCard                    # Controller information display
DetailedControllerStatus               # Detailed controller info (used as ControllerStatusView)

// Controller Navigation System
Ring Selection: selectedButton (0-6)   # Navigate between MetricRing components
Haptic Feedback: UIImpactFeedbackGenerator # Different intensities per action
Input Logging: All controller events   # Recorded with timestamps + controller names
Debug Integration: Controller messages # Color-coded in debug console (mint color)
```

### Controller Support Matrix
```swift
// Supported Controllers
Xbox Wireless Controller        # Extended gamepad with full button mapping
PlayStation DualShock 4/5       # Extended gamepad with full button mapping  
PlayStation DualSense          # Extended gamepad with full button mapping
MFi Controllers (Razer Kishi)  # Extended gamepad with full button mapping
Siri Remote                    # Micro gamepad with limited button mapping

// Input Mapping
D-Pad Left/Right: Navigate between metric rings (selectedButton 0-6)
A Button: Activate selected ring (connect engine, load PCK, test haptics)
B Button: Cancel action with haptic feedback
Menu Button: Toggle sidebars (prepared for implementation)
Left/Right Thumbsticks: Logged but not UI-mapped (available for Phase 2)
Triggers: Logged but not UI-mapped (available for Phase 2)
```

## 🎨 Active Component Usage (Renamed)

### Currently Used Components (15+ Enhanced System)
```swift
// Dashboard Background System
DashboardBackground()                    # Grid + ambient glow effects
GridPattern()                           # 40px grid with subtle lines
AmbientGlow()                           # Blue/purple gradient orbs

// Performance Visualization
ProcessorCoreRing(coreNumber, usage, frequency)  # CPU core rings (6-8)
MetricRing(title, icon, isActive, progress, color, valueText, isSelected) # System rings (7)

// Dual Sidebar System
ControlSidebar(bridgeManager, onClose)          # 80px icon-only controls
DebugConsole(bridgeManager, onClose)            # 45% professional console
PrimaryActionButton(icon, color, isEnabled, action) # Primary sidebar buttons

// Console Components  
ConsoleLogEntry(lineNumber, message, messageType)   # Color-coded console lines
ConsoleMessageType enum                             # success, error, warning, info, controller, debug

// Controller System
ControllerStatusView(controllerManager)         # Controller info for sidebars
ControllerNavigationManager                     # Navigation system (not visual component)

// Foundation & Utilities
GlassIcon(icon, size)                          # Consistent iconography
GlassButtons.CircularGlassButton()             # Floating toggle buttons
.glassSpring(trigger: showingSidebar)          # Smooth sidebar animations
```

### Available for Phase 2 (35+ Premium Components Still Ready)
```swift
// High-Impact Additions Ready:
ModernMetricCard        # Performance metrics grid enhancement
ModernStatusCard        # System health monitoring enhancement
ModernActionCard        # Bridge operation controls
GlassDebugConsole       # Enhanced debugging interface (alternative to current)
GlassSectionHeader      # Content organization
LiquidGlassMaterial     # Enhanced backgrounds for spatial computing
FloatingGlassMaterial   # Premium spatial sidebar materials
```

## 🔍 File Locations & Sizes

### Core Files (Modularized)
```
Views/ContentView.swift                  # Slim orchestrator (~100 lines)
Views/Dashboard/SystemDashboard.swift    # Main dashboard component
Views/Dashboard/DashboardBackground.swift # Background effects
Views/Dashboard/MetricsGrid.swift        # Metrics grid layout
Views/Metrics/ProcessorCoreRing.swift    # CPU visualization
Views/Metrics/MetricRing.swift           # Generic metric ring
Views/Controls/ControlSidebar.swift      # Control panel
Views/Controls/DebugConsole.swift        # Debug console
Views/Controls/Components/ControlButtons.swift # Button components
Views/Console/ConsoleMessageType.swift   # Message types
Views/Console/ConsoleLogEntry.swift      # Console lines
Views/Navigation/ControllerNavigationManager.swift # Controller navigation
```

### Manager Files
```
Managers/BridgeManager.swift             # Enhanced with controller integration
Managers/GodotEngineManager.swift        # 14,085 bytes (Engine operations)
Managers/PCKManager.swift                # 9,250 bytes (Bundle detection)
Managers/GameControllerManager.swift     # Complete controller system with debug logging
```

### Premium Component Library (Unchanged Structure)
```
Styles/GlassComponents/     # 50+ premium components organized by atomic design
├── Foundation/             # 5 files (design tokens, data structures)
├── Atomic/                 # 10+ files (basic UI elements)
├── Molecular/              # 8+ files (compound components)
├── Organism/               # 12+ files (complex components) +2 controller components
├── Template/               # 6+ files (layout templates)
├── Pages/                  # 2 files (complete layouts)
└── Extensions/             # 3 files (SwiftUI modifiers)
```

### Bundle Resources (Unchanged)
```
GameContent/game.pck        # Test PCK file (29.43MB)
libgodot.xcframework/       # Custom engine binary
Assets.xcassets             # iOS app resources
```

## 🚀 Enhanced Architecture Benefits

### Current Achievements (Significantly Enhanced)
- **System dashboard** professional monitoring interface
- **Modular architecture** 11 separate components vs 900-line monolith
- **Dual sidebar system** optimizing screen real estate + workflow
- **Full controller navigation** with Xbox/PlayStation/MFi support + haptic feedback
- **Real-time performance monitoring** with adaptive core detection + system health
- **Professional debug environment** with color-coded console + live updates

### Controller System Benefits
- **Universal controller support** Xbox, PlayStation, MFi with automatic detection
- **Professional input handling** with dead zones, proper type annotations, comprehensive logging
- **UI navigation integration** ring selection with visual feedback + haptic confirmation
- **Debug integration** controller events color-coded in professional debug console
- **Battery monitoring** controller power levels in detailed sidebar view
- **Extensible input system** ready for Phase 2 game integration

## 🎯 Enhanced Phase 2 Integration Strategy

### Week-by-Week Controller Integration Plan
```swift
// Week 1: Direct Controller → Godot Bridge Integration
+ Controller input forwarding to GodotBridge methods
+ Game-specific haptic feedback patterns from engine events
+ Real-time controller state → engine communication

// Week 2: Enhanced Debug + Performance Integration  
+ Controller performance metrics in rings (input latency, poll rate)
+ Game state visualization in additional metric rings
+ Engine runtime logs → debug console with game message types

// Week 3: Spatial Computing Material Upgrades
+ .liquidGlassCard() enhanced depth materials for rings
+ .floatingGlassMaterial() for spatial sidebar rendering
+ .glassDepthLayer() for true spatial depth perception

// Week 4: Scene Loading + Navigation Integration
+ Controller navigation → 3D scene selection in Phase 2
+ Asset loading progress → additional ring visualizations  
+ Runtime scene switching → controller-driven workflow

// Week 5: Production Optimization + Spatial Computing
+ Performance profiling + memory optimization
+ Battery usage optimization for extended controller sessions
+ Spatial computing feature preparation + testing
```

## 🔬 Enhanced Development Workflow

### Current Workflow (Professional Development Environment)
```
1. Open NativeBridge.xcodeproj
2. ContentView.swift - Slim orchestrator with modular components
3. Run on Simulator/Device - Professional system monitoring interface
4. ControlSidebar - Icon-only bridge operations
5. DebugConsole - Professional debug console with controller status
6. Controller testing - Connect Xbox/PlayStation/MFi controllers
7. Debug with controller diagnostics - Real-time input logging + haptic testing
```

### Component Development Pattern
```swift
// Each component follows:
1. Single responsibility principle
2. Clear Apple-style naming
3. Proper file organization (Views/subfolder/Component.swift)
4. Integration with manager system
5. Use of Foundation design tokens
6. Support for controller navigation where applicable
```

## 📊 Enhanced Success Metrics

### Code Quality Achieved (Significantly Enhanced)
- **Modular architecture** 11 components vs 900-line monolith ✅
- **Apple naming conventions** professional component names ✅
- **System dashboard** professional monitoring interface ✅
- **Dual sidebar system** optimized workflow + screen real estate ✅
- **Controller navigation** full Xbox/PlayStation/MFi support ✅
- **Professional debug environment** color-coded console + comprehensive logging ✅

### User Experience Achieved (Professional Grade)
- **Professional appearance** system monitoring aesthetic ✅
- **Intuitive controller navigation** ring selection + haptic feedback ✅
- **Real-time performance monitoring** adaptive ring system + live metrics ✅
- **Professional debug tools** live console + controller diagnostics ✅
- **Responsive design** adapting to iPhone/iPad + controller types ✅
- **Smooth animations** spring physics + selection feedback ✅

### Developer Experience Achieved (Enhanced Professional Tools)
- **Professional development environment** live debug console + controller testing ✅
- **Comprehensive logging system** all interactions tracked + color-coded ✅
- **Easy controller testing** input verification + haptic feedback testing ✅
- **Clean architecture patterns** modular components + atomic design ✅
- **Extensible foundation** ready for Phase 2 runtime + spatial computing ✅
- **Controller abstraction layer** supporting multiple controller types seamlessly ✅

## 📦 Component Naming Reference

### Renamed Components
- AppleCarDashboard → SystemDashboard
- AppleCarBackground → DashboardBackground
- AppleCarGridPattern → GridPattern
- AppleCarAmbientGlow → AmbientGlow
- AppleCarSystemStatusAndHealth → SystemStatusView
- PerformanceMetricsGrid → MetricsGrid
- CorePerformanceRing → ProcessorCoreRing
- SystemHealthRing → MetricRing
- LeftMissionControlSidebar → ControlSidebar
- RightDebuggerSidebar → DebugConsole
- BigIconButton → PrimaryActionButton
- DetailedControllerStatus → ControllerStatusView (in use)
- DebuggerLogLine → ConsoleLogEntry
- DebugMessageType → ConsoleMessageType
- ControllerUIManager → ControllerNavigationManager

---
*System Dashboard Architecture: Sophisticated dual sidebars + controller navigation + performance monitoring*  
*Modularized: 11 separate components with proper Apple naming conventions*  
*Next: Phase 2 runtime integration with enhanced spatial computing materials + direct controller → Godot bridge*