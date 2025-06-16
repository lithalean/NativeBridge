# NativeBridge Project Structure
*Current folder and file organization for AI collaboration*

> **Location**: `/.claude/structure.md` - Live project structure reference  
> **Last Updated**: June 16, 2025  
> **Build Status**: Phase 1 Development - Modern UI Implementation Complete  

## 📁 Root Directory Structure
```
NativeBridge/                   # Project root
├── .claude/
│   ├── context.md              # AI collaboration state & decisions
│   └── structure.md            # This file - current project structure
├── NativeBridge/               # Main app directory (actual structure below)
├── NativeBridge.xcodeproj      # Xcode project file
├── GameEngine.xcframework/     # Godot engine framework (if present)
├── README.md                   # Project documentation
└── .gitignore                  # Git ignore rules
```

## 🏗️ Current App Structure (`NativeBridge/NativeBridge/`)
```
NativeBridge/NativeBridge/      # Actual current structure
├── Assets.xcassets             # App icons, images, colors
├── NativeBridge.entitlements   # App entitlements and permissions
├── Styles/                     # SwiftUI styling system
├── Item.swift                  # Core data model (likely SwiftData)
├── NativeBridgeApp.swift       # Main app entry point
├── Views/                      # SwiftUI views directory
├── Managers/                   # Business logic managers
└── Preview Content/            # Xcode preview assets
```

## 🎯 Current Implementation Status
```
ACTUAL_STRUCTURE_STATUS:
✅ IMPLEMENTED:
- Modern SwiftUI app structure with NativeBridgeApp.swift
- WWDC 25 design system with responsive layouts implemented
- Advanced UI components with slide-out sidebar and material backgrounds
- Spring animations and glassmorphism effects throughout
- Responsive landscape/portrait layout system
- Core data model with Item.swift (SwiftData integration)
- Views/ directory with modern ContentView.swift implementation
- Managers/ directory for business logic (PCKManager foundation)
- Styles/ directory for design system components
- Assets.xcassets for visual resources and app icons
- App entitlements configured for bridge development

✅ MODERN_UI_FEATURES_IMPLEMENTED:
- Slide-out sidebar with capsule styling and 24pt corner radius
- Floating toggle button with ultra-thin material background
- WWDC 25 design standards with gradient accents and smooth animations
- GeometryReader-based responsive layout system
- Material backgrounds (.regularMaterial, .ultraThinMaterial)
- Spring physics animations for smooth interactions
- Centered content layouts with proper spacing and hierarchy
- Modern phase selection with progress indicators and gradient styling

📋 BRIDGE_COMPONENTS_NEEDED:
- Bridge/ directory (not yet created)
- GameEngine integration files
- SwiftGodotKit integration setup
- MessagePassing system
- BridgeManager implementation

🔍 NEXT_EXPLORATION_NEEDED:
- Godot app embedding implementation
- SwiftUI wrapper components for Godot scenes
- Swift ↔ Godot communication layer
- Performance monitoring integration
- Hot-reload system implementation
```

## 📂 Detailed Directory Contents
```
Views/                          # SwiftUI view components
├── ContentView.swift           # Main content view - MODERN UI COMPLETE
└── (future Godot views)        # Planned: GodotView, BridgeView components

Managers/                       # Business logic managers  
├── PCKManager.swift            # PCK (Godot package) management - BRIDGE FOUNDATION
└── (future managers)           # Planned: BridgeManager, PerformanceManager

Styles/                         # Design system components
└── (WWDC 25 styling)           # Planned: Color schemes, typography, component styles

Preview Content/                # Xcode preview assets
└── Preview Assets.xcassets     # Preview-specific assets
```

## 🔍 Key Files Analysis
```
CORE_APP_FILES:
✅ NativeBridgeApp.swift         # SwiftData app with ModelContainer setup
✅ Item.swift                    # SwiftData model (Foundation + SwiftData imports)
✅ ContentView.swift             # MODERN UI - WWDC 25 design with responsive layouts
✅ PCKManager.swift              # Godot package manager - BRIDGE COMPONENT FOUNDATION
✅ NativeBridge.entitlements     # App permissions and capabilities

MODERN_UI_IMPLEMENTATION:
✅ ContentView.swift Features:
    • Slide-out sidebar with capsule styling (320pt width, 24pt corner radius)
    • Floating toggle button with material background and proper positioning
    • Responsive GeometryReader layout for landscape/portrait orientations
    • Spring animations (.spring(response: 0.6, dampingFraction: 0.8))
    • Material backgrounds (.regularMaterial, .ultraThinMaterial)
    • Gradient styling (.blue.gradient, .orange.gradient)
    • Centered content with proper spacing hierarchy
    • ModernPhaseRow component with progress indicators
    • Development phase management with BridgeManager integration
    • Real-time metrics display with trend indicators
    • Debug console integration with sheet presentation

ASSET_SYSTEM:
✅ Assets.xcassets              # Main visual resources and app icons
✅ Preview Assets.xcassets      # Development preview assets (in Preview Content/)
```

