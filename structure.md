# NativeBridge — Folder Structure (Phase 2 — WWDC25)

---

## Core Architecture (June 21, 2025)

NativeBridge/
├── NativeBridge/                        # SwiftUI app source
│   ├── Assets.xcassets/                 # App assets (colors, icons, images)
│   ├── Extensions/                      # Swift extensions
│   ├── Managers/                        # BridgeManager, PCKManager, etc.
│   ├── Models/                          # App data models
│   ├── Preview Content/                 # SwiftUI preview resources
│   ├── Styles/                          # Design system (GlassComponents)
│   │   ├── Atomic/                      # Base UI atoms (Icon, Status, Typography, Effects)
│   │   ├── Molecular/                   # Molecules (buttons, sections, cards)
│   │   ├── Organism/                    # Complex UI components (status cards, progress cards)
│   │   ├── Template/                    # Reusable templates (debug console, dev panels)
│   │   ├── Foundation/                  # Global constants, enums, colors
│   │   ├── Pages/                       # Full pages (DebugConsole)
│   │   └── Extensions/                  # View+Modifiers for Glass UI
│   ├── Views/                           # App UI components and screens
│   │   ├── Mac/                         # macOS-specific views (MacView+ Extensions)
│   │   ├── iPhone/                      # iPhone-specific views (iPhoneView+ Extensions)
│   │   │   ├── iPhoneView.swift
│   │   │   ├── iPhoneView+TabBar.swift
│   │   │   ├── iPhoneView+BottomDrawer.swift
│   │   │   ├── iPhoneView+Workspace.swift
│   │   │   ├── iPhoneView+InspectorSettings.swift
│   │   │   ├── iPhoneView+SwiftScriptEditor.swift
│   │   │   ├── iPhoneView+CppScriptEditor.swift
│   │   │   ├── iPhoneView+3DViewport.swift
│   │   │   ├── iPhoneView+Splash.swift
│   │   │   ├── iPhoneView+FloatingPanels.swift
│   │   │   ├── iPhoneView+FileSystem.swift
│   │   │   ├── iPhoneView+SearchPanel.swift
│   │   │   ├── iPhoneView+InspectorPanel.swift
│   │   │   ├── iPhoneView+DebugConsolePanel.swift
│   │   ├── iPadView.swift                # iPad-specific view
│   │   ├── TVView.swift                  # AppleTV view
│   │   ├── Navigation/                  # TabBar, Sidebar, Navigation Managers
│   │   ├── Components/                  # Common reusable components (Sidebar, BottomDrawer, Inspectors)
│   │   ├── Controls/                    # DebugConsole, ControlSidebar
│   │   ├── Dashboard/                   # SystemDashboard, MetricsGrid
│   │   ├── Console/                     # DebuggerOverlay, ConsoleLogEntry
│   │   ├── Shared/                      # Shared views (SplashScreen, ScriptEditorHeader)
│   │   ├── Glass/                       # SelectableTabMaterial, Glass effects
│   │   ├── ContentView.swift            # App entry UI
│   ├── GodotBridge.swift                # Bridge for interacting with Godot
│   ├── NativeBridge.entitlements        # App entitlements
│   ├── NativeBridgeApp.swift            # App entry point
│   └── README.md                        # Project overview

---

## iPhone Phase 2 Updates (June 21, 2025)

**iPhoneView.swift**:
- Phase 2 Mobile Interface
- New: **Portrait-locked SplashScreen**
- New: **SimpleTabBar** with Swift, C++, Files, Dashboard
- Updated: Control Center + Top Console
- Updated: Workspace coordination
- Updated: Single unified BottomDrawer

**Simple Components**:
- SimpleSwiftScriptEditor
- SimpleCppScriptEditor
- Simple3DViewport
- SimpleFileSystem
- SimpleInspectorPanel
- SimpleDebugConsolePanel
- SimpleSearchPanel

**SplashScreen**:
- Fixed Portrait 3-Row Grid
- Component animation with Haptic
- Matches WWDC25 "Quiet Geometry"

**BottomDrawer**:
- Unified — Console + Performance + Network

---

## Platform-Specific Adaptations

### iPhone (Phase 2 — Complete ✅)
- Professional splash screen
- Unified BottomDrawer
- Simplified TabBar
- Simple workspace system
- Optimized portrait-only
- Professional iPhone build ready

### iPad (Phase 2 — In Progress ⬜)
- Landscape adaptations
- Hybrid split-view
- Floating panel adaptations

### macOS (Enhanced — 95% 🔄)
- Advanced floating panel system
- Keyboard shortcut integration
- Professional development workspace

### tvOS (In Progress ⬜)
- Focus-based navigation

---

*Updated June 21, 2025 — by Lithalean*
