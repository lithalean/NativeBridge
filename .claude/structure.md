# NativeBridge Project Structure
*AI-focused project reference*

> **Last Updated**: June 19, 2025  
> **Location**: `/.claude/structure.md`
> **Status**: Apple Car Dashboard Architecture ✅ | Controller Navigation ✅ | Dual Floating Sidebars ✅

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

## 🏗️ Enhanced App Structure
```
NativeBridge/NativeBridge/
├── Assets.xcassets            # Resources
├── NativeBridgeApp.swift      # App entry point
├── Item.swift                 # SwiftData model
│
├── Views/
│   └── ContentView.swift      # Apple Car Dashboard Architecture (Sophisticated)
│
├── Managers/                  # Enhanced Bridge System
│   ├── BridgeManager.swift    # Main orchestrator (@MainActor, enhanced with controller)
│   ├── GodotEngineManager.swift # Engine operations (14KB)
│   ├── PCKManager.swift       # Bundle PCK detection (9KB)
│   ├── GodotBridge.swift      # Swift ↔ libgodot interface
│   └── GameControllerManager.swift # 🆕 Controller detection & input handling
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
	│   ├── ControllerStatusCard.swift  # 🆕 Controller information display
	│   └── DetailedControllerStatus.swift # 🆕 Detailed controller info for sidebars
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

## 🎯 Current Implementation (Apple Car Dashboard Architecture)

### ContentView.swift Architecture (Sophisticated Multi-Component System)
```swift
ContentView (Apple Car Dashboard Design)
├── AppleCarBackground                    # Grid pattern + ambient glow effects
│   ├── AppleCarGridPattern              # 40px grid with subtle white lines
│   └── AppleCarAmbientGlow              # Blue/purple radial gradient orbs
│
├── PerformanceMetricsGrid               # Adaptive performance monitoring
│   ├── CorePerformanceRing (x6-8)      # CPU core utilization rings
│   └── SystemHealthRing (x7)           # System status rings with selection
│       ├── Bridge ring                 # Bridge connection status
│       ├── Engine ring                 # Engine status
│       ├── PCK ring                    # PCK loading status
│       ├── Controller ring             # 🆕 Controller connection status
│       ├── Memory ring                 # Memory usage
│       ├── GPU ring                    # GPU status
│       └── Latency ring                # Bridge latency
│
├── LeftMissionControlSidebar (80px)     # Icon-only mission control
│   ├── Engine controls                 # Play/stop with status awareness
│   ├── PCK management                  # Load/inspect with conditional visibility
│   ├── Controller controls             # 🆕 Status + haptic test buttons
│   ├── Testing controls                # Communication + access tests
│   └── DetailedControllerStatus        # 🆕 Controller info card
│
├── RightDebuggerSidebar (45% width)    # Professional debug console
│   ├── Debug header                    # Message count + controller status
│   ├── Live scrolling console          # Color-coded debug messages
│   ├── DebuggerLogLine components      # Individual message formatting
│   └── Debug controls                  # Clear + controller diagnostics
│
├── ControllerUIManager                  # 🆕 Controller navigation system
│   ├── Ring selection logic            # Navigate between system rings
│   ├── Haptic feedback integration     # Different intensities per action
│   ├── Action mapping                  # D-pad, A/B buttons, Menu
│   └── Debug logging                   # All controller interactions
│
└── Floating toggle controls            # Sidebar show/hide buttons

// Architecture Evolution:
- From: 80-line simple implementation
- To: Sophisticated Apple Car dashboard with dual sidebars + controller navigation
- Components: 15+ specialized components vs 5 simple components
- Functionality: Professional automotive-grade interface
```

### Layout Specifications (Enhanced)
```swift
// Sophisticated Dual Sidebar System
LeftMissionControlSidebar: 80px icon-only width
RightDebuggerSidebar: 45% screen width (adaptive with left sidebar)
Performance Grid: Adaptive 4-6 columns (iPhone vs iPad)
Ring Selection: Pulsing white outline with 0.6s animation
Controller Navigation: 7 navigable system rings

// Apple Car Background Effects
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
- **GameController Framework** 🆕 for controller support
- **No external packages** - Pure Apple ecosystem

