# NativeBridge Project Structure
*AI-focused project reference*

> **Last Updated**: June 19, 2025  
> **Location**: `/.claude/structure.md`
> **Status**: Clean Premium Architecture ✅ | 80-line ContentView ✅

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

## 🏗️ App Structure
```
NativeBridge/NativeBridge/
├── Assets.xcassets            # Resources
├── NativeBridgeApp.swift      # App entry point
├── Item.swift                 # SwiftData model
│
├── Views/
│   └── ContentView.swift      # Clean Premium Implementation (80 lines)
│
├── Managers/                  # Bridge System
│   ├── BridgeManager.swift    # Main orchestrator (@MainActor, 15KB)
│   ├── GodotEngineManager.swift # Engine operations (14KB)
│   ├── PCKManager.swift       # Bundle PCK detection (9KB)
│   └── GodotBridge.swift      # Swift ↔ libgodot interface
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
	│   ├── PhaseProgressCard.swift     # Development phase tracking ✅ USED
	│   └── ModernSidebarPhaseRow.swift # Sidebar feature rows
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
	│   ├── ModernFloatingSidebar.swift # Complete sidebar ✅ USED
	│   └── GlassDebugConsole.swift     # Complete console (available)
	│
	└── Extensions/            # SwiftUI modifiers
		├── View+GlassMaterials.swift   # .cardGlass(), .glassSpring() ✅ USED
		├── View+Effects.swift          # Animation modifiers
		└── View+GlassTypography.swift  # Text styling
```

## 🎯 Current Implementation (Clean Premium Architecture)

### ContentView.swift Architecture (80 lines)
```swift
ContentView
├── GeometryReader                    # Responsive layout
├── GlassColors.backgroundGradient   # Foundation gradient background
├── ModernFloatingSidebar            # Pages - Complete premium sidebar
├── PhaseProgressCard               # Organism - Hero status card
├── GlassIcon + CircularGlassButton # Atomic + Molecular toggle
└── .glassSpring() animations       # Extensions - Smooth transitions

// Premium Component Integration:
- Uses 5 premium components from existing library
- 80 lines total (vs 600+ custom implementation)
- Clean data flow with @StateObject managers
- Extensible design ready for Phase 2
```

### Layout Specifications
```swift
// Dimensions (Clean & Simple)
Single Sidebar: 320px standard width (ModernFloatingSidebar)
Main Content: Full width with proper padding
Toggle Button: CircularGlassButton (44x44px standard)
Background: Foundation gradient with overlay dimming

// Spacing (Foundation Design Tokens)
Card spacing: GlassConstants.mediumSpacing (16px)
Screen margins: GlassConstants.screenPadding (20px) 
Section spacing: GlassConstants.xlSpacing (32px)
Animation timing: springResponse + springDamping
```

## 🔧 Tech Stack

### Dependencies
- **iOS 18.0+** deployment target
- **Swift 5.0**
- **SwiftUI + SwiftData** (Foundation, SwiftUI only)
- **No external packages** - Pure Apple ecosystem

### Bridge Integration
```swift
// Manager Hierarchy (Unchanged)
BridgeManager (@MainActor)
├── GodotEngineManager          # Engine lifecycle
├── PCKManager                  # Bundle resource detection
└── GodotBridge                 # Native interface

// Key Properties (Integrated with Premium Components)
BridgeManager.isEngineConnected: Bool    # → ModernFloatingSidebar status
BridgeManager.isPCKLoaded: Bool          # → PhaseProgressCard progress
BridgeManager.debugMessages: [String]   # → Available for GlassDebugConsole
BridgeManager.bridgeMetrics: BridgeMetrics # → Ready for ModernMetricCard
```

### Performance Monitoring
```swift
// Real System Data (Ready for Premium Components)
ProcessInfo.processInfo.processorCount  # → ModernMetricCard grid potential
UIDevice.current.userInterfaceIdiom    # → Responsive component selection
mach_task_basic_info                    # → ModernStatusCard health monitoring
Timer-based metrics                     # → Real-time component updates
```

## 🎨 Glass Component Usage Patterns

### Currently Used Components (5 of 50+)
```swift
// From Foundation
GlassColors.backgroundGradient          # Main background gradient
GlassConstants.mediumSpacing           # Layout spacing values
GlassConstants.springResponse          # Animation timing

// From Atomic
GlassIcon("sidebar.left", size: .large) # Toggle button icon
GlassSpacer(.vertical, size: 80)        # Layout spacing

// From Molecular  
GlassButtons.CircularGlassButton()      # Sidebar toggle button

// From Organism
PhaseProgressCard(title, subtitle, features, progress, currentPhase) # Hero status

// From Pages
ModernFloatingSidebar(bridgeManager, onClose) # Complete sidebar

// From Extensions
.glassSpring(trigger: showingSidebar)   # Smooth animations
```

