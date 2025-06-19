//
//  BottomDrawer.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//

import SwiftUI

struct BottomDrawer<Content: View>: View {
    @Binding var isVisible: Bool
    let content: Content
    
    @GestureState private var dragOffset: CGFloat = 0
    
    init(isVisible: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isVisible = isVisible
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let drawerHeight: CGFloat = min(height * 0.5, 300)
            
            VStack {
                Spacer()
                
                VStack(spacing: 8) {
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 40, height: 6)
                        .padding(.top, 8)
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    withAnimation {
                                        isVisible.toggle()
                                    }
                                }
                        )
                    
                    content
                        .padding(.top, 8)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                }
                .frame(width: geometry.size.width)
                .modifier(LiquidGlassMaterial(cornerRadius: GlassConstants.largeRadius))
                .offset(y: isVisible ? dragOffset : (drawerHeight + 60))
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = max(value.translation.height, 0)
                        }
                        .onEnded { value in
                            withAnimation {
                                if value.translation.height > 100 {
                                    isVisible = false
                                } else {
                                    isVisible = true
                                }
                            }
                        }
                )
                .transition(.move(edge: .bottom))
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isVisible)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
