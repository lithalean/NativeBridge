//
//  SplashScreen.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


// SplashScreen.swift
// Final version — WWDC25 style — icons — matches Dashboard

import SwiftUI

struct SplashScreen: View {
    let platformName: String
    let components: [(name: String, icon: String)]
    
    @State private var componentProgress: [Double]
    @State private var componentColor: [Color]
    
    init(platformName: String, components: [(name: String, icon: String)]) {
        self.platformName = platformName
        self.components = components
        
        _componentProgress = State(initialValue: Array(repeating: 0.0, count: components.count))
        _componentColor = State(initialValue: Array(repeating: .red, count: components.count))
    }
    
    var body: some View {
        ZStack {
            GlassColors.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("NativeBridge")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                
                Text("Transitioning to \(platformName)...")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white.opacity(0.7))
                
                // Metric Rings Grid
                HStack(spacing: 16) {
                    ForEach(components.indices, id: \.self) { index in
                        MetricRing(
                            title: components[index].name,
                            icon: components[index].icon,
                            isActive: componentProgress[index] >= 1.0,
                            progress: componentProgress[index],
                            color: componentColor[index],
                            valueText: nil,
                            isSelected: false
                        )
                        .frame(width: 70, height: 90)
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
            .padding(40)
            .modifier(FloatingGlassMaterial(cornerRadius: GlassConstants.largeRadius, shadowRadius: 16))
            .padding(.horizontal, 40)
        }
        .onAppear {
            animateComponents()
        }
    }
    
    private func animateComponents() {
        for index in components.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    componentProgress[index] = 0.5
                    componentColor[index] = .yellow
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.8 + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        componentProgress[index] = 1.0
                        componentColor[index] = .green
                        
                        if componentProgress.allSatisfy({ $0 >= 1.0 }) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                NotificationCenter.default.post(name: .splashDidFinish, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen(
        platformName: "Preview",
        components: [
            ("Bridge", "gearshape"),
            ("Nav", "arrow.left.and.right"),
            ("Dashboard", "rectangle.grid.2x2")
        ]
    )
}
