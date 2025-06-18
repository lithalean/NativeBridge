//
//  Layout.swift
//  NativeBridge
//
//  WWDC 25 Glass Layout System - Modular Implementation
//  Note: GlassGrid and GlassSpacer already exist in LiquidGlassStyles.swift
//  This file provides EXTENSIONS and ADDITIONAL layout features only
//

import SwiftUI

// MARK: - Advanced Glass Grid System (Extensions to existing GlassGrid)

struct AdaptiveGlassGrid: View {
    let content: AnyView
    let compactColumns: Int
    let regularColumns: Int
    let spacing: CGFloat
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    init<Content: View>(
        compactColumns: Int = 1,
        regularColumns: Int = 2,
        spacing: CGFloat = DesignTokens.gridSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.compactColumns = compactColumns
        self.regularColumns = regularColumns
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        let columns = sizeClass == .compact ? compactColumns : regularColumns
        
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
            spacing: spacing
        ) {
            content
        }
    }
}

struct FlexibleGlassGrid: View {
    let content: AnyView
    let minItemWidth: CGFloat
    let spacing: CGFloat
    
    init<Content: View>(
        minItemWidth: CGFloat = 160,
        spacing: CGFloat = DesignTokens.gridSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.minItemWidth = minItemWidth
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        GeometryReader { geometry in
            let columns = max(1, Int(geometry.size.width / minItemWidth))
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
                spacing: spacing
            ) {
                content
            }
        }
    }
}

// MARK: - Enhanced Glass Spacing Components (Extensions to existing GlassSpacer)

struct AdaptiveGlassSpacer: View {
    let compactHeight: CGFloat
    let regularHeight: CGFloat
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    init(compact: CGFloat = DesignTokens.smallSpacing, regular: CGFloat = DesignTokens.mediumSpacing) {
        self.compactHeight = compact
        self.regularHeight = regular
    }
    
    var body: some View {
        let height = sizeClass == .compact ? compactHeight : regularHeight
        GlassSpacer(height: height)
    }
}

struct ResponsiveGlassSpacer: View {
    let baseHeight: CGFloat
    let scaleFactor: CGFloat
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    init(baseHeight: CGFloat = DesignTokens.mediumSpacing, scaleFactor: CGFloat = 1.5) {
        self.baseHeight = baseHeight
        self.scaleFactor = scaleFactor
    }
    
    var body: some View {
        let multiplier = (sizeClass == .regular && verticalSizeClass == .regular) ? scaleFactor : 1.0
        GlassSpacer(height: baseHeight * multiplier)
    }
}

// MARK: - Glass Container Components

struct GlassContainer: View {
    let content: AnyView
    let maxWidth: CGFloat?
    let alignment: HorizontalAlignment
    
    init<Content: View>(
        maxWidth: CGFloat? = nil,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) {
        self.maxWidth = maxWidth
        self.alignment = alignment
        self.content = AnyView(content())
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 0) {
            content
        }
        .frame(maxWidth: maxWidth)
    }
}

struct GlassSection: View {
    let title: String?
    let spacing: CGFloat
    let content: AnyView
    
    init<Content: View>(
        title: String? = nil,
        spacing: CGFloat = DesignTokens.mediumSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            if let title = title {
                Text(title)
                    .glassHeadline()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            content
        }
    }
}

struct GlassCard: View {
    let content: AnyView
    let style: CardStyle
    
    enum CardStyle {
        case floating, embedded, minimal
    }
    
    init<Content: View>(
        style: CardStyle = .floating,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = AnyView(content())
    }
    
    var body: some View {
        switch style {
        case .floating:
            content
                .glassPadding()
                .modifier(FloatingGlassCard()) // Use the modifier directly from LiquidGlassStyles
        case .embedded:
            content
                .glassPadding()
                .modifier(LiquidGlassCard()) // Use the modifier directly from LiquidGlassStyles
        case .minimal:
            content
                .glassPadding()
                .modifier(PureGlassOverlay()) // Use the modifier directly from LiquidGlassStyles
        }
    }
}

// MARK: - Glass Stack Components