### Available for Phase 2 (45+ Premium Components)
```swift
// High-Impact Additions Ready:
ModernMetricCard        # Performance metrics grid
ModernStatusCard        # System health monitoring  
ModernActionCard        # Bridge operation controls
GlassDebugConsole       # Enhanced debugging interface
GlassSectionHeader      # Content organization
LiquidGlassMaterial     # Enhanced backgrounds
FloatingGlassMaterial   # Premium sidebar materials
AdvancedAnimations      # Enhanced transitions
```

## 🔍 File Locations & Sizes

### Core Files
```
ContentView.swift           # 80 lines (Clean premium implementation)
BridgeManager.swift         # 15,014 bytes (State orchestration)
GodotEngineManager.swift    # 14,085 bytes (Engine operations)
PCKManager.swift            # 9,250 bytes (Bundle detection)
```

### Premium Component Library
```
Styles/GlassComponents/     # 50+ premium components organized by atomic design
├── Foundation/             # 5 files (design tokens, data structures)
├── Atomic/                 # 10+ files (basic UI elements)
├── Molecular/              # 8+ files (compound components)
├── Organism/               # 10+ files (complex components) 
├── Template/               # 6+ files (layout templates)
├── Pages/                  # 2 files (complete layouts)
└── Extensions/             # 3 files (SwiftUI modifiers)
```

### Bundle Resources
```
GameContent/game.pck        # Test PCK file (29.43MB)
libgodot.xcframework/       # Custom engine binary
Assets.xcassets             # iOS app resources
```

## 🚀 Architecture Benefits

### Current Achievements
- **Clean implementation** using existing premium components
- **Minimal codebase** with maximum functionality
- **Consistent styling** via design token system
- **Easy maintenance** with modular architecture
- **Professional appearance** with glass design system

### Premium Component Readiness
- **50+ components available** for immediate integration
- **Atomic design hierarchy** ensures consistency
- **Battle-tested components** from existing library
- **Performance optimized** with component reuse
- **Easy extension** with familiar patterns

## 🎯 Phase 2 Integration Strategy

### Week-by-Week Enhancement Plan
```swift
// Week 1: Performance Dashboard
+ ModernMetricCard grid for bridge metrics
+ Real-time performance monitoring

// Week 2: System Health
+ ModernStatusCard collection for system status
+ Health monitoring integration

// Week 3: Interactive Controls  
+ ModernActionCard for bridge operations
+ Professional control interface

// Week 4: Enhanced Debugging
+ GlassDebugConsole for advanced logging
+ Professional debugger interface

// Week 5: Content Organization
+ GlassSectionHeader for clear sections
+ Enhanced information architecture
```

### Component Integration Pattern
```swift
// Each new component follows the same pattern:
1. Import from appropriate atomic layer
2. Integrate with existing managers (bridgeManager, pckManager)
3. Use Foundation design tokens for consistency
4. Apply Extensions modifiers for animations
5. Maintain the same clean, minimal approach
```

## 🔬 Development Workflow

### Current Workflow (Streamlined)
```
1. Open NativeBridge.xcodeproj
2. ContentView.swift - Clean 80-line implementation
3. Run on Simulator - Professional glass interface
4. ModernFloatingSidebar - Bridge operations
5. PhaseProgressCard - Status monitoring
```

### Phase 2 Workflow (Enhanced)
```
1. Same clean ContentView foundation
2. Add premium components incrementally
3. Maintain design token consistency
4. Test with existing bridge system
5. Professional development environment
```

## 📊 Success Metrics

### Code Quality Achieved
- **80 lines** vs 600+ custom implementation ✅
- **Premium components** throughout interface ✅  
- **Consistent styling** via design tokens ✅
- **Maintainable architecture** with clear separation ✅
- **Easy testing** with isolated components ✅

### User Experience Achieved
- **Professional appearance** with glass design ✅
- **Smooth animations** with spring physics ✅
- **Responsive design** adapting to devices ✅
- **Intuitive interface** with familiar patterns ✅
- **Performance optimized** rendering ✅

### Developer Experience Achieved
- **Quick development** with existing components ✅
- **Familiar patterns** across entire codebase ✅
- **Easy extension** with atomic design system ✅
- **Clear documentation** with usage examples ✅
- **Efficient workflow** with minimal code ✅

---
*Clean Premium Architecture: 80 lines + 50+ component library*  
*Next: Incremental Phase 2 enhancements with existing components*