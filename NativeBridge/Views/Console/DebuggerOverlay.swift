//
//  DebuggerOverlay.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


// DebuggerOverlay.swift

import SwiftUI

struct DebuggerOverlay: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Debugger")
                    .font(.headline)
                Spacer()
                Button(action: {
                    isVisible.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                }
            }
            
            Divider()
            
            ScrollView {
                ForEach(0..<20, id: \.self) { index in
                    Text("Log entry \(index)")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .frame(width: 320, height: 500)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(radius: 12)
        .opacity(isVisible ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: isVisible)
        .position(x: UIScreen.main.bounds.width - 200, y: 300)
    }
}
