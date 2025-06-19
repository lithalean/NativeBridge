//
//  iPhoneView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

struct iPhoneView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var navigationManager: ControllerNavigationManager
    @State private var selectedTab = 0
    @State private var showSplash = true
    @State private var isDrawerVisible = false
    
    @State private var debugMessages: [String] = [
        "✅ System initialized successfully",
        "🔄 Loading configuration...",
        "📦 Data fetched from API",
        "❌ Network timeout occurred",
        "🔄 Retrying connection..."
    ]
    
    init() {
        let bridgeManager = BridgeManager()
        _bridgeManager = StateObject(wrappedValue: bridgeManager)
        _navigationManager = StateObject(wrappedValue: ControllerNavigationManager(bridgeManager: bridgeManager))
    }
    
    var body: some View {
        ZStack {
            GlassColors.backgroundGradient.ignoresSafeArea()
            
            SystemDashboard(bridgeManager: bridgeManager)
                .padding(.horizontal, GlassConstants.screenPadding)
            
            VStack {
                TabBar(
                    selectedTab: $selectedTab,
                    bridgeManager: bridgeManager,
                    onToggleDrawer: {
                        withAnimation {
                            isDrawerVisible.toggle()
                        }
                    }
                )
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .zIndex(100)
            
            BottomDrawer(isVisible: $isDrawerVisible) {
                GlassDebugConsole(
                    messages: debugMessages,
                    onClear: {
                        debugMessages.removeAll()
                    }
                )
            }
            .zIndex(999)
            
            if showSplash {
                SplashScreen(
                    platformName: "iPhoneView",
                    components: [
                        ("Bridge", "gearshape"),
                        ("Nav", "arrow.left.and.right"),
                        ("Dashboard", "rectangle.grid.2x2")
                    ]
                )
                .transition(.opacity)
                .zIndex(1000)
                .onReceive(NotificationCenter.default.publisher(for: .splashDidFinish)) { _ in
                    withAnimation {
                        showSplash = false
                    }
                }
            }
        }
        .environmentObject(navigationManager)
        .onAppear {
            navigationManager.setupControllerNavigation()
        }
    }
}


#Preview {
    iPhoneView()
}