### Enhanced Bridge Integration
```swift
// Manager Hierarchy (Enhanced)
BridgeManager (@MainActor)
├── GodotEngineManager          # Engine lifecycle
├── PCKManager                  # Bundle resource detection
├── GodotBridge                 # Native interface
└── GameControllerManager       # 🆕 Controller detection & input handling

// Extended Properties (Integrated with Apple Car Dashboard)
BridgeManager.isEngineConnected: Bool       # → SystemHealthRing status
BridgeManager.isPCKLoaded: Bool             # → SystemHealthRing progress
BridgeManager.debugMessages: [String]      # → RightDebuggerSidebar content
BridgeManager.bridgeMetrics: BridgeMetrics  # → Performance ring data
BridgeManager.controllerManager             # 🆕 → Controller system integration

// Controller Integration
GameControllerManager.isControllerConnected: Bool    # → Controller ring status
GameControllerManager.connectedControllers: [GCController] # → Controller count
GameControllerManager.inputEvents: [ControllerInputEvent]  # → Debug logging
GameControllerManager.primaryController: GCController?     # → Primary device
```

### Enhanced Performance Monitoring
```swift
// Real System Data (Actively Used in Apple Car Dashboard)
ProcessInfo.processInfo.processorCount  # → CorePerformanceRing count (6-8 rings)
UIDevice.current.userInterfaceIdiom    # → Adaptive grid layout (4-6 columns)
mach_task_basic_info                    # → Memory ring real-time data
Timer-based metrics (1.0s interval)    # → All ring progress updates
GCController.controllers()              # 🆕 → Controller detection every 3s
Controller battery monitoring           # 🆕 → Battery level in detailed view
```

## 🎮 Controller System Integration

### New Controller Components (Added)
```swift
// From Managers
GameControllerManager                   # Controller detection & input handling
ControllerUIManager                     # UI navigation with controller input

// From Organism
ControllerStatusCard                    # Controller information display (not used in main view)
DetailedControllerStatus               # Detailed controller info for sidebars

// Controller Navigation System
Ring Selection: selectedButton (0-6)   # Navigate between SystemHealthRing components
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
D-Pad Left/Right: Navigate between system rings (selectedButton 0-6)
A Button: Activate selected ring (connect engine, load PCK, test haptics)
B Button: Cancel action with haptic feedback
Menu Button: Toggle sidebars (prepared for implementation)
Left/Right Thumbsticks: Logged but not UI-mapped (available for Phase 2)
Triggers: Logged but not UI-mapped (available for Phase 2)
```

## 🎨 Active Glass Component Usage

### Currently Used Components (15+ Enhanced System)
```swift
// Apple Car Background System
AppleCarBackground()                    # Grid + ambient glow effects
AppleCarGridPattern()                   # 40px grid with subtle lines
AppleCarAmbientGlow()                   # Blue/purple gradient orbs

// Performance Visualization
CorePerformanceRing(coreNumber, usage, frequency)  # CPU core rings (6-8)
SystemHealthRing(title, icon, isActive, progress, color, valueText, isSelected) # System rings (7)

// Dual Sidebar System
LeftMissionControlSidebar(bridgeManager, onClose)   # 80px icon-only controls
RightDebuggerSidebar(bridgeManager, onClose)        # 45% professional console
BigIconButton(icon, color, isEnabled, action)       # Icon-only sidebar buttons

// Debug Console Components  
DebuggerLogLine(lineNumber, message, messageType)   # Color-coded debug lines
DebugMessageType enum                                # success, error, warning, info, controller, debug

// Controller System
DetailedControllerStatus(controllerManager)         # Controller info for sidebars
ControllerUIManager                                  # Navigation system (not visual component)

// Foundation & Utilities
GlassIcon(icon, size)                               # Consistent iconography
GlassButtons.CircularGlassButton()                  # Floating toggle buttons
.glassSpring(trigger: showingSidebar)               # Smooth sidebar animations
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

## 🔍 Enhanced File Locations & Sizes

### Core Files (Updated)
```
ContentView.swift               # Sophisticated Apple Car dashboard (complex architecture)
BridgeManager.swift             # Enhanced with controller integration
GodotEngineManager.swift        # 14,085 bytes (Engine operations)
PCKManager.swift                # 9,250 bytes (Bundle detection)
GameControllerManager.swift     # 🆕 Complete controller system with debug logging
```

### New Controller Components
```
Managers/GameControllerManager.swift        # Controller detection & input handling
Organism/ControllerStatusCard.swift         # Controller information display
Organism/DetailedControllerStatus.swift     # Detailed controller info for sidebars
```

### Premium Component Library (Unchanged Structure)
```
Styles/GlassComponents/     # 50+ premium components organized by atomic design
├── Foundation/             # 5 files (design tokens, data structures)
├── Atomic/                 # 10+ files (basic UI elements)
├── Molecular/              # 8+ files (compound components)
├── Organism/               # 12+ files (complex components) 🆕 +2 controller components
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
- **Apple Car dashboard** professional automotive-grade interface
- **Dual sidebar system** optimizing screen real estate + workflow
- **Full controller navigation** with Xbox/PlayStation/MFi support + haptic feedback
- **Real-time performance monitoring** with adaptive core detection + system health
- **Professional debug environment** with color-coded console + live updates
- **Modular component architecture** enabling rapid feature development

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
+ Game state visualization in additional system rings
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

