//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/17/25.
//
//  WWDC25 STYLE - Multi-Platform Coordinator

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea() // prevent first-frame glitch
            
            contentView
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.6), value: hSizeClass)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        #if os(tvOS)
        TVView()
        #elseif os(macOS)
        MacView()
        #else
            if hSizeClass == .compact {
                iPhoneView()
            } else {
                iPadView()
            }
        #endif
    }
}

#Preview {
    ContentView()
}