## 🎯 Bridge Foundation Discovery
```
EXISTING_BRIDGE_COMPONENTS_FOUND:
✅ PCKManager.swift             # Godot PCK management foundation
✅ ContentView.swift            # Modern UI with BridgeManager integration
✅ BridgeManager class          # Comprehensive bridge management system with:
    • Component status tracking (SwiftGodot, GameEngine, Runtime, Bridge)
    • Real-time metrics monitoring (latency, memory, frame rate, build time)
    • Development tools integration (bridge test, performance, memory check)
    • Hot-reload testing capabilities
    • Debug logging and console integration
    • Foundation phase task management

MODERN_UI_ARCHITECTURE_IMPLEMENTED:
✅ Responsive Layout System:
    • GeometryReader for orientation detection
    • Landscape: Full sidebar + detail side-by-side layout
    • Portrait: Slide-out sidebar with backdrop overlay
    • Floating toggle button with material styling

✅ WWDC 25 Design Standards:
    • Glassmorphism with .regularMaterial backgrounds
    • Spring animations for smooth interactions
    • Gradient accents on active states
    • Capsule styling with proper corner radius
    • Material design consistency throughout
    • Proper spacing and typography hierarchy

✅ Component Architecture:
    • ModernPhaseRow with progress indicators and gradient styling
    • BridgeStatusCard with real-time status monitoring
    • DevToolCard for development action buttons
    • MetricView for performance tracking display
    • TaskChecklistView for development progress
    • DebugConsoleView for log management

SWIFTDATA_INTEGRATION:
✅ Item.swift                   # SwiftData model for app data persistence
✅ NativeBridgeApp.swift        # ModelContainer configuration for data management
                                # Clean data layer ready for bridge state management
```

## 🚀 Phase 1 Implementation Status Update
```
CURRENT_STATE: Modern UI implementation complete with comprehensive bridge management foundation

✅ IMPLEMENTED (Updated June 16):
- WWDC 25 design system with responsive layouts and material backgrounds
- Slide-out sidebar with capsule styling and spring animations
- Comprehensive BridgeManager with real-time monitoring capabilities
- Modern component library (ModernPhaseRow, BridgeStatusCard, DevToolCard)
- Floating toggle button with proper positioning and material styling
- GeometryReader-based responsive layout system for all orientations
- Development phase management with progress tracking
- Real-time metrics display with trend indicators
- Debug console integration with comprehensive logging
- Material design consistency with gradient accents

🚧 BRIDGE_COMPONENTS_IN_PROGRESS:
- PCKManager.swift exists with Godot package management foundation
- BridgeManager.swift implemented with comprehensive monitoring system
- ContentView.swift serves as modern UI foundation for bridge integration

📋 PHASE_1_STILL_NEEDED:
- Bridge/ directory with core communication layer implementation
- GameEngine.xcframework integration and linking
- GodotView component for scene embedding
- Swift ↔ Godot message passing system implementation
- SwiftUI wrapper components for Godot scenes

🔍 IMMEDIATE_EXPLORATION_PRIORITY:
- Implement basic Godot app embedding using existing PCKManager foundation
- Create GodotView components in Views/ directory
- Integrate GameEngine.xcframework with current BridgeManager system
- Develop Swift ↔ Godot communication layer
- Connect real-time metrics to actual bridge performance data
```

## 🎨 Modern UI Architecture Implemented
```
UI_COMPONENT_HIERARCHY:
ContentView (Main Container)
├── GeometryReader (Responsive Layout Detection)
├── ZStack (Overlay Management)
│   ├── detailView (Main Content Area)
│   │   ├── Header Section (Centered with hammer icon)
│   │   ├── Bridge Status Grid (4 components monitoring)
│   │   ├── Development Tools Section (6 action buttons)
│   │   ├── Phase-specific Content (Dynamic based on selection)
│   │   └── Performance Metrics (4 real-time indicators)
│   ├── Sidebar Overlay (Conditional rendering)
│   │   ├── Backdrop (.black.opacity(0.3) with tap gesture)
│   │   └── modernSidebarView (320pt width, capsule styled)
│   │       ├── Header (Centered with icon and phase info)
│   │       ├── Divider (Subtle opacity)
│   │       └── ScrollView (Phase selection list)
│   └── Floating Toggle Button (Top-left with material styling)

DESIGN_SYSTEM_COMPONENTS:
├── ModernPhaseRow (Gradient styling, progress bars, selection states)
├── BridgeStatusCard (Real-time status monitoring with icons)
├── DevToolCard (Action buttons with material backgrounds)
├── MetricView (Performance indicators with trend arrows)
├── TaskChecklistView (Development progress tracking)
└── DebugConsoleView (Log management with monospaced font)

ANIMATION_SYSTEM:
├── Spring Physics (.spring(response: 0.6, dampingFraction: 0.8))
├── Asymmetric Transitions (.move(edge: .leading).combined(with: .opacity))
├── Material Backgrounds (.regularMaterial, .ultraThinMaterial)
└── Gradient Accents (.blue.gradient, .orange.gradient)
```

## 🚀 Next Development Phase
```
PHASE_1_FOUNDATION_STATUS: Modern UI implementation complete - Bridge integration ready!

CURRENT_STRENGTHS:
✅ Comprehensive BridgeManager with monitoring capabilities
✅ Modern UI foundation following WWDC 25 design standards
✅ Responsive layout system working across all orientations
✅ PCKManager provides Godot package management foundation
✅ SwiftData architecture ready for bridge state management
✅ Component library ready for Godot scene integration
✅ Real-time metrics framework ready for bridge performance data

IMMEDIATE_NEXT_STEPS:
1. Implement basic Godot app embedding using existing PCKManager foundation
2. Create GodotView SwiftUI component in Views/ directory
3. Connect BridgeManager to actual GameEngine.xcframework
4. Implement Swift ↔ Godot message passing system
5. Connect real-time metrics to bridge performance monitoring
6. Add bridge test functionality to existing DevToolCard actions

ARCHITECTURAL_ADVANTAGES:
- Modern UI provides excellent foundation for bridge development workflow
- BridgeManager architecture ready for actual bridge implementation
- Responsive design ensures consistent experience across development platforms
- Material design system provides professional development environment
- Component architecture allows for easy extension with Godot integration
```

---
*Auto-generated structure reference for Claude.ai collaboration*  
*Current focus: Bridge integration with modern UI foundation complete*