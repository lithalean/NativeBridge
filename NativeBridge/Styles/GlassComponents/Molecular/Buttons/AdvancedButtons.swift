//
//  AdvancedButtons.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

// MARK: - GlassButtons Library

public struct GlassButtons {

    // MARK: ModernGlassButton
    
    public struct ModernGlassButton: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.headline)
                .padding(.horizontal, GlassConstants.mediumSpacing)
                .padding(.vertical, GlassConstants.smallSpacing)
                .background(GlassConstants.toolbarGlassMaterial)
                .cornerRadius(GlassConstants.mediumRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                        .strokeBorder(.thinMaterial, lineWidth: 1)
                )
                .shadow(radius: configuration.isPressed ? 2 : 8)
                .opacity(configuration.isPressed ? 0.85 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                .animation(.spring(response: GlassConstants.springResponse,
                                   dampingFraction: GlassConstants.springDamping), value: configuration.isPressed)
        }
    }

    // MARK: CircularGlassButton
    
    public struct CircularGlassButton: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(GlassConstants.toolbarGlassMaterial)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(.thinMaterial, lineWidth: 1)
                )
                .shadow(radius: configuration.isPressed ? 2 : 6)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .animation(.spring(response: GlassConstants.springResponse,
                                   dampingFraction: GlassConstants.springDamping), value: configuration.isPressed)
        }
    }

    // MARK: ActionCardButton
    
    public struct ActionCardButton: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.subheadline)
                .padding()
                .background(GlassConstants.cardGlassMaterial)
                .cornerRadius(GlassConstants.largeRadius)
                .shadow(radius: configuration.isPressed ? 3 : 10)
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
                .animation(.spring(response: GlassConstants.springResponse,
                                   dampingFraction: GlassConstants.springDamping), value: configuration.isPressed)
        }
    }

    // MARK: FloatingActionButton
    
    public struct FloatingActionButton: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.headline)
                .frame(width: 56, height: 56)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: configuration.isPressed ? 6 : 12)
                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
                .animation(.spring(response: GlassConstants.springResponse,
                                   dampingFraction: GlassConstants.springDamping), value: configuration.isPressed)
        }
    }

    // MARK: MinimalGlassButton
    
    public struct MinimalGlassButton: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.callout)
                .padding(.horizontal, GlassConstants.tightSpacing)
                .padding(.vertical, GlassConstants.tightSpacing)
                .background(GlassConstants.toolbarGlassMaterial.opacity(0.6))
                .cornerRadius(GlassConstants.smallRadius)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
        }
    }

}

