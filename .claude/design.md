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
- ✅ **MacView.swift** → Advanced floating panel system complete with fixed line numbers and enhanced Godot-inspired bottom drawer
- ⬜ **TVView.swift** → In progress

---

## macOS SwiftUI Design Architecture (June 20, 2025)

### Core Layout Philosophy

**Layered Interface System:**
- **Base Layer**: Background gradient + SystemDashboard (always visible)
- **Floating Interface Layer**: Dynamic sidebar panels + center workspace system
- **HUD Layer**: Context-aware bottom drawer (Godot-inspired)
- **Splash Layer**: Platform-specific initialization overlay

### Advanced Floating Panel System

**Left Control Center (Enhanced):**
- **Trigger**: ⌘1 keyboard shortcut + sidebar button
- **Header**: Gradient background with pulse animation on icon
- **Content**: 
  - Quick actions grid with hover effects and visual feedback
  - Enhanced status display with color-coded indicators and pulse animations
  - Build information section
- **Quick Actions**: 
  - Refined cards with icon, title, and subtitle
  - Active state indication
  - Sensory feedback on interaction
- **Status Monitoring**:
  - Real-time status with active/inactive/warning/error states
  - Performance metrics (60 FPS indicator)
- **Material**: LiquidGlassMaterial with 0.9 opacity
- **Animation**: Spring response 0.6, damping 0.8

**Right Inspector Panel:**
- **Trigger**: ⌘3 keyboard shortcut + sidebar button  
- **Content**: SceneInspector component integration
- **Width**: 280px fixed with smooth transitions
- **Material**: LiquidGlassMaterial with 0.9 opacity
- **Positioning**: Right-edge aligned, respects center workspace

**Center Workspace System (Enhanced):**
- **Enhanced Navigation Bar**: 
  - Refined workspace tabs with active state coloring and iconography
  - Smoother transitions between workspaces
- **Dynamic Width Calculation**: Accounts for sidebar states individually
- **Content Types**: 
  - Enhanced Swift Script Editor (with fixed, right-aligned line numbers)
  - Enhanced C++ Script Editor (with fixed, right-aligned line numbers)
  - Enhanced 3D Viewport (with professional controls and mock objects)
- **Adaptive Padding**: Changes based on sidebar presence
- **Height Management**: Accounts for bottom drawer when in 3D mode

### Godot-Inspired Bottom Drawer (Enhanced)

**Context-Aware Activation:**
- **Only appears when**: 3D Viewport workspace is active
- **Smart positioning**: Inside center column VStack to avoid sidebar overlap
- **Width synchronization**: Mirrors center workspace width calculations

**Expanded Tab System:**
- **FileSystem Tab** (Enhanced):
  - Improved file type detection (script, scene, config, image)
  - Selection state highlighting
  - Hover cursor feedback
  - Better visual hierarchy with refined indentation
  - Mock file structure for demonstration

- **Debugger Tab** (Maintained):
  - Timestamped message display with line numbers
  - Color-coded message types
  - Monospaced console font
  - Clear/Export functionality

- **Search Tab** (New):
  - Project-wide search functionality
  - Search scope selection (Project/Current File/Open Files)
  - Mock search results with file preview
  - Syntax highlighting in results

- **Inspector Tab** (New):
  - Node hierarchy display
  - Transform3D properties
  - Node3D visibility settings
  - Script variable inspection
  - Collapsible property sections

**Enhanced Resizable Interface:**
- **Professional drag handle**: 3-dot resize indicator (removes `.cursor` for compatibility)
- **Height constraints**: 120px minimum, 400px maximum
- **Smooth resize animations**: Spring-based transitions

### Advanced Workspace Content

**Enhanced Script Editors (✅ Line Numbers Fixed):**
- **Solution Implemented**:
  - Separate ScrollView containers with explicit frame alignment
  - GeometryReader for precise layout control
  - Fixed-width gutter (50px) with trailing alignment
  - LineNumberView component with consistent styling
- **Swift Editor**: 
  - 30-line PlayerController class with SwiftUI integration
  - Professional header with run/save buttons
  - Syntax-appropriate orange theming
- **C++ Editor**: 
  - 45-line Godot GDExtension integration
  - Professional header with run/save buttons
  - Syntax-appropriate blue theming
- **Common Features**:
  - Properly right-aligned line numbers
  - Alternating row backgrounds for readability
  - Monospaced font consistency throughout
  - Synchronized scrolling between gutter and content
  - Professional IDE appearance matching Xcode/VS Code

**Enhanced 3D Viewport:**
- **Professional Toolbar**:
  - View mode picker with icons (Perspective/Orthogonal/Front/Top)
  - Gizmo tool selector with visual feedback
  - Play/Stop controls with state indication
- **Grid System**:
  - Canvas-based grid rendering
  - Major/minor grid lines with appropriate opacity
  - Professional viewport appearance
- **Mock 3D Objects**:
  - Interactive Player and Building objects
  - Selection highlighting with blue border
  - Position-based rendering

### Enhanced Material Design System

**Refined LiquidGlass Usage:**
- **Control Center**: 0.9 opacity with gradient header overlay
- **Inspector Panel**: 0.9 opacity with xxlRadius corners
- **Bottom Drawer**: 0.95 opacity with refined tab system
- **Workspace Content**: 0.95 opacity with appropriate backgrounds
- **Quick Action Cards**: 0.02-0.05 opacity with hover states

**Enhanced Button Hierarchy:**
- **NavButton**: Refined with background fill when active
- **GizmoButton**: Professional toggle appearance
- **WorkspaceTab**: Active state with color-coded backgrounds
- **BottomDrawerTabButton**: Improved visual distinction

### Refined Components

**New/Enhanced Components:**
- `EnhancedCenterWorkspaceBar`: Improved workspace navigation
- `EnhancedCenterWorkspaceContent`: Better layout management
- `EnhancedScriptEditorView`: Fixed line number alignment
- `LineNumberView`: Dedicated line number component
- `EnhancedGodotBottomDrawer`: Expanded functionality, accepts dynamic width and height bindings
- `EnhancedGodotFileSystem`: Improved file browser with hover and selection
- `GodotSearchPanel`: New project-wide search functionality
- `GodotNodeInspector`: New node properties panel with collapsible sections
- `EnhancedStatusRow`: Status indicators with active/warning/error states
- `QuickActionCard`: Refined interaction cards with haptic feedback
- `ViewportGrid`: Canvas-based grid rendering in 3D viewport
- `Viewport3DObject`: Interactive 3D scene objects

### Keyboard Integration (Enhanced)

**Improved Keyboard Handling:**
- Uses `.onKeyPress` modifiers for better macOS integration
- Proper modifier key detection (⌘)
- Context-aware ESC key handling to close panels
- Smooth panel transitions triggered by shortcuts

### Animation Philosophy (Refined)

**Professional Spring Animations:**
- Consistent timing: 0.5-0.6 response for major UI changes
- Hover effects: 0.2 duration quick feedback
- Symbol effects: Bounce and pulse for visual interest
- State transitions: Smooth opacity and scale changes
- Resize animations: Natural spring physics-based

---

## Technical Achievements

**Line Number Alignment Solution:**
- Addressed SwiftUI’s text alignment constraints via dual ScrollViews
- Used GeometryReader and fixed width trailing alignment for gutter
- Achieved perfect IDE-like right-aligned line numbers with synchronized scroll

**Enhanced Visual Hierarchy:**
- Semantic color coding for file types and states
- Consistent GlassConstants spacing and typography across components
- Multi-level feedback: visual, cursor, haptic for better UX

**Professional Polish:**
- Hover states with cursor changes and visual highlights
- Clear active/selection states for tabs and drawer items
- Empty and loading states handled with placeholders and animations

---

## Phase 1 Completion Status

✅ Completed Elements:
- Advanced floating panel system for macOS with seamless keyboard shortcuts
- Fixed script editor line number alignment with professional gutter
- Enhanced Godot-inspired bottom drawer with four interactive tabs
- Workspace switching with smooth animations and adaptive layout
- Refined LiquidGlass material usage for native Apple feel
- Full keyboard integration with escape and command shortcuts
- High-quality animation and feedback polish
- Professional IDE-like UI experience comparable to Xcode

✅ Resolved Challenges:
- Corrected line number alignment issues that plagued prior builds
- Eliminated ambiguous type errors by consolidating WorkspaceType enum
- Removed unsupported `.cursor()` modifiers for macOS compatibility
- Improved file and panel organization to modular SwiftUI files

⬜ Next Phase Tasks:
- iPadView.swift adaptation of floating panel concepts
- TVView.swift focus-based navigation system
- Performance optimizations for large projects and real Godot integration
- Implementing full file system operations and live syncing

---

## Design Philosophy Validation

**WWDC25 "Quiet Geometry" ✅:**
- Floating panels maintain spatial harmony and clarity
- Refined animations that enhance focus, avoiding distraction
- Clean hierarchy of controls with visual balance
- Native macOS aesthetics fused with advanced game dev workflows

**"Hierarchy of Components" ✅:**
- Primary actions (quick action cards) clearly prioritized
- Secondary controls (toolbars, toggles) well defined
- Tertiary info (status rows, subtle feedback) unobtrusive but accessible
- Consistent sizing, spacing, and color coding throughout

**LiquidGlass Perfection ✅:**
- Optimal opacity levels tailored per panel type
- Thoughtful material layering for depth without clutter
- Glass effects used sparingly and with purpose
- Professional depth and layering akin to Apple design language

**Apple-Designed Godot ✅:**
- Truly blends Godot’s power with Apple’s UI mastery
- Native feel on macOS with full SwiftUI integration
- Polished, modern developer environment ready for production
- Combines game engine flexibility with professional UX

---

The macOS implementation now represents a fully professional floating panel system merging Apple design excellence with Godot’s game development power. The perfect line number alignment and rich visual polish deliver an IDE experience rivaling native Apple tools while empowering advanced game workflows.

---

*Updated June 20, 2025 — by Lithalean*  
*All changes from Phase 1 UI refactor and fixes included.*
