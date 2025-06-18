//
//  GlassSpacer.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// A simple spacer with optional fixed height or width — matching Apple HIG spacings.
public struct GlassSpacer: View {
    public enum Axis {
        case vertical
        case horizontal
    }
    
    let axis: Axis
    let size: CGFloat?
    
    public init(_ axis: Axis = .vertical, size: CGFloat? = nil) {
        self.axis = axis
        self.size = size
    }
    
    public var body: some View {
        Group {
            if axis == .vertical {
                Spacer()
                    .frame(height: size)
            } else {
                Spacer()
                    .frame(width: size)
            }
        }
    }
}
