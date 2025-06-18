//
//  DesignTokens.swift
//  NativeBridge
//
//  WWDC 25 Glass Design Token System - Modular Implementation
//  Note: GlassConstants already exists in LiquidGlassStyles.swift
//

import SwiftUI

// MARK: - Enhanced Design Tokens

struct DesignTokens {
    // MARK: - Spacing System
    static let tightSpacing: CGFloat = 4
    static let smallSpacing: CGFloat = 8
    static let mediumSpacing: CGFloat = 16
    static let largeSpacing: CGFloat = 24
    static let xlSpacing: CGFloat = 32
    static let xxlSpacing: CGFloat = 48
    
    // MARK: - Padding System
    static let compactPadding: CGFloat = 8
    static let itemPadding: CGFloat = 12
    static let cardPadding: CGFloat = 16
    static let sectionPadding: CGFloat = 20
    static let screenPadding: CGFloat = 24
    
    // MARK: - Corner Radius System
    static let tightRadius: CGFloat = 8
    static let smallRadius: CGFloat = 12
    static let cornerRadius: CGFloat = 16  // Default
    static let mediumRadius: CGFloat = 16
    static let largeRadius: CGFloat = 20
    static let xlRadius: CGFloat = 24
    static let xxlRadius: CGFloat = 32
    
    // MARK: - Animation System
    static let fastAnimation: Double = 0.1
    static let quickAnimation: Double = 0.2
    static let mediumAnimation: Double = 0.3
    static let slowAnimation: Double = 0.4
    static let longAnimation: Double = 0.6
    
    // MARK: - Spring Physics
    static let tightSpring = Animation.spring(response: 0.3, dampingFraction: 0.9)
    static let mediumSpring = Animation.spring(response: 0.4, dampingFraction: 0.8)
    static let bouncySpring = Animation.spring(response: 0.6, dampingFraction: 0.7)
    static let gentleSpring = Animation.spring(response: 0.8, dampingFraction: 0.8)
    
    // MARK: - Shadow System
    static let lightShadow: CGFloat = 2
    static let mediumShadow: CGFloat = 4
    static let heavyShadow: CGFloat = 8
    static let dramaticShadow: CGFloat = 12
    
    // MARK: - Opacity System
    static let faintOpacity: Double = 0.1
    static let lightOpacity: Double = 0.2
    static let mediumOpacity: Double = 0.4
    static let strongOpacity: Double = 0.6
    static let heavyOpacity: Double = 0.8
    
    // MARK: - Size System
    static let iconSizeSmall: CGFloat = 16
    static let iconSizeMedium: CGFloat = 20
    static let iconSizeLarge: CGFloat = 24
    static let iconSizeXL: CGFloat = 32
    
    static let buttonHeightCompact: CGFloat = 32
    static let buttonHeightMedium: CGFloat = 44
    static let buttonHeightLarge: CGFloat = 56
    
    // MARK: - Grid System
    static let gridSpacing: CGFloat = 12
    static let gridColumns2 = Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: 2)
    static let gridColumns3 = Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: 3)
    static let gridColumns4 = Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: 4)
    
    // MARK: - Layout Helpers
    static func centeredIfAppropriate(_ condition: Bool) -> Alignment {
        condition ? .center : .leading
    }
    
    static func adaptiveSpacing(compact: CGFloat, regular: CGFloat) -> CGFloat {
        // Could be enhanced with actual size class detection
        regular
    }
    
    static func adaptiveRadius(compact: CGFloat, regular: CGFloat) -> CGFloat {
        // Could be enhanced with actual size class detection
        regular
    }
}

// MARK: - Extended Glass Constants (Additional values not in LiquidGlassStyles)

extension GlassConstants {
    // Extended corner radius options
    static let tightRadius = DesignTokens.tightRadius
    static let xxlRadius = DesignTokens.xxlRadius
    
    // Extended spacing options
    static let tightSpacing = DesignTokens.tightSpacing
    static let xxlSpacing = DesignTokens.xxlSpacing
    
    // New padding options
    static let sectionPadding = DesignTokens.sectionPadding
    static let screenPadding = DesignTokens.screenPadding
    
    // Animation enhancements
    static let quickAnimation = DesignTokens.quickAnimation
    static let longAnimation = DesignTokens.longAnimation
    
    // Shadow system
    static let lightShadow = DesignTokens.lightShadow
    static let heavyShadow = DesignTokens.heavyShadow
    static let dramaticShadow = DesignTokens.dramaticShadow
}

// MARK: - Responsive Design Helpers

struct ResponsiveDesign {
    static func spacing(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        switch sizeClass {
        case .compact:
            return DesignTokens.smallSpacing
        case .regular, .none:
            return DesignTokens.mediumSpacing
        @unknown default:
            return DesignTokens.mediumSpacing
        }
    }
    
    static func padding(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        switch sizeClass {
        case .compact:
            return DesignTokens.compactPadding
        case .regular, .none:
            return DesignTokens.cardPadding
        @unknown default:
            return DesignTokens.cardPadding
        }
    }
    
    static func cornerRadius(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        switch sizeClass {
        case .compact:
            return DesignTokens.smallRadius
        case .regular, .none:
            return DesignTokens.mediumRadius
        @unknown default:
            return DesignTokens.mediumRadius
        }
    }
}

// MARK: - View Extensions for Design Tokens

extension View {
    // Spacing helpers
    func tokenSpacing(_ size: DesignTokens.SpacingSize = .medium) -> some View {
        switch size {
        case .tight:
            return self.padding(DesignTokens.tightSpacing)
        case .small:
            return self.padding(DesignTokens.smallSpacing)
        case .medium:
            return self.padding(DesignTokens.mediumSpacing)
        case .large:
            return self.padding(DesignTokens.largeSpacing)
        case .xl:
            return self.padding(DesignTokens.xlSpacing)
        }
    }
    
    // Animation helpers
    func tokenAnimation(_ speed: DesignTokens.AnimationSpeed = .medium) -> some View {
        switch speed {
        case .fast:
            return self.animation(.easeInOut(duration: DesignTokens.fastAnimation), value: true)
        case .medium:
            return self.animation(.easeInOut(duration: DesignTokens.mediumAnimation), value: true)
        case .slow:
            return self.animation(.easeInOut(duration: DesignTokens.slowAnimation), value: true)
        }
    }
    
    func tokenSpring(_ type: DesignTokens.SpringType = .medium) -> some View {
        switch type {
        case .tight:
            return self.animation(DesignTokens.tightSpring, value: true)
        case .medium:
            return self.animation(DesignTokens.mediumSpring, value: true)
        case .bouncy:
            return self.animation(DesignTokens.bouncySpring, value: true)
        case .gentle:
            return self.animation(DesignTokens.gentleSpring, value: true)
        }
    }
}

// MARK: - Token Enums

extension DesignTokens {
    enum SpacingSize {
        case tight, small, medium, large, xl
    }
    
    enum AnimationSpeed {
        case fast, medium, slow
    }
    
    enum SpringType {
        case tight, medium, bouncy, gentle
    }
}
