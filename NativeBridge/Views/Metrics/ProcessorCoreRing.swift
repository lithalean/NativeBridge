//
//  ProcessorCoreRing.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


//
//  ProcessorCoreRing.swift
//  NativeBridge
//
//  CPU core performance visualization ring

import SwiftUI

struct ProcessorCoreRing: View {
    let coreNumber: Int
    let usage: Double
    let frequency: Double
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: usage)
                    .stroke(coreColor(for: usage), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: usage)
                
                VStack(spacing: 1) {
                    Text("C\(coreNumber)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(Int(usage * 100))%")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(String(format: "%.1f GHz", frequency))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    private func coreColor(for usage: Double) -> Color {
        switch usage {
        case 0.8...:
            return .red
        case 0.6...:
            return .orange
        case 0.4...:
            return .yellow
        default:
            return .green
        }
    }
}