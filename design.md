# NativeBridge — Phase 1 UI (WWDC25 style)

---

## Overall Architecture

- Porting JENOVA Framework (C++ Godot) to DarwinArm64 (macOS / iOS)
- Embedding into Xcode project to enable full SwiftUI / WWDC25 native UI
- Goal: WWDC25 architecture + LiquidGlass adoption + modern UIKit
- Single codebase with platform detection — adaptive UI for all devices
- **Design Philosophy**: Same Beauty, Platform-Appropriate Functionality

---

## Platform Views Status

- ✅ **iPhoneView.swift** → Complete — WWDC25 mobile interface with beautiful, simplified components
- ⬜ **iPadView.swift** → In progress — Hybrid approach (some enhanced features)
- ✅ **MacView.swift** → Complete — Professional desktop interface with enhanced components
- ⬜ **TVView.swift** → In progress — Focus-based navigation

---

## Component Architecture Philosophy

### Enhanced vs. Simple Component Distinction

**Enhanced Components (Mac Only):**
- Complex multi-panel management
- Advanced keyboard shortcuts (⌘1, ⌘2, ⌘3)
- Professional IDE features
- Desktop-class file management
- Sophisticated debugging tools
- Multi-workspace coordination

**Simple Components (iPhone/iPad):**
- Same visual beauty and polish
- Touch-optimized interactions
- Simplified functionality
- Gesture-based navigation
- Single-focus workflows
- Essential features only

**Shared Design DNA:**
- Identical LiquidGlass materials
- Same color system and gradients
- Consistent animation timing
- Professional typography
- WWDC25 design language throughout

---

## iPhone SwiftUI Design Architecture (June 21, 2025)

### Core Layout Philosophy

**Mobile-First Layered System:**
- **Base Layer**: Beautiful animated mesh gradient background
- **Content Layer**: Touch-optimized content with smooth transitions
- **Navigation Layer**: Floating tab bar with capsule design
- **Drawer Layer**: Gesture-controlled bottom drawer
- **Splash Layer**: Professional component loading sequence (Phase 2 — fixed portrait)

### Workspace System (Simple Components)

**Simple Script Editors:**
- **Swift Editor** (`iPhoneSwiftScriptEditor`):
  - Beautiful orange-themed header with gradient background
  - Professional line numbers with proper alignment
  - Touch-optimized controls (32pt buttons)
  - Same glass materials as Mac
  - Simplified run/save functionality

- **C++ Editor** (`iPhoneCppScriptEditor`):
  - Beautiful blue-themed header with gradient background
  - Professional line numbers with proper alignment
  - Touch-optimized controls (32pt buttons)
  - Same glass materials as Mac
  - Simplified build functionality

- **3D Viewport** (`iPhone3DViewport`):
  - Touch-optimized gizmo controls
  - Menu-based view mode selection
  - Simplified object interaction
  - Beautiful visual styling matching Mac

**Key Differences from Mac Enhanced:**
- ❌ No complex keyboard shortcuts
- ❌ No multi-panel coordination
- ❌ No advanced debugging features
- ✅ Touch-first interaction design
- ✅ Simplified but complete functionality
- ✅ Same visual excellence

### Beautiful Splash Screen (Updated — June 21, 2025)

**Professional Loading Sequence (Phase 2 — Portrait Only):**
- Fixed **portrait-only layout** (8 components, 3 rows)
- Animated mesh gradient background (5 colors)
- Spring-animated logo with beautiful shadows
- 3-Row Component Grid:
  - Row 1: 3 components  
  - Row 2: 3 components  
  - Row 3: 2 components
- Auto-sized component tiles (fills screen properly)
- NO grid collapse or wrapping (portrait lock)
- Haptic feedback integration (light)
- Professional branding ("Godot Engine for iPhone")
- Matches WWDC25 "quiet geometry" design language

### Mobile-Specific Optimizations

**Touch Interface:**
- 44px minimum touch targets (Apple HIG compliance)
- Gesture-based drawer controls
- One-handed usage patterns
- Haptic feedback on all interactions

---

**Component Modularity:**
- `iPhoneView+TabBar.swift` - Tab navigation
- `iPhoneView+BottomDrawer.swift` - Console/Performance/Network
- `iPhoneView+Workspace.swift` - Simple workspace management
- `iPhoneView+InspectorSettings.swift` - Compact controls
- `iPhoneView+SwiftScriptEditor.swift` - Simple Swift editor
- `iPhoneView+CppScriptEditor.swift` - Simple C++ editor
- `iPhoneView+3DViewport.swift` - Touch-optimized 3D interface
- `iPhoneView+Splash.swift` - Professional splash screen (Phase 2 — portrait fixed)

---

## macOS SwiftUI Design Architecture (June 21, 2025)

[UNCHANGED — use your existing version]