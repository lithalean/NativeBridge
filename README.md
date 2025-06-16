# NativeBridge
*An Open Source, modern Darwin ARM64 Bridge Technology Development following WWDC25 iPadOS Design Principles*

![Platform Support](https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20iPadOS-blue)
![Swift Version](https://img.shields.io/badge/swift-5.9+-orange)
![iOS Version](https://img.shields.io/badge/iOS-18.0+-green)
![License](https://img.shields.io/badge/license-MIT-blue)

## ✨ Current Status: **IN DEVELOPMENT (Phase 1: Foundation Bridge)**

## 🎯 Project Vision

Building a **production-ready bridge technology** that seamlessly connects Darwin ARM64 Native UIKits with GameEngine and EngineRuntime. This dual-layer development platform enables SwiftUI developers to create powerful game experiences while maintaining native iOS performance and development workflows.

The bridge features a sophisticated development environment with production export capabilities! 🎉

### 🚀 **What's Working Right Now:**
- ✅ **xcframework Simulator Support** - Resolved compatibility issues with development workflow
- ✅ **SwiftGodotKit Integration** - Primary Swift ↔ Godot bridge dependency added
- ✅ **Clean Project Structure** - Organized development vs production architecture
- ✅ **Build System Foundation** - Xcode project with proper linking configuration
- ✅ **Core Architecture Design** - Development/Production split with clear separation
- ✅ **Technology Stack Integration** - GameEngine + EngineRuntime + SwiftGodotKit unified

## Features

### 🎨 **Bridge Technology Stack**
- **SwiftUI Development Environment** - Bridge APIs, debugging tools, testing suite, runtime management
- **NativeBridge Communication** - Bidirectional Swift ↔ Godot message passing with memory safety
- **GameEngine Integration** - Darwin ARM64 optimized Godot fork with Jenova compatibility
- **Performance Monitoring** - Real-time profiling dashboard with frame rate analysis
- **Export Tools** - Production-ready components for DarwinHost deployment

### 🧠 **Darwin ARM64 Developer-Focused Design**
- **Native Performance** - ARM64 specific optimizations with <5ms bridge latency
- **Hot-Reload Development** - Live bridge changes with <5s debug cycle
- **Type-Safe Bindings** - Automatic Swift wrapper generation from Godot classes
- **Memory Management** - Efficient pools with <10MB bridge overhead
- **Professional Tooling** - Visual debugger, scene inspector, performance analyzer

### 💾 **Development vs Production Architecture**
- **NativeBridge (Development)** - Bridge technology building with integration tooling
- **DarwinHost (Production)** - Stable bridge exports for shipped games
- **Dual-Purpose Design** - Developer-focused features with production optimization
- **Clean Separation** - Development dependencies isolated from end-user experience
- **Export Pipeline** - Seamless transition from development to production deployment

### 🔧 **Modern Integration Stack**
- **SwiftGodotKit** - Primary Swift ↔ Godot communication layer
- **GameEngine xcframework** - Debug builds with simulator support
- **EngineRuntime** - C++ scripting with hot-reload capabilities
- **Performance Optimization** - Darwin ARM64 specific enhancements
- **Memory Safety** - Automatic marshaling with error propagation

### 📱 **Cross-Platform Bridge Design**
- **iPhone/iPad** - Native SwiftUI with embedded Godot scenes
- **Mac Catalyst** - Desktop development environment with full tooling
- **Simulator Support** - Complete development workflow on Apple Silicon
- **Production Export** - Optimized builds for App Store distribution

## Current Implementation Status

### ✅ **Phase 1: Foundation Bridge - IN PROGRESS**
- [x] xcframework simulator support resolution
- [x] SwiftGodotKit dependency integration
- [ ] Basic Godot app embedding implementation
- [ ] SwiftUI wrapper components creation
- [ ] Basic scene loading and testing
- [ ] Swift → Godot message passing system

### 📋 **Phase 2: Advanced Bridge APIs - PLANNED**
- [ ] **Runtime Management**: Dynamic GameEngine loading with hot-reload integration
- [ ] **Developer Tools**: Real-time debugging interface with performance dashboard
- [ ] **Bridge API Framework**: Type-safe Swift → C++ bindings with async/await
- [ ] **Memory Management**: Pool optimization with resource lifecycle handling
- [ ] **Error Handling**: Propagation system with comprehensive logging

### 🔮 **Phase 3: Performance & Optimization - PLANNED**
- [ ] **Darwin ARM64 Optimization**: Platform-specific performance enhancements
- [ ] **Advanced Features**: Multi-scene management with asset streaming
- [ ] **Testing & Validation**: Automated integration tests with performance regression
- [ ] **Production Readiness**: Memory leak detection with stress testing suite

### 🚀 **Phase 4: Developer Experience - PLANNED**
- [ ] **Development Tools**: Visual bridge debugger with real-time scene inspector
- [ ] **Code Generation**: Swift wrapper generation with automatic binding creation
- [ ] **Integration Helpers**: Xcode templates with build script automation
- [ ] **CI/CD Integration**: Deployment tools with automated testing pipeline

## Installation & Setup

### Prerequisites
- **Xcode 15.0+** with iOS 18.0+ SDK
- **Swift 5.9+** for modern language features
- **Darwin ARM64** architecture (Apple Silicon optimized)
- **CMake/Ninja** for build system optimization
- **Python 3.10+** for automation scripts

### Quick Start
```bash
# Install required tools
brew install cmake ninja python3
xcode-select --install

# Clone required repositories
git clone https://github.com/lithalean/NativeBridge.git
git clone https://github.com/lithalean/GameEngine.git  
git clone https://github.com/lithalean/EngineRuntime.git

# Open development environment
cd NativeBridge
open NativeBridge.xcodeproj
```

**Build and run** for development:
- **iPhone Simulator**: Primary development target
- **iPad Simulator**: Testing larger screen bridge layouts
- **Mac Catalyst**: Full development tooling environment

## Usage

### 🎯 **Getting Started**
1. **Open Xcode project** - NativeBridge.xcodeproj with all dependencies configured
2. **Select iPhone Simulator** - Primary development and testing target
3. **Build and run** - Verify Godot scene loads in SwiftUI container

### ⌨️ **Development Workflow**
- **Bridge Testing**: Build (⌘+B) and run basic bridge functionality
- **Scene Loading**: Test Godot scene embedding in SwiftUI views
- **Hot-Reload**: Live bridge changes with <5s debug cycle
- **Performance Monitoring**: Real-time profiling with Instruments integration
- **Export Testing**: Validate production bridge component generation

### 🖥️ **Platform-Specific Features**
- **iPhone/iPad**: Native SwiftUI with embedded Godot gameplay
- **Mac Catalyst**: Full development environment with debugging tools
- **Simulator**: Complete development workflow on Apple Silicon

### 💾 **Bridge Architecture**
- **Development Focus**: Bridge technology building with integration tooling
- **Production Export**: Stable APIs for DarwinHost integration
- **Memory Safety**: Automatic data marshaling with error propagation
- **Performance**: <5ms latency with <10MB bridge overhead

## Technical Architecture

### Bridge Technology Stack
- **SwiftGodotKit** - Primary Swift ↔ Godot communication layer
- **GameEngine xcframework** - Darwin ARM64 optimized Godot with Jenova compatibility
- **EngineRuntime** - C++ scripting runtime with hot-reload capabilities
- **Bridge APIs** - Type-safe bindings with automatic marshaling
- **Performance Monitoring** - Real-time profiling with memory management

### Key Components
```
NativeBridge/
├── Bridge/
│   ├── SwiftGodotBridge/     # Primary communication layer
│   ├── MessagePassing/       # Swift ↔ Godot messaging
│   ├── TypeSafety/           # Automatic marshaling system
│   └── ErrorHandling/        # Propagation and logging
├── Development/
│   ├── DebugTools/           # Visual bridge debugger
│   ├── Performance/          # Real-time profiling
│   ├── Testing/              # Integration test suite
│   └── HotReload/            # Live development workflow
├── Production/
│   ├── ExportAPIs/           # DarwinHost integration
│   ├── Optimization/         # ARM64 performance tuning
│   ├── Deployment/           # Build and distribution
│   └── Documentation/        # API reference and guides
└── Integration/
    ├── GameEngine/           # xcframework integration
    ├── EngineRuntime/        # C++ scripting support
    ├── SwiftGodotKit/        # Primary dependency
    └── Tooling/              # Development automation
```

### Design Patterns
- **Bridge Pattern** - Clean separation between SwiftUI and Godot layers
- **Development/Production Split** - Separate concerns for development vs deployment
- **Type-Safe Bindings** - Automatic Swift wrapper generation with compile-time safety
- **Hot-Reload Architecture** - Live development workflow with state preservation

## Development Roadmap

### 🔜 **Next Up (Phase 1 Completion)**
1. **Basic Godot Embedding**: SwiftUI wrapper components for Godot scenes
2. **Message Passing**: Bidirectional Swift ↔ Godot communication
3. **Memory Safety**: Automatic data marshaling with error handling
4. **Scene Loading**: Basic Godot scene integration and testing
5. **Build Optimization**: Debug/release configurations with proper linking

### 🎯 **Medium Term (Phase 2)**
1. **Runtime Management**: Dynamic GameEngine loading with hot-reload integration
2. **Developer Tools**: Real-time debugging interface with performance dashboard
3. **Advanced APIs**: Type-safe Swift → C++ bindings with async/await support
4. **Memory Optimization**: Pool management with resource lifecycle handling
5. **Testing Framework**: Automated integration tests with validation suite

### 🚀 **Long Term (Phase 3+)**
1. **Production Optimization**: Darwin ARM64 specific performance enhancements
2. **Advanced Features**: Multi-scene management with asset streaming capabilities
3. **Developer Experience**: Visual bridge debugger with code generation tools
4. **DarwinHost Integration**: Stable bridge exports for production game deployment
5. **Community Tools**: Xcode templates, CI/CD integration, and automation

## 🤖 Claude.ai Integration

> **For AI Collaboration**: This project uses Claude.ai assistance for bridge architecture decisions, Swift ↔ C++ interop optimization, and cross-platform integration strategies. The `.claude/` directory contains detailed context files for AI collaboration continuity.

**Quick Context**: Bridge technology development connecting SwiftUI native experiences with GameEngine/EngineRuntime, featuring dual-layer architecture optimized for Darwin ARM64 with production export capabilities.

## 🤖 AI Collaboration
- 🏗️ **Architecture**: Bridge pattern implementation, development/production separation
- 🔧 **Integration**: Swift ↔ Godot communication, memory safety, performance optimization
- ⚡ **Performance**: ARM64 optimization, latency reduction, memory management
- 📋 **Planning**: Phase-based development, technology stack integration, export pipeline

## 🤖 AI Collaboration Files
- **Context**: See `.claude/context.md` for project state and decisions
- **Structure**: See `.claude/structure.md` for current file organization
- **Key Discovery**: PCKManager.swift contains existing Godot bridge foundation

## Success Metrics & Performance Targets

### **Technical Performance**
- **Bridge Overhead**: <5ms latency for Swift ↔ Godot calls
- **Memory Efficiency**: <10MB overhead for bridge layer
- **Build Time**: <30s full rebuild for development workflow
- **Runtime Loading**: <2s GameEngine initialization

### **Developer Experience**
- **Setup Time**: <10 minutes from clone to running
- **Debug Cycle**: <5s hot-reload for bridge changes
- **API Coverage**: 90%+ of Godot features accessible from Swift
- **Documentation**: 100% API coverage with comprehensive examples

### **Integration Quality**
- **Stability**: Zero crashes during normal development workflow
- **Compatibility**: Works with all GameEngine + EngineRuntime versions
- **Testing**: 95%+ code coverage with automated test suite
- **Performance**: Matches native Godot performance within 5%

## Dependencies & Technology Stack

### **Core Bridge Dependencies**
- **[SwiftGodotKit](https://github.com/migueldeicaza/SwiftGodot)** - Primary Swift ↔ Godot bridge
- **GameEngine** - Darwin ARM64 optimized Godot fork with Jenova compatibility
- **EngineRuntime** - C++ scripting runtime with hot-reload capabilities
- **libgodot.xcframework** - Debug build with simulator support

### **Development Tools**
- **Swift 5.9+** - Primary development language with modern features
- **Xcode 15+** - IDE and build system integration
- **LLVM/Clang** - C++ compilation and cross-language tooling
- **CMake/Ninja** - Build system optimization and automation

### **Testing & Quality Assurance**
- **XCTest** - Unit and integration testing framework
- **Instruments** - Performance profiling and memory analysis
- **Static Analysis** - Code quality checks and security validation
- **CI/CD Pipeline** - Automated testing and deployment

## Project Relationships

### **NativeBridge → DarwinHost**
- Exports stable bridge framework for production games
- Provides performance-optimized components for deployment
- Delivers type-safe APIs for game integration

### **NativeBridge → GameEngine**
- Consumes engine as xcframework dependency
- Tests engine stability and performance characteristics
- Provides feedback for engine improvements and optimization

### **NativeBridge → EngineRuntime**
- Integrates C++ scripting capabilities with hot-reload
- Leverages runtime features for development workflow
- Provides Swift bindings for runtime functionality

## License

NativeBridge is released under the MIT License. See [LICENSE](LICENSE) for details.

## Acknowledgments

- **SwiftGodot Team** for the foundational Swift ↔ Godot bridge technology
- **Godot Engine Team** for the robust game engine foundation
- **Apple Swift Team** for advanced language features and ARM64 optimization
- **Darwin ARM64 Community** for performance optimization insights and patterns
- **GameEngine Contributors** for engine improvements and Jenova compatibility
- **Claude.ai** for architectural guidance and bridge technology assistance