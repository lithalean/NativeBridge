# NativeBridge — Phase 1 UI (WWDC25 style)

---

## Overall Architecture

- Porting JENOVA Framework (C++ Godot) to DarwinArm64 (macOS / iOS)
- Embedding into Xcode project to enable full SwiftUI / WWDC25 native UI
- Goal: WWDC25 architecture + LiquidGlass adoption + modern UIKit
- Single codebase with platform detection — adaptive UI for all devices

---

## Platform Views Status

- ✅ **iPhoneView.swift** → Complete — Phase 1 UI locked
- ⬜ **iPadView.swift** → In progress
- ✅ **MacView.swift** → Advanced floating panel system complete with modular architecture
- ⬜ **TVView.swift** → In progress

---

## macOS Modular Architecture (June 20, 2025)

### File-by-File Enhancement Breakdown

#### **1. MacView+FloatingControlCenter.swift** (Completely Rewritten)
**Original**: Basic toggle controls with minimal styling
**Enhanced**:
- Added gradient header with `LinearGradient` and pulse animation on icon
- Implemented `QuickActionCard` component with:
  - Icon, title, and subtitle for better context
  - Active state indication with color opacity
  - Hover effects (0.02 → 0.05 opacity transition)
  - Scale effect on press (0.95) with sensory haptic feedback
  - Professional rounded rectangle backgrounds
- Created `EnhancedStatusRow` with:
  - Multi-state support (active/inactive/warning/error)
  - Color-coded status indicators with glow effects
  - Pulse animation for active states
  - Real-time status details (FPS, connection counts)
- Added `BuildInfoRow` component for system information display
- Wrapped entire panel in `LiquidGlassMaterial` with 0.9 opacity

#### **2. MacView+EnhancedGodotBottomDrawer.swift** (Complete Overhaul)
**Original**: Placeholder with basic text
**Enhanced**:
- Implemented 4-tab system (FileSystem, Debugger, Search, Inspector)
- Created `BottomDrawerTab` enum with icons and colors
- Professional resize handle:
  - 3-dot visual indicator
  - Cursor feedback (using platform-safe implementation)
  - Smooth drag gesture with height constraints (120-400px)
- Tab switching with animated transitions (0.2s ease)
- Integrated all four content panels seamlessly
- Added `GodotDebugger` component with:
  - Timestamped messages with `DateFormatter`
  - Color-coded message types (info/warning/error/debug)
  - Line numbering with monospaced fonts
  - Clear/Export action buttons
  - Alternating row backgrounds

#### **3. MacView+EnhancedScriptEditors.swift** (Created from Scratch)
**Original**: Basic TextEditor placeholders
**Enhanced**:
- **Swift Editor**: 30 lines of realistic SwiftUI `PlayerController` code
- **C++ Editor**: 45 lines of complete GDExtension integration
- Implemented the **fixed line number solution**:
  - Separate `ScrollView` containers for gutter and content
  - `GeometryReader` for precise layout control
  - 50px fixed-width gutter with trailing alignment
  - `LineNumberView` component for consistent rendering
  - Synchronized scrolling between line numbers and code
- Added `ScriptEditorHeader` with:
  - Language-appropriate icons and colors
  - Run and Save action buttons
  - Professional styling with dark backgrounds

#### **4. Viewport3D.swift** (Transformed)
**Original**: Simple placeholder text
**Enhanced**:
- Professional toolbar with:
  - `ViewMode` picker (Perspective/Orthogonal/Front/Top)
  - `GizmoMode` selector (Move/Rotate/Scale) with toggle buttons
  - Play/Stop controls with state-based coloring
- Implemented `ViewportGrid` using Canvas:
  - Minor grid lines (50px spacing, 0.05 opacity)
  - Major grid lines (250px spacing, 0.1 opacity)
  - Colored axis lines (X=red, Y=green at 0.3 opacity)
- Added `Viewport3DObject` components:
  - Interactive Player, Building, and Light objects
  - Selection states with blue border highlighting
  - Positioned using absolute coordinates
  - Professional dark backgrounds with rounded corners

#### **5. MacView+EnhancedWorkspace.swift** (New File)
**Created**: Complete workspace management system
- Defined `WorkspaceType` enum with:
  - Icons (swift, chevron.left.forwardslash.chevron.right, cube)
  - Colors (orange, blue, purple)
- Enhanced `EnhancedCenterWorkspaceBar`:
  - Professional workspace tabs with active state backgrounds
  - Symbol effects (bounce) on active state changes
  - Integrated with enhanced `NavButton` components
- Enhanced `EnhancedCenterWorkspaceContent`:
  - Dynamic height calculations for bottom drawer
  - Smooth transitions between workspace types
  - Proper frame management for different content types
- Refined `NavButton` with:
  - Circular background fills for active states
  - 44x44px touch targets
  - Integrated with `GlassButtons.CircularGlassButton()`

#### **6. MacView+FileSystem.swift** (Major Enhancement)
**Original**: Basic file list
**Enhanced**:
- Professional toolbar with action buttons (folder.badge.plus, doc.badge.plus, arrow.clockwise)
- Implemented proper file tree structure:
  - Expandable folders with smooth rotation animations
  - Proper indentation (16px per level)
  - Color-coded folder types:
    - 🟢 assets (Green)
    - 🔵 resources (Blue)
    - 🩷 scenes (Pink)
    - 🟡 scripts (Yellow)
    - 🔴 shaders (Red)
