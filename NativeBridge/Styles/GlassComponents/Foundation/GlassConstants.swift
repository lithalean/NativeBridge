//
//  GlassConstants.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/18/25.
//

import SwiftUI

public struct GlassConstants {

    // MARK: - Radii
    public static let smallRadius: CGFloat = 12
    public static let mediumRadius: CGFloat = 16
    public static let largeRadius: CGFloat = 20
    public static let xlRadius: CGFloat = 24
    public static let tightRadius: CGFloat = 8
    public static let xxlRadius: CGFloat = 32
    
    // MARK: - Spacing
    public static let tightSpacing: CGFloat = 4
    public static let smallSpacing: CGFloat = 8
    public static let mediumSpacing: CGFloat = 16
    public static let largeSpacing: CGFloat = 24
    public static let xlSpacing: CGFloat = 32
    public static let xxlSpacing: CGFloat = 48
    
    // MARK: - Layout Constants
    public static let screenPadding: CGFloat = 20
    public static let cardPadding: CGFloat = 16
    public static let gridSpacing: CGFloat = 12
    
    // MARK: - Item Padding
    public static let itemPadding: CGFloat = 12
    public static let compactPadding: CGFloat = 8
    
    // MARK: - Spring Animation Constants
    public static let springResponse: CGFloat = 0.4
    public static let springDamping: CGFloat = 0.7
    
    // MARK: - Animation Durations

    public static let fastAnimation: Double = 0.15
    public static let mediumAnimation: Double = 0.3
    public static let slowAnimation: Double = 0.5
    
    // MARK: - Liquid Glass Materials (WWDC25)
    public static let toolbarGlassMaterial = Material.bar
    public static let cardGlassMaterial = Material.regularMaterial
    public static let chromeGlassMaterial = Material.thickMaterial
}
