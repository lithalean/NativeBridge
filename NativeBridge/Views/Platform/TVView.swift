//
//  TVView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

struct TVView: View {
    @StateObject private var bridgeManager = BridgeManager()
    @StateObject private var navigationManager: ControllerNavigationManager
    @State private var selectedTab = 0
    @State private var showSplash = true
    
    init() {
        let bridgeManager = BridgeManager()
        _bridgeManager = StateObject(wrappedValue: bridgeManager)
        _navigationManager = StateObject(wrappedValue: ControllerNavigationManager(bridgeManager: bridgeManager))
    }
    
    var body: some View {
        ZStack {
            GlassColors.backgroundGradient.ignoresSafeArea()
            
            HStack {
                // Example: FloatingSidebar on TV
                ModernFloatingSidebar(bridgeManager: bridgeManager)
                    .frame(width: 300)
                
                Spacer()
            }
            
            // Splash
            if showSplash {
                SplashScreen(
                    platformName: "TVView",
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