- Enhanced `FileSystemItem`:
  - Selection states with blue background highlighting
  - Hover cursor feedback (NSCursor.pointingHand)
  - Proper file type detection (script, scene, config, image)
  - Expand/collapse functionality with state management

#### **7. MacView+FloatingInspectorPanel.swift** (Complete Redesign)
**Original**: Basic toggles and sliders
**Enhanced**:
- Full `SceneInspector` implementation with:
  - Gradient header matching Control Center style
  - Node path display with purple highlighting
  - Multiple property sections:
    - Transform3D with Vector3 inputs
    - Node3D with visibility controls
    - Script variables display
    - Signals with connection UI
- Created specialized components:
  - `InspectorSection`: Collapsible containers with icons
  - `InspectorVector3`: X/Y/Z inputs with axis coloring
  - `InspectorSlider`: Range controls with value display
  - `InspectorSignal`: Signal connection interface
- Professional styling with consistent spacing and backgrounds

#### **8. MacView+FloatingSettingsModal.swift** (Enhanced)
**Original**: Basic form with toggles
**Enhanced**:
- Multiple organized sections with icons:
  - General settings
  - Engine configuration
  - Controller options
  - Appearance preferences
- Added `SettingsSection` component with:
  - Icon and title header
  - Glass material background for content
  - Consistent spacing and styling
- Implemented various control types:
  - Toggle switches
  - Segmented controls for theme selection
  - Value displays for paths and settings
- Smooth modal transitions with scale + opacity

#### **9. MacView+SearchPanel.swift** (New Component)
**Created**: Professional search interface
- Search bar with magnifying glass icon
- Scope selector (Project/Current File/Open Files)
- `SearchResultItem` component with:
  - File icon and name
  - Line number display
  - Code preview with monospaced font
  - Hover effects (platform-safe implementation)
- Empty state handling with helpful messages

#### **10. MacView+Inspector.swift** (New Component)
**Created**: Godot node inspector
- `GodotNodeInspector` with full property editing
- `GodotInspectorSection`: Collapsible property groups
- Property types:
  - Text values with dark backgrounds
  - Toggle switches (scaled to 0.8)
  - Sliders with value displays
- Professional styling matching Godot's inspector

#### **11. Supporting Files Created**

**View+Cursor.swift** (New):
- Platform-safe cursor implementation
- macOS-specific NSCursor support
- iOS/tvOS no-op fallback

**FloatingPanelManager.swift** (New):
- Centralized panel state management
- Toggle and active panel tracking
- Observable object for SwiftUI integration

### Technical Improvements Summary

**Visual Enhancements**:
- Consistent use of `LiquidGlassMaterial` throughout
- Professional color palette with semantic meaning
- Gradient headers for major panels
- Hover states and visual feedback everywhere
- Multi-level status indicators

**Interaction Improvements**:
- Haptic feedback on interactions
- Smooth spring animations (0.5-0.6s response)
- Professional drag handles and resize controls
- Keyboard shortcuts properly integrated
- Context-aware panel management

**Code Quality**:
- Modular component architecture
- Reusable sub-components
- Consistent spacing using GlassConstants
- Platform-safe implementations
- Professional SwiftUI patterns

### Animation Specifications

**Spring Animations**:
- Panel transitions: `spring(response: 0.6, dampingFraction: 0.8)`
- Button presses: `easeInOut(duration: 0.1)` 
- Hover effects: `easeInOut(duration: 0.2)`
- Tab switches: `easeInOut(duration: 0.2)`
- Folder expand/collapse: `easeInOut(duration: 0.2)`

**Visual Effects**:
- Symbol effects: `.bounce` on active state changes
- Pulse animations: `.pulse` on active status indicators
- Scale effects: 0.95 scale on button press
- Glow effects: Blur radius 4 on active status dots

---

## Design Philosophy Validation

**WWDC25 "Quiet Geometry" ✅:**
- Every enhancement maintains visual harmony
- Animations serve functionality, not decoration
- Clean separation between content layers
- Professional restraint in effects usage

**"Hierarchy of Components" ✅:**
- Primary: Quick action cards dominate Control Center
- Secondary: Toolbar buttons and navigation controls
- Tertiary: Status indicators and subtle feedback
- Clear visual weight distribution

**LiquidGlass Perfection ✅:**
- Control Center: 0.9 opacity for panel presence
- Bottom Drawer: 0.95 opacity for content focus
- Quick Actions: 0.02-0.05 hover for subtle feedback
- Section backgrounds: 0.5 opacity for hierarchy

**Apple-Designed Godot ✅:**
- Native macOS controls and patterns
- Professional development environment
- Game engine power with consumer polish
- Indistinguishable from Apple's own tools

---

The modular refactoring successfully preserved and enhanced the original beautiful design while improving code organization and reusability. Each file now contains focused, professional components that combine to create a truly Apple-quality Godot development environment.

---

*Updated June 20, 2025 — Detailed file-by-file enhancement documentation*