# NativeBridge — Folder Structure (Phase 1 — WWDC25)

---

## Core Architecture (June 20, 2025)

Views/
├── Components/
│   ├── BottomDrawer.swift
│   ├── GlassDebugConsole.swift
│   ├── ModernFloatingSidebar.swift
│   ├── ModernSidebarPhaseRow.swift
│   ├── SidebarFeatureView.swift (FloatingSidebar)
│   ├── **CenterWorkspaceSystem.swift** ← Workspace switching (Swift/C++/3D)
│   ├── Inspector/
│   │   └── **SceneInspector.swift** ← 3D scene inspection tools
├── Controls/
│   ├── DebugConsole.swift
│   ├── ControlSidebar.swift
│   ├── Components/
│   │   └── ControlButtons.swift
├── Dashboard/
│   ├── SystemDashboard.swift
│   ├── DashboardBackground.swift
│   ├── MetricsGrid.swift
├── Glass/
│   └── SelectableTabMaterial.swift
├── Metrics/
│   ├── MetricRing.swift
│   └── ProcessorCoreRing.swift
├── Navigation/
│   ├── TabBar.swift
│   ├── SidebarFeatureTabView.swift (TabBar)
│   └── **ControllerNavigationManager.swift** ← Input handling
├── Platform/
│   ├── **iPhoneView.swift** ✅ Complete
│   ├── **iPadView.swift** ⬜ In progress
│   ├── **MacView.swift** 🔄 Advanced floating panels (95% complete)
│   └── **TVView.swift** ⬜ In progress
├── Shared/
│   └── **SplashScreen.swift** ← Platform-specific initialization

---

## Advanced Component System (Atomic Design)

