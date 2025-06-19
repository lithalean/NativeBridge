//
//  DashboardBackground.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  DashboardBackground.swift
//  NativeBridge
//
//  Dashboard background with grid pattern and ambient glow effects

import SwiftUI

struct DashboardBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.05, green: 0.05, blue: 0.1),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            GridPattern()
            AmbientGlow()
        }
    }
}

// MARK: - Grid Pattern
struct GridPattern: View {
    var body: some View {
        Canvas { context, size in
            let gridSpacing: CGFloat = 40
            
            context.stroke(
                Path { path in
                    for x in stride(from: 0, through: size.width, by: gridSpacing) {
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for y in stride(from: 0, through: size.height, by: gridSpacing) {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                    }
                },
                with: .color(.white.opacity(0.02)),
                lineWidth: 0.5
            )
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Ambient Glow
struct AmbientGlow: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.blue.opacity(0.1), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .position(x: 200, y: 100)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 600, height: 600)
                .position(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100)
        }
        .allowsHitTesting(false)
    }
}