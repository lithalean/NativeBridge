# NativeBridge — Project Context

---

## Project Goal

Porting JENOVA Framework (C++ Godot) to DarwinArm64 (macOS / iOS).  
Embedding into Xcode project to enable full SwiftUI / WWDC25 native UI.  
Goal: WWDC25 architecture + LiquidGlass adoption + modern UIKit.  
Single codebase with platform detection — adaptive UI for all devices.

---

## Current Status (June 19, 2025)

✅ Phase 1 UI: Locked — WWDC25 style  
✅ iPhoneView.swift: Complete  
⬜ iPadView.swift: In progress  
⬜ MacView.swift: In progress  
⬜ TVView.swift: In progress  

---

## Phase 1 Architecture

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

## Current UX (Phase 1)

- TabBar (floating — Apple TV style — top of screen)
- BottomDrawer (Debugger Dock — floating, draggable — with grabber)
- SystemDashboard (main content)
- GlassDebugConsole (inside BottomDrawer)
- SplashScreen (transition with LiquidGlass)

---

## Next Steps

⬜ Generate iPadView.swift  
⬜ Organize folders (final pass)  
⬜ Verify MacView and TVView  
⬜ Clean preview files  

---

## Notes

Phase 1 UI now fully locked.  
Architecture matches WWDC25 "Quiet Geometry", "Hierarchy of Components", and LiquidGlass adoption.  
All core components are modular and reusable.  
Navigation logic and feature lists now use separate models (enum vs struct) per WWDC25 best practices.

---