### Enhanced Component Integration Pattern
```swift
// Each Phase 2 enhancement follows the established pattern:
1. Import from appropriate atomic design layer
2. Integrate with enhanced manager system (bridgeManager, controllerManager)
3. Use Foundation design tokens for consistent Apple Car styling
4. Apply Extensions modifiers for smooth animations
5. Maintain professional automotive-grade appearance
6. Support controller navigation with proper haptic feedback
```

## 🔬 Enhanced Development Workflow

### Current Workflow (Professional Development Environment)
```
1. Open NativeBridge.xcodeproj
2. ContentView.swift - Sophisticated Apple Car dashboard
3. Run on Simulator/Device - Professional automotive interface
4. LeftMissionControlSidebar - Icon-only bridge operations
5. RightDebuggerSidebar - Professional debug console with controller status
6. Controller testing - Connect Xbox/PlayStation/MFi controllers
7. Debug with controller diagnostics - Real-time input logging + haptic testing
```

### Phase 2 Workflow (Enhanced with Runtime Integration)
```
1. Same sophisticated Apple Car dashboard foundation
2. Add Phase 2 components using established atomic design patterns
3. Maintain professional automotive aesthetic + controller navigation
4. Test with existing controller system + bridge integration
5. Professional development environment with enhanced spatial computing materials
```

## 📊 Enhanced Success Metrics

### Code Quality Achieved (Significantly Enhanced)
- **Sophisticated architecture** vs simple 80-line implementation ✅
- **Apple Car dashboard** professional automotive-grade design ✅
- **Dual sidebar system** optimized workflow + screen real estate ✅
- **Controller navigation** full Xbox/PlayStation/MFi support ✅
- **Professional debug environment** color-coded console + comprehensive logging ✅
- **Modular architecture** atomic design system + easy extension ✅

### User Experience Achieved (Professional Grade)
- **Automotive-grade appearance** Apple Car dashboard aesthetic ✅
- **Intuitive controller navigation** ring selection + haptic feedback ✅
- **Real-time performance monitoring** adaptive ring system + live metrics ✅
- **Professional debug tools** live console + controller diagnostics ✅
- **Responsive design** adapting to iPhone/iPad + controller types ✅
- **Smooth animations** spring physics + selection feedback ✅

### Developer Experience Achieved (Enhanced Professional Tools)
- **Professional development environment** live debug console + controller testing ✅
- **Comprehensive logging system** all interactions tracked + color-coded ✅
- **Easy controller testing** input verification + haptic feedback testing ✅
- **Clean architecture patterns** enhanced manager system + atomic design ✅
- **Extensible foundation** ready for Phase 2 runtime + spatial computing ✅
- **Controller abstraction layer** supporting multiple controller types seamlessly ✅

---
*Apple Car Dashboard Architecture: Sophisticated dual sidebars + controller navigation + performance monitoring*  
*Enhanced: GameControllerManager + ControllerUIManager + DetailedControllerStatus + Professional Debug Environment*  
*Next: Phase 2 runtime integration with enhanced spatial computing materials + direct controller → Godot bridge*