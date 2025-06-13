//
//  ContentView.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/11/25.
//


//
//  ContentView.swift
//  DarwinHost
//
//  Created by Tyler Allen on 6/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var pckManager = PCKManager()
    @State private var showDebugInfo = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Godot Logo/Icon
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                // Status Section
                VStack(spacing: 15) {
                    Text("Godot Game")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    // Godot Engine Status (always loaded since it's bundled)
                    StatusRow(
                        icon: "checkmark.circle.fill",
                        text: "Godot Engine: Loaded",
                        color: .green
                    )
                    
                    // PCK Status
                    switch pckManager.status {
                    case .loading:
                        HStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                            Text("Checking for game content...")
                                .foregroundColor(.gray)
                        }
                        
                    case .found:
                        VStack(spacing: 10) {
                            StatusRow(
                                icon: "checkmark.circle.fill",
                                text: "Game Content: Found",
                                color: .green
                            )
                            
                            Text("✅ Ready for integration!")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                            
                            Button("Launch Game") {
                                launchGodotGame()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                        }
                        
                    case .notFound:
                        VStack(spacing: 10) {
                            StatusRow(
                                icon: "xmark.circle.fill",
                                text: "Game Content: Not Found",
                                color: .orange
                            )
                            
                            if !pckManager.errorMessage.isEmpty {
                                Text(pckManager.errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            
                            Button("Retry") {
                                pckManager.checkForPCK()
                            }
                            .buttonStyle(.bordered)
                        }
                        
                    case .error:
                        VStack(spacing: 10) {
                            StatusRow(
                                icon: "exclamationmark.circle.fill",
                                text: "Error",
                                color: .red
                            )
                            
                            Text(pckManager.errorMessage)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            
                            Button("Retry") {
                                pckManager.checkForPCK()
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                
                Spacer()
                
                // Debug Section
                VStack(spacing: 8) {
                    Button(action: {
                        showDebugInfo.toggle()
                        if showDebugInfo {
                            pckManager.debugBundleContents()
                        }
                    }) {
                        HStack {
                            Text("Debug Info")
                                .font(.caption)
                                .bold()
                            Image(systemName: showDebugInfo ? "chevron.up" : "chevron.down")
                                .font(.caption2)
                        }
                        .foregroundColor(.gray)
                    }
                    
                    if showDebugInfo {
                        VStack(spacing: 4) {
                            if !pckManager.detectedPath.isEmpty {
                                Text("Expected Path:")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(pckManager.detectedPath)
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                                    .multilineTextAlignment(.center)
                                    .textSelection(.enabled)
                            }
                            
                            if !pckManager.debugInfo.isEmpty {
                                Divider()
                                    .background(Color.gray.opacity(0.3))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    ForEach(pckManager.debugInfo, id: \.self) { info in
                                        Text(info)
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding()
        }
        .onAppear {
            pckManager.checkForPCK()
        }
    }
    
    private func launchGodotGame() {
        print("🎮 Ready to launch Godot game!")
        print("📦 PCK Path: \(pckManager.detectedPath)")
        print("🔧 Godot Engine: Available (libgot.a)")
        
        // Placeholder for actual Godot integration
        // GodotEngine.shared.loadGame(pckPath: pckManager.detectedPath)
    }
}

// MARK: - Helper Views

struct StatusRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
                .foregroundColor(color)
                .font(.subheadline)
        }
    }
}

#Preview {
    ContentView()
}
