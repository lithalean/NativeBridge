# Claude.ai Development Context
*AI Collaboration State for NativeBridge*

> **Location**: `/.claude/context.md` - Main AI collaboration context file

## 🎯 Project DNA
**Type**: Darwin ARM64 Bridge Technology Development  
**Architecture**: Dual-Layer (SwiftUI Development + GameEngine Integration)  
**Platforms**: iOS/iPadOS/macOS with Simulator Support  
**Design Language**: High-performance bridge with native development workflow  
**Current Phase**: Phase 1 - Foundation Bridge  
**Build Status**: IN DEVELOPMENT (Phase 1 Sprint Active)  

## 🧠 Core Architecture Decisions Made
```
DECISION_LOG:
[Initial] - Development vs Production split: NativeBridge (dev) vs DarwinHost (prod)
[Initial] - SwiftGodotKit as primary bridge technology foundation
[Phase 1] - xcframework simulator support resolution completed
[Phase 1] - Clean project structure with separated concerns
[Phase 1] - Bridge pattern for Swift ↔ Godot communication
[Planning] - Type-safe bindings with automatic marshaling
[Planning] - <5ms latency target with <10MB memory overhead
[June 16] - Modern WWDC 25 UI design with responsive layouts implemented
[June 16] - Slide-out sidebar with glassmorphism and spring animations
```

## 🏗️ Technical Stack State
```swift
// Current Architecture Pattern
┌─────────────────────────────────────────┐
│ SwiftUI Development Environment         │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐     │
│ │ Bridge  │ │ Tools   │ │ Testing │     │
│ │ APIs    │ │ Debug   │ │ Suite   │     │
│ └─────────┘ └─────────┘ └─────────┘     │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐     │
│ │ Runtime │ │ Perf    │ │ Export  │     │
│ │ Manager │ │ Monitor │ │ Tools   │     │
│ └─────────┘ └─────────┘ └─────────┘     │
└─────────────────────────────────────────┘
                    ↕ NativeBridge
┌─────────────────────────────────────────┐
│ GameEngine + EngineRuntime Integration  │
│ ┌─────────────────────────────────┐     │
│ │ Bridge Technology Stack         │     │
│ │ • SwiftGodot bindings           │     │
│ │ • C++ interop layer             │     │
│ │ • Memory management             │     │
│ │ • Performance optimization      │     │
│ └─────────────────────────────────┘     │
│                                         │
└─────────────────────────────────────────┘

// Bridge Components
NativeBridge/
├── Bridge/              # Core communication layer
├── Development/         # Dev tools and debugging
├── Production/          # Export and optimization
└── Integration/         # External dependencies
```

## 🎨 Design System Implemented
- **Bridge-First Architecture**: Clean separation between SwiftUI and Godot layers
- **Development/Production Split**: Separate tooling for development vs deployment
- **Type Safety**: Automatic Swift wrapper generation with compile-time checks
- **Performance Focus**: <5ms latency with <10MB memory overhead targets
- **Hot-Reload Workflow**: Live development with <5s debug cycle
- **Native Integration**: SwiftUI development patterns with Godot performance
- **WWDC 25 Design Standards**: Modern UI with glassmorphism, responsive layouts, spring animations

## 📊 Current Implementation Matrix
```
FEATURE_STATUS_MATRIX:
✅ COMPLETE     🚧 IN_PROGRESS     📋 PLANNED     ❌ BLOCKED

Phase 1: Foundation Bridge (Current Sprint):
✅ xcframework Simulator Support    ✅ SwiftGodotKit Integration    ✅ Clean Project Structure
✅ Modern WWDC 25 UI Design         ✅ Responsive Layout System     ✅ Slide-out Sidebar Navigation
🚧 Basic Godot App Embedding       📋 SwiftUI Wrapper Components  📋 Basic Scene Loading
📋 Swift → Godot Messaging         📋 Build System Configuration  📋 Communication Layer

Phase 2: Advanced Bridge APIs:
📋 Runtime Management              📋 Developer Tools              📋 Bridge API Framework
📋 Memory Pool Management          📋 Type-Safe Bindings           📋 Error Propagation

Phase 3: Performance & Optimization:
📋 Darwin ARM64 Optimization       📋 Advanced Features            📋 Testing & Validation
📋 Multi-Scene Management          📋 Asset Streaming              📋 Production Readiness

Phase 4: Developer Experience:
📋 Development Tools               📋 Code Generation               📋 Integration Helpers
📋 Visual Bridge Debugger          📋 Xcode Templates              📋 CI/CD Integration
```

## 🔧 Known Technical Debt
```
HIGH_PRIORITY:
- Basic Godot App Embedding: Core bridge functionality not yet implemented
- SwiftUI Wrapper Components: Need component library for Godot scene integration
- Build System Configuration: Debug/release configs need proper GameEngine linking

MEDIUM_PRIORITY:
- Message Passing System: Bidirectional Swift ↔ Godot communication incomplete
- Memory Safety: Automatic marshaling system needs implementation
- Error Handling: Comprehensive logging and propagation system needed

PERFORMANCE_OPTIMIZATION:
- Bridge latency optimization for <5ms target achievement
- Memory management optimization for <10MB overhead limit
- Hot-reload performance tuning for <5s debug cycle target

COMPLETED_RECENT (June 16):
✅ Modern WWDC 25 sidebar design with capsule styling and glassmorphism
✅ Slide-out sidebar interaction with spring animations and material backgrounds
✅ Landscape/portrait layout fixes for simulator consistency and proper centering
✅ Floating toggle button with proper positioning to avoid icon overlap
✅ Responsive design system with gradient styling and smooth transitions
```

