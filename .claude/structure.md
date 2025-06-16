# NativeBridge Project Structure
*Current folder and file organization for AI collaboration*

> **Location**: `/.claude/structure.md` - Live project structure reference  
> **Last Updated**: June 16, 2025  
> **Build Status**: Phase 1 Development - Basic SwiftUI App Structure  

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
- Basic SwiftUI app structure with NativeBridgeApp.swift
- Core data model with Item.swift
- Views/ directory for SwiftUI components
- Managers/ directory for business logic
- Styles/ directory for design system
- Assets.xcassets for visual resources
- App entitlements configured

📋 BRIDGE_COMPONENTS_NEEDED:
- Bridge/ directory (not yet created)
- GameEngine integration files
- SwiftGodotKit integration setup
- MessagePassing system
- BridgeManager implementation

🔍 NEXT_EXPLORATION_NEEDED:
- Contents of Views/ directory
- Contents of Managers/ directory
- Contents of Styles/ directory
- Current app functionality in NativeBridgeApp.swift
- Data model structure in Item.swift
```

## 📂 Detailed Directory Contents
```
Views/                          # SwiftUI view components
└── ContentView.swift           # Main content view

Managers/                       # Business logic managers  
└── PCKManager.swift            # PCK (Godot package) management

Styles/                         # Design system components
└── (empty directory)

Preview Content/                # Xcode preview assets
└── Preview Assets.xcassets     # Preview-specific assets
```

## 🔍 Key Files Analysis
```
CORE_APP_FILES:
✅ NativeBridgeApp.swift         # SwiftData app with ModelContainer setup
✅ Item.swift                    # SwiftData model (Foundation + SwiftData imports)
✅ ContentView.swift             # Main SwiftUI view
✅ PCKManager.swift              # Godot package manager - BRIDGE COMPONENT!
✅ NativeBridge.entitlements     # App permissions and capabilities

ASSET_SYSTEM:
✅ Assets.xcassets              # Main visual resources and app icons
✅ Preview Assets.xcassets      # Development preview assets (in Preview Content/)
```

## 🎯 Bridge Foundation Discovery
```
EXISTING_BRIDGE_COMPONENTS_FOUND:
✅ PCKManager.swift             # Already have Godot PCK management!
                                # This suggests bridge work has started

SWIFTDATA_INTEGRATION:
✅ Item.swift                   # SwiftData model for app data
✅ NativeBridgeApp.swift        # ModelContainer configuration
                                # Clean data layer ready for bridge state

CURRENT_ARCHITECTURE:
- SwiftData for persistent app state
- PCKManager for Godot package handling
- ContentView as main UI entry point
- Clean separation ready for bridge expansion
```

## 🚀 Phase 1 Implementation Gap Analysis
```
CURRENT_STATE: Standard SwiftUI app with organizational structure
PHASE_1_TARGET: Godot bridge integration with basic embedding

MISSING_COMPONENTS_FOR_PHASE_1:
1. Bridge/ directory with core bridge files
2. GameEngine.xcframework integration  
3. SwiftGodotKit dependency setup
4. GodotView component in Views/
5. BridgeManager in Managers/
6. Communication layer implementation

EXISTING_FOUNDATION_STRENGTHS:
✅ Clean organizational structure ready for bridge components
✅ Separate Managers/ for business logic (perfect for BridgeManager)  
✅ Views/ structure ready for GodotView components
✅ Styles/ system for consistent bridge UI design
✅ Proper app entitlements configuration
✅ Asset management system in place
```

## 🎯 Updated Implementation Status
```
ACTUAL_CURRENT_STATE: SwiftData app with Godot PCK management foundation

✅ IMPLEMENTED:
- SwiftData app architecture with ModelContainer
- PCKManager.swift - Godot package management (BRIDGE FOUNDATION!)
- ContentView.swift - Main SwiftUI interface
- Clean organizational structure
- Asset management system

🚧 BRIDGE_COMPONENTS_IN_PROGRESS:
- PCKManager.swift exists - need to examine contents
- Basic app structure ready for bridge expansion

📋 PHASE_1_STILL_NEEDED:
- Bridge/ directory with core communication layer
- GameEngine.xcframework integration
- GodotView component for embedding
- BridgeManager to coordinate with PCKManager
- Swift ↔ Godot message passing system

🔍 IMMEDIATE_EXPLORATION_PRIORITY:
- Examine PCKManager.swift contents - this is key bridge foundation
- Check ContentView.swift for current UI structure
- Understand Item.swift data model for bridge state integration
```

## 🚀 Next Development Phase
```
PHASE_1_FOUNDATION_STATUS: Better than expected!
- PCKManager suggests Godot integration work has begun
- SwiftData provides clean state management for bridge
- Organizational structure perfect for bridge expansion

IMMEDIATE_NEXT_STEPS:
1. Examine PCKManager.swift - understand current Godot integration
2. Review ContentView.swift - see current UI architecture  
3. Plan BridgeManager to work with existing PCKManager
4. Add GodotView to Views/ directory
5. Integrate GameEngine.xcframework with existing foundation
```

---
*Auto-generated structure reference for Claude.ai collaboration*  
*To update: Run structure scan or manually edit based on current development*