Styles/
├── **GlassComponents/** ← Comprehensive design system
│   ├── **Foundation/** ← Core design tokens
│   │   ├── GlassConstants.swift
│   │   ├── GlassColors.swift
│   │   ├── ComponentStatus.swift
│   │   └── TrendDirection.swift
│   ├── **Atomic/** ← Basic building blocks
│   │   ├── Materials/
│   │   │   ├── **LiquidGlassMaterial.swift** ← Primary glass effect
│   │   │   ├── **FloatingGlassMaterial.swift** ← Panel backgrounds
│   │   │   └── **AdvancedMaterials.swift** ← Specialized effects
│   │   ├── Layout/
│   │   │   ├── GlassSpacer.swift
│   │   │   └── GlassGrid.swift
│   │   ├── Typography/
│   │   │   └── GlassTypography.swift
│   │   ├── Effects/
│   │   │   ├── **GlassAnimations.swift** ← Spring animations
│   │   │   ├── **AnimationPresets.swift** ← WWDC25 timing
│   │   │   └── **AdvancedAnimations.swift** ← Complex transitions
│   │   ├── GlassIcon.swift
│   │   ├── GlassStatusIndicator.swift
│   │   └── GlassCircularProgress.swift
│   ├── **Molecular/** ← Component combinations
│   │   ├── Buttons/
│   │   │   ├── **AdvancedButtons.swift** ← Complete button library
│   │   │   └── **GlassActionButton.swift** ← Primary actions
│   │   ├── GlassContentSection.swift
│   │   ├── GlassCardHeader.swift
│   │   └── GlassProgressSection.swift
│   ├── **Organism/** ← Complex components
│   │   ├── **ModernStatusCard.swift** ← System status display
│   │   ├── **ModernMetricCard.swift** ← Performance metrics
│   │   ├── **PhaseProgressCard.swift** ← Build progress
│   │   ├── **DetailedControllerStatus.swift** ← Input device status
│   │   ├── **ModernActionCard.swift** ← Interactive cards
│   │   └── **ControllerStatusCard.swift** ← Controller info
│   ├── **Template/** ← Layout templates
│   │   ├── **DebugConsoleContent.swift** ← Console layout
│   │   ├── **DebugConsoleHeader.swift** ← Console controls
│   │   ├── **FeaturesListContainer.swift** ← Feature organization
│   │   ├── **GlassSectionHeader.swift** ← Section headers
│   │   ├── **DebugConsoleMessage.swift** ← Message formatting
│   │   └── **DevelopmentControlPanel.swift** ← Dev tools
│   ├── **Extensions/** ← SwiftUI extensions
│   │   ├── **View+GlassMaterials.swift** ← Material helpers
│   │   ├── **View+Effects.swift** ← Animation helpers
│   │   └── **View+GlassTypography.swift** ← Typography helpers
│   └── **Pages/** ← Complete interfaces
│       └── **GlassDebugConsole.swift** ← Debug interface

---

## Data & Logic Layer

Models/
├── Components/
│   ├── **SidebarFeatureModel.swift** ← Feature definitions
├── Navigation/
│   └── **SidebarFeature.swift** ← Tab enumeration

Managers/
├── **BridgeManager.swift** ← Core C++/Swift bridge
├── **GodotEngineManager.swift** ← Engine lifecycle management
├── **PCKManager.swift** ← Package loading/management
└── **GameControllerManager.swift** ← Input device handling

---

## macOS-Specific Components (June 20, 2025)

### Floating Panel System
**FloatingControlCenter** (Left Sidebar - ⌘1):
- QuickActionCard components (Start/Stop Engine, Load PCK, Controllers)
- StatusRow components (Engine, Bridge, PCK, Controller status)
- Real-time system monitoring
- LiquidGlass material integration

**FloatingInspectorPanel** (Right Sidebar - ⌘3):
- SceneInspector integration
- 280px fixed width with smooth transitions
- Context-aware content based on selected objects

### Godot-Inspired Bottom Drawer (3D Viewport Only)
**GodotBottomDrawer**:
- Context-aware activation (only appears in 3D viewport)
- Resizable interface (120-400px height)
- Drag handle for user control
- Smart width calculation matching center workspace

**GodotFileSystem** (Tab 1):
- Expandable tree structure from `res://`
- Color-coded folder icons:
  - 🟢 assets (Green)
  - 🔵 resources (Blue) 
  - 🩷 scenes (Pink)
  - 🟡 scripts (Yellow)
  - 🔴 shaders (Red)
- Proper hierarchy indentation
- Expand/collapse animations

**GodotDebugger** (Tab 2):
- Timestamped debug messages
- Color-coded message types (Info=Blue, Warning=Orange, Error=Red, Debug=Gray)
- Line-numbered console output
- Clear/Export functionality
- Monospaced font for readability
- Alternating row backgrounds

### Workspace Content System
**CenterWorkspaceSystem.swift**:
- **WorkspaceType** enum (Swift, C++, Viewport3D)
- **CenterWorkspaceBar** (workspace selector + sidebar controls)
- **CenterWorkspaceContent** (workspace-specific rendering)

**Script Editors**:
- **SwiftScriptEditor**: 24-line PlayerController example
- **CppScriptEditor**: 40-line GDExtension integration
- **ScriptEditorHeader**: Run/Save controls
- **ScriptEditorView**: Code display with line numbers (alignment challenges noted)

**3D Viewport**:
- **Viewport3D**: Interactive 3D scene interface
- **ViewportGrid**: Canvas-drawn reference grid
- **Viewport3DObject**: Selectable scene objects
- **GizmoButton**: Move/Rotate/Scale controls
- View mode picker (Perspective, Orthogonal, Front, Top)
- Play/Stop controls for scene execution

### Supporting Components
**NavButton**: Consistent navigation controls  
**BottomDrawerTabButton**: Tab switching interface  
**MiniStatusIndicator**: Compact status display  
**ActionHubButton**: Floating action controls  
**FileSystemItem**: Tree view file/folder items  
**DebugMessageRow**: Console message formatting  

---

## Platform-Specific Adaptations

### iPhone (Complete ✅)
- Compact TabBar system
- Gesture-based navigation
- Single-view focus
- Touch-optimized controls

### iPad (In Progress ⬜)
- Split-view adaptations
- Floating panel concepts from macOS
- Touch + keyboard hybrid interaction
- Adaptive layout for portrait/landscape

### macOS (95% Complete 🔄)
- Advanced floating panel system
- Keyboard shortcut integration
- Professional development environment
- Multi-workspace coordination
- Context-aware bottom drawer

### tvOS (In Progress ⬜)
- Focus-based navigation system
- Remote control optimization
- Simplified interface hierarchy
- Distance viewing considerations

---

## Technical Architecture Notes

### State Management
- **@StateObject pattern**: Manager integration (BridgeManager, etc.)
- **@State coordination**: Complex multi-panel states
- **Environment object propagation**: Clean dependency injection
- **Conditional rendering**: Performance-optimized component loading

### Animation System
- **Spring animations**: 0.6 response, 0.8 damping (WWDC25 compliant)
- **Transition types**: Move, opacity, scale combinations
- **Performance targeting**: 60fps smooth animations
- **Context-aware timing**: Different speeds for different interactions

### Material Integration
- **Opacity levels**: 0.9 (panels), 0.95 (content), 0.8 (navigation)
- **Corner radius**: Consistent with GlassConstants
- **Background interaction**: Proper transparency and depth
- **Platform adaptation**: Materials adjust for platform capabilities

### Layout Calculations
- **Dynamic width**: `calculateWorkspaceWidth()` accounts for sidebar states
- **Dynamic height**: `calculateWorkspaceHeight()` accounts for bottom drawer
- **Responsive padding**: Different spacing for different sidebar combinations
- **Z-index management**: Proper layering for complex interfaces

---

## Development Status & Next Steps

### Phase 1 Completion (95%)
✅ **Advanced macOS floating panel system**  
✅ **Godot-inspired bottom drawer with FileSystem + Debugger**  
✅ **Professional workspace switching (Swift/C++/3D)**  
✅ **Complete keyboard shortcut integration**  
✅ **Dynamic layout calculation system**  
✅ **WWDC25-compliant animation system**  
✅ **Comprehensive atomic design system**  
⚠️ **Script editor line number alignment** (technical SwiftUI limitation)  

### Immediate Tasks
⬜ **iPadView.swift**: Adapt floating panel concepts for tablet interaction  
⬜ **TVView.swift**: Focus-based navigation for Apple TV  
⬜ **Script editor refinement**: Resolve line number alignment challenges  
⬜ **Final folder organization**: Clean up development artifacts  
⬜ **Preview file cleanup**: Remove temporary components  

### Architecture Stability
- **Foundation layer**: Stable and production-ready
- **Component reusability**: Cross-platform compatibility achieved
- **Design system**: Complete atomic → organism → page hierarchy
- **Performance**: Optimized for complex multi-panel interfaces
- **Accessibility**: VoiceOver compatible, keyboard navigation ready

---

# Design Philosophy Validation

**WWDC25 "Quiet Geometry"** ✅:
- Floating panels maintain spatial harmony without visual competition
- Smooth, purposeful animations enhance rather than distract
- Clean information hierarchy with logical component relationships

**"Hierarchy of Components"** ✅:
- Clear primary/secondary/tertiary action structure
- Consistent button sizing reflecting interaction importance  
- Logical information architecture from Foundation → Atomic → Molecular → Organism
- Proper z-index layering for complex floating interfaces

**LiquidGlass Adoption** ✅:
- Consistent material usage across all floating panels
- Appropriate opacity levels for different contexts and content types
- Proper corner radius consistency following GlassConstants
- Glass material interaction with background elements enhances depth perception

The folder structure now represents a sophisticated, production-ready SwiftUI architecture that successfully bridges native macOS development patterns with Godot editor UX paradigms, creating a professional game development environment within Apple's ecosystem.

---

*Updated June 20, 2025 — by Lithalean*