## 🎯 Next Development Priorities
```
IMMEDIATE (This Week):
1. Basic Godot App Embedding - Core bridge functionality implementation - [COMPLEXITY: HIGH]
2. SwiftUI Wrapper Components - Godot scene container views - [COMPLEXITY: MEDIUM]
3. Basic Scene Loading - Test integration with simple Godot scenes - [COMPLEXITY: MEDIUM]

SHORT_TERM (This Month):
1. Swift → Godot Message Passing - Bidirectional communication system
2. Build System Configuration - Debug/release with proper linking
3. Memory Safety Implementation - Automatic data marshaling system

ARCHITECTURAL_DECISIONS_NEEDED:
- Message Passing Protocol: Direct C++ calls vs message queue for Swift ↔ Godot
- Memory Management: Automatic vs manual lifecycle for bridge objects
- Scene Integration: Embedded views vs full-screen takeover for Godot content
```

## 🐛 Bug Tracking & Issues
```
CRITICAL:
- GameEngine xcframework linking issues in some build configurations | Test all targets | Blocks basic functionality

HIGH:
- SwiftGodotKit integration warnings in Xcode | Update dependency configuration | Development workflow friction

MEDIUM:
- Simulator performance slower than device | Profile bridge overhead | Developer experience issue

RESOLVED_RECENT (June 16):
✅ Simulator landscape UI not displaying properly | Fixed with GeometryReader and responsive layouts
✅ Sidebar icon overlap issues | Resolved with proper spacing and centered content
✅ Toggle button positioning conflicts | Fixed with floating button and material backgrounds

ENHANCEMENT_REQUESTS:
- Real-time bridge performance monitoring | Visual debugging interface for message passing
- Automatic Swift wrapper generation | Code generation tools for Godot classes
```

## 🧪 Testing Strategy State
```
UNIT_TESTS:
- Bridge communication: 0% (not implemented yet)
- SwiftUI components: 0% (not implemented yet)
- Memory management: 0% (not implemented yet)

INTEGRATION_TESTS:
- Basic scene loading: Manual testing only
- Performance benchmarks: Not implemented
- Memory leak detection: Not implemented

PLATFORM_TESTS:
- iPhone Simulator: Primary development target ✅
- iPad Simulator: Basic compatibility needed
- Mac Catalyst: Full tooling environment testing needed

UI_TESTING:
✅ Landscape/Portrait responsive layouts working correctly
✅ Sidebar slide-out animations and interactions tested
✅ WWDC 25 design standards implemented and verified
```

## 🚀 Release Planning Context
```
CURRENT_VERSION: 0.1.0-alpha
TARGET_VERSION: 0.2.0-alpha (Phase 1 Complete)
RELEASE_TIMELINE: Q2 2025

PHASE_1_COMPLETE_CHECKLIST:
✅ Modern UI design with WWDC 25 standards implemented
✅ Responsive layout system for all orientations
□ Basic Godot app embedding functional
□ SwiftUI wrapper components implemented
□ Basic scene loading and testing complete
□ Swift → Godot message passing working
□ Build system properly configured

KNOWN_RISKS:
- SwiftGodotKit dependency stability: May need fallback C++ interop layer
- Performance targets: Bridge overhead optimization challenging
- GameEngine integration: Version compatibility across updates
```

## 📚 Key Patterns & Conventions Established
```swift
// File Organization Pattern
NativeBridge/
├── Bridge/              // Core bridge technology
├── Development/         // Dev tools and debugging
├── Production/          // Export and optimization
├── Integration/         // External dependencies
└── Tests/               // Testing and validation

// Naming Conventions
- Bridge Components: [Feature]Bridge.swift
- SwiftUI Wrappers: Godot[Component]View.swift
- Message Passing: [Direction]Message.swift
- Performance: [Feature]Profiler.swift

// Architecture Patterns
- Bridge pattern for clean layer separation
- Development/Production split for concern separation
- Type-safe bindings with automatic generation
- Hot-reload friendly with state preservation

// UI Design Patterns (June 16)
- WWDC 25 design standards with glassmorphism
- Responsive layouts using GeometryReader
- Spring animations for smooth interactions
- Material backgrounds and gradient accents
- Floating UI elements with proper spacing
```

## 🔄 AI Collaboration History
```
LAST_SESSION_FOCUS: Modern UI design implementation with WWDC 25 standards
DECISIONS_MADE: 
- Implemented slide-out sidebar with capsule styling and material backgrounds
- Fixed landscape/portrait layout issues with responsive design
- Added spring animations and proper content centering
- Resolved toggle button positioning and icon overlap issues

CODE_GENERATED: 
- Complete ContentView.swift rewrite with modern design system
- ModernPhaseRow component with gradient styling and progress bars
- Responsive layout logic with GeometryReader and proper centering
- Material design implementation with glassmorphism effects

NEXT_SESSION_PREP: Begin implementation of basic Godot app embedding with SwiftUI integration

RECURRING_AI_ASSISTANCE_AREAS:
- Bridge architecture design and Swift ↔ C++ interop optimization
- SwiftGodotKit integration strategies and performance tuning
- Memory management and type safety in cross-language communication
- Development