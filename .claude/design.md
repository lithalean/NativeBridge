# NativeBridge — Phase 1 UI (WWDC25 style)

---

## Overall Architecture

- Porting JENOVA Framework (C++ Godot) to DarwinArm64 (macOS / iOS)
- Embedding into Xcode project to enable full SwiftUI / WWDC25 native UI
- Goal: WWDC25 architecture + LiquidGlass adoption + modern UIKit
- Single codebase with platform detection — adaptive UI for all devices

---

## Platform Views

- iPhoneView.swift → Complete — Phase 1 UI locked
- iPadView.swift → In progress
- MacView.swift → In progress
- TVView.swift → In progress

---

## Common Components

- TabBar.swift → replaces Left Sidebar (Apple TV style floating TabBar)
- BottomDrawer.swift → replaces Right Sidebar (Debugger Dock — floating, draggable)
- SystemDashboard.swift → main content
- GlassDebugConsole.swift → now lives inside BottomDrawer
- ModernFloatingSidebar.swift → remains for MacView / TVView
- SplashScreen.swift → used for transitions

---

## LiquidGlass Usage

- LiquidGlassMaterial (custom modifier — WWDC25 style)
    - Used in TabBar
    - Used in BottomDrawer
    - Used in ModernFloatingSidebar

---

## Interaction

- TabBar:
    - Start Engine
    - Establish Bridge
    - Load PCK
    - Phase buttons (ModernSidebarPhaseRow)
    - Feature buttons (SidebarFeatureTabView)
    - Toggle Debugger button → opens/closes BottomDrawer

- BottomDrawer:
    - Contains GlassDebugConsole
    - Grabber for drag gesture (Apple WWDC25 pattern)
    - Animates with spring
    - Z-index controlled (always on top)

---

## Current File Structure

Views/
├── Components/
│   ├── BottomDrawer.swift
│   ├── GlassDebugConsole.swift
│   ├── ModernFloatingSidebar.swift
│   ├── ModernSidebarPhaseRow.swift
│   ├── SidebarFeatureView.swift (FloatingSidebar)
├── Navigation/
│   ├── TabBar.swift
│   ├── SidebarFeatureTabView.swift (TabBar)
├── Platform/
│   ├── iPhoneView.swift
│   ├── iPadView.swift
│   ├── MacView.swift
│   ├── TVView.swift
├── Shared/
│   ├── SplashScreen.swift

Models/
├── Components/
│   ├── SidebarFeatureModel.swift
├── Navigation/
│   ├── SidebarFeature.swift (enum for TabBar)

Materials/
├── LiquidGlassMaterial.swift
├── FloatingGlassMaterial.swift
├── AdvancedMaterials.swift

Styles/
├── GlassColors.swift
├── GlassConstants.swift

Managers/
├── BridgeManager.swift
├── ControllerNavigationManager.swift

Dashboards/
├── SystemDashboard.swift
├── DashboardBackground.swift
├── MetricsGrid.swift

---

## Remaining Tasks (Phase 1)

✅ Fix TabBar size and concentric shape  
✅ Fix BottomDrawer visibility + gestures  
✅ Fix zIndex issues (done)  
✅ Fix SidebarFeature dual model split (done)  
✅ Finalize iPhoneView.swift (done)  
⬜ Generate iPadView.swift  
⬜ Organize folders (final pass)  
⬜ Verify MacView and TVView  
⬜ Clean preview files

---

✅ Phase 1 UI now fully locks WWDC25 style  
✅ 1 source of truth per component (SidebarFeature vs SidebarFeatureModel)  
✅ Follows Apple "Hierarchy of Components" + "Quiet Geometry" + LiquidGlass adoption.

---
