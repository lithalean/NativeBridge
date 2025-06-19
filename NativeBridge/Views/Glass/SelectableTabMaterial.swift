//
//  SelectableTabMaterial.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/19/25.
//


// SelectableTabMaterial.swift
// Matches your AdvancedMaterials system — for TabBar buttons

import SwiftUI

public struct SelectableTabMaterial: ViewModifier {
    let isSelected: Bool
    
    public init(isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    public func body(content: Content) -> some View {
        if isSelected {
            content
                .modifier(FloatingGlassMaterial(cornerRadius: 40, shadowRadius: 6))
        } else {
            content
                .modifier(UltraGlassMaterial())
        }
    }
}
