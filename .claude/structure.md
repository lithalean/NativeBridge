# NativeBridge — Folder Structure (Phase 1 — WWDC25)

---

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

# Notes

- Phase 1: Follows WWDC25 "Quiet Geometry", "Hierarchy of Components", LiquidGlass adoption.
- Folder structure will remain stable as iPadView, MacView, TVView are finalized.
