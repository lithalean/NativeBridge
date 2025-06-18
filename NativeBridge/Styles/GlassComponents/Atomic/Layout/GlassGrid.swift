//
//  GlassGrid.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//


//
//  GlassGrid.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

/// A simple configurable grid with Glass styling — replaces old GlassGrid.
public struct GlassGrid<Content: View>: View {
    let columns: [GridItem]
    let spacing: CGFloat
    let content: () -> Content
    
    public init(columns: Int = 2, spacing: CGFloat = GlassConstants.gridSpacing, @ViewBuilder content: @escaping () -> Content) {
        self.columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            content()
        }
    }
}
