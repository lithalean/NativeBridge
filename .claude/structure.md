# NativeBridge Project Structure
*AI-focused project reference*

> **Last Updated**: June 18, 2025  
> **Status**: Phase 1 Complete ✅ | Atomic Glass Design ✅ | Custom Bridge ✅  

## 📁 Project Overview
```
NativeBridge/
├── .claude/                    # AI collaboration docs
├── NativeBridge/              # Main app
├── NativeBridge.xcodeproj     # Xcode project
├── libgodot.xcframework/      # Custom engine
├── GameContent/game.pck       # Test PCK ✅
└── ReadMe.md                  # Documentation
```

## 🏗️ App Structure
```
NativeBridge/NativeBridge/
├── Assets.xcassets            # Resources
├── NativeBridgeApp.swift      # App entry
├── Item.swift                 # Data model
│
├── Styles/                    # ATOMIC GLASS DESIGN SYSTEM
│   ├── LiquidGlassStyles.swift      # Main export (backward compatible)
│   ├── GlassDesignSystem/           # MODULAR SYSTEM (NEW)
│   │   ├── Foundation/              # Colors, Constants, Shapes
│   │   ├── Atomic/                  # Materials, Typography, Effects
│   │   ├── Molecular/               # Buttons, Indicators, Layout
│   │   └── Extensions/              # View modifiers
│   └── GlassComponents/             # ATOMIC COMPONENTS
│       ├── Foundation/              # Data structures
│       ├── Atomic/                  # Basic UI (Icon, Progress)
│       ├── Molecular/               # Compound (Headers, Sections)
│       ├── Organism/                # Complex (Cards, Metrics)
│       ├── Template/                # Layouts (Panels, Lists)
│       └── Pages/                   # Full sections (Sidebar, Console)
│
├── Views/
│   └── ContentView.swift      # Main UI (250 lines, uses atomic components)
│
├── Managers/                  # Bridge System
│   ├── BridgeManager.swift    # UI state + bridge coordination
│   ├── GodotEngineManager.swift # Engine operations
│   ├── PCKManager.swift       # Package detection
│   └── GodotBridge.swift      # Swift ↔ libgodot interface
│
└── Bridge/ (Phase 2)          # Future: Runtime integration
```

## 🎯 Key Achievements

### Atomic Glass Design
- **6-layer hierarchy**: Foundation → Atomic → Molecular → Organism → Template → Pages
- **50% code reduction**: ContentView now 250 lines (was 400+)
- **Modular components**: Reusable across entire app
- **Design tokens**: Consistent styling via GlassColors/GlassConstants

### Custom Bridge
- **Direct control**: Manual Swift ↔ libgodot implementation
- **Real operations**: PCK loading, file system access
- **Performance tracking**: Live metrics in glass UI

### Phase 1 Complete ✅
1. Atomic glass architecture operational
2. Custom bridge fully integrated
3. PCK loading functional
4. Real-time UI with bridge data
5. Ready for Phase 2 development

## 📋 Phase 2 Planning
```
Bridge/
├── Runtime/           # Engine runtime integration
├── MessagePassing/    # Enhanced communication
└── SceneIntegration/ # .tscn file support
```

## 🔍 Quick Reference

### Import Patterns
```swift
// Option 1: Legacy (all components)
import LiquidGlassStyles

// Option 2: Modular (specific components)
import GlassComponents.Organism.ModernStatusCard
import GlassDesignSystem.Foundation.GlassColors
```

### Component Usage
```swift
// Atomic components handle all UI complexity
ModernStatusCard(title: "Bridge", status: status, icon: "link")
GlassDebugConsole(messages: messages, onClear: { })
ModernFloatingSidebar(bridgeManager: manager, onClose: { })
```

### File Locations
- **Design System**: `Styles/GlassDesignSystem/`
- **Components**: `Styles/GlassComponents/`
- **Bridge Code**: `Managers/`
- **Test PCK**: `GameContent/game.pck`

---
*Atomic Glass: 6-layer component architecture*  
*Custom Bridge: Direct libgodot.xcframework control*  
*Next: Phase 2 runtime + scene integration*