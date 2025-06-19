//
//  SystemDashboard.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  SystemDashboard.swift
//  NativeBridge
//
//  Main dashboard component for system performance monitoring

import SwiftUI

struct SystemDashboard: View {
    @ObservedObject var bridgeManager: BridgeManager
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.xlSpacing) {
                GlassSpacer(.vertical, size: 100)
                
                // System Status View
                SystemStatusView(bridgeManager: bridgeManager)
                
                GlassSpacer(.vertical, size: GlassConstants.xlSpacing)
            }
        }
    }
}

// MARK: - System Status View
struct SystemStatusView: View {
    @ObservedObject var bridgeManager: BridgeManager
    
    var body: some View {
        VStack(spacing: 30) {
            Text("System Performance Monitor")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Metrics Grid
            MetricsGrid(bridgeManager: bridgeManager)
        }
    }
}