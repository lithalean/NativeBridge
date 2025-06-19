//
//  MetricsGrid.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  MetricsGrid.swift
//  NativeBridge
//
//  Grid layout for system performance metrics

import SwiftUI

struct MetricsGrid: View {
    @ObservedObject var bridgeManager: BridgeManager
    @EnvironmentObject var navigationManager: ControllerNavigationManager
    
    var body: some View {
        let coreCount = ProcessInfo.processInfo.processorCount
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        
        LazyVGrid(columns: gridColumns(for: coreCount, isIPad: isIPad), spacing: 20) {
            // Processor Core Rings
            ForEach(0..<min(coreCount, isIPad ? 8 : 6), id: \.self) { core in
                ProcessorCoreRing(
                    coreNumber: core,
                    usage: Double.random(in: 0.1...0.9), // Simulated - replace with real data
                    frequency: Double.random(in: 2.0...3.5) // GHz
                )
            }
            
            // System Metrics with Selection State
            MetricRing(
                title: "Bridge",
                icon: "link.circle",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .cyan,
                isSelected: navigationManager.selectedButton == 0
            )
            
            MetricRing(
                title: "Engine",
                icon: "engine.combustion",
                isActive: bridgeManager.isEngineConnected,
                progress: bridgeManager.isEngineConnected ? 1.0 : 0.0,
                color: .green,
                isSelected: navigationManager.selectedButton == 1
            )
            
            MetricRing(
                title: "PCK",
                icon: "folder.badge.gearshape",
                isActive: bridgeManager.isPCKLoaded,
                progress: bridgeManager.isPCKLoaded ? 1.0 : 0.0,
                color: .blue,
                isSelected: navigationManager.selectedButton == 2
            )
            
            // Controller Metric Ring
            MetricRing(
                title: "Controller",
                icon: "gamecontroller.fill",
                isActive: bridgeManager.controllerManager.isControllerConnected,
                progress: bridgeManager.controllerManager.isControllerConnected ? 1.0 : 0.0,
                color: .mint,
                valueText: bridgeManager.controllerManager.isControllerConnected ?
                    "\(bridgeManager.controllerManager.connectedControllers.count)" : "0",
                isSelected: navigationManager.selectedButton == 3
            )
            
            MetricRing(
                title: "Memory",
                icon: "memorychip",
                isActive: true,
                progress: min(bridgeManager.bridgeMetrics.memoryUsage / 100, 1.0),
                color: .orange,
                valueText: String(format: "%.0f MB", bridgeManager.bridgeMetrics.memoryUsage),
                isSelected: navigationManager.selectedButton == 4
            )
            
            MetricRing(
                title: "GPU",
                icon: "cpu.fill",
                isActive: bridgeManager.isEngineConnected,
                progress: Double.random(in: 0.3...0.8), // Simulated GPU usage
                color: .purple,
                valueText: "Metal",
                isSelected: navigationManager.selectedButton == 5
            )
            
            MetricRing(
                title: "Latency",
                icon: "wifi",
                isActive: bridgeManager.isEngineConnected,
                progress: max(0.0, 1.0 - (bridgeManager.bridgeMetrics.bridgeLatency / 20.0)),
                color: .indigo,
                valueText: String(format: "%.1f ms", bridgeManager.bridgeMetrics.bridgeLatency),
                isSelected: navigationManager.selectedButton == 6
            )
        }
    }
    
    private func gridColumns(for coreCount: Int, isIPad: Bool) -> [GridItem] {
        let columns = isIPad ? 6 : 4
        return Array(repeating: GridItem(.flexible()), count: columns)
    }
}