struct GlassVStack: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    let content: AnyView
    
    init<Content: View>(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat = DesignTokens.mediumSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content
        }
    }
}

struct GlassHStack: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat
    let content: AnyView
    
    init<Content: View>(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat = DesignTokens.mediumSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = AnyView(content())
    }
    
    var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            content
        }
    }
}

// MARK: - Glass Scroll Components

struct GlassScrollView: View {
    let showsIndicators: Bool
    let content: AnyView
    
    init<Content: View>(
        showsIndicators: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.content = AnyView(content())
    }
    
    var body: some View {
        ScrollView(showsIndicators: showsIndicators) {
            LazyVStack(spacing: DesignTokens.mediumSpacing) {
                content
            }
            .glassPadding(.horizontal, DesignTokens.screenPadding)
            .glassPadding(.bottom, DesignTokens.xlSpacing)
        }
    }
}

// MARK: - Layout Modifiers

struct GlassPadding: ViewModifier {
    let edges: Edge.Set
    let amount: CGFloat
    
    init(_ edges: Edge.Set = .all, _ amount: CGFloat = DesignTokens.cardPadding) {
        self.edges = edges
        self.amount = amount
    }
    
    func body(content: Content) -> some View {
        content.padding(edges, amount)
    }
}

struct AdaptiveGlassPadding: ViewModifier {
    let edges: Edge.Set
    let compact: CGFloat
    let regular: CGFloat
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    init(_ edges: Edge.Set = .all, compact: CGFloat = DesignTokens.compactPadding, regular: CGFloat = DesignTokens.cardPadding) {
        self.edges = edges
        self.compact = compact
        self.regular = regular
    }
    
    func body(content: Content) -> some View {
        let amount = sizeClass == .compact ? compact : regular
        content.padding(edges, amount)
    }
}

struct GlassFrame: ViewModifier {
    let width: CGFloat?
    let height: CGFloat?
    let maxWidth: CGFloat?
    let maxHeight: CGFloat?
    let alignment: Alignment
    
    init(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) {
        self.width = width
        self.height = height
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.alignment = alignment
    }
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: width,
                height: height,
                alignment: alignment
            )
            .frame(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                alignment: alignment
            )
    }
}

// MARK: - Layout Extensions

extension View {
    // Padding helpers
    func glassPadding(_ edges: Edge.Set = .all, _ amount: CGFloat = DesignTokens.cardPadding) -> some View {
        modifier(GlassPadding(edges, amount))
    }
    
    func adaptiveGlassPadding(_ edges: Edge.Set = .all, compact: CGFloat = DesignTokens.compactPadding, regular: CGFloat = DesignTokens.cardPadding) -> some View {
        modifier(AdaptiveGlassPadding(edges, compact: compact, regular: regular))
    }
    
    // Frame helpers
    func glassFrame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        modifier(GlassFrame(width: width, height: height, maxWidth: maxWidth, maxHeight: maxHeight, alignment: alignment))
    }
    
    // Alignment helpers
    func glassLeading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func glassTrailing() -> some View {
        frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func glassCenter() -> some View {
        frame(maxWidth: .infinity, alignment: .center)
    }
    
    func glassTop() -> some View {
        frame(maxHeight: .infinity, alignment: .top)
    }
    
    func glassBottom() -> some View {
        frame(maxHeight: .infinity, alignment: .bottom)
    }
}

// MARK: - Layout Utilities

struct LayoutUtilities {
    static func optimalColumns(for width: CGFloat, itemWidth: CGFloat = 160) -> Int {
        max(1, Int(width / itemWidth))
    }
    
    static func adaptiveSpacing(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        ResponsiveDesign.spacing(for: sizeClass)
    }
    
    static func adaptivePadding(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        ResponsiveDesign.padding(for: sizeClass)
    }
    
    static func isCompact(_ sizeClass: UserInterfaceSizeClass?) -> Bool {
        sizeClass == .compact
    }
    
    static func gridColumns(for width: CGFloat, minItemWidth: CGFloat = 160, maxColumns: Int = 4) -> Int {
        min(maxColumns, max(1, Int(width / minItemWidth)))
    }
}
