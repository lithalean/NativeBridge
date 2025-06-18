//
//  GlassComponents.swift
//  NativeBridge
//
//  WWDC 25 Liquid Glass UI Components - Modular Design
//

import SwiftUI

// MARK: - Modern Status Card Component

struct ModernStatusCard: View {
    let title: String
    let status: ComponentStatus
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(status.isConnected ? GlassColors.success : GlassColors.error)
                
                Spacer()
                
                Circle()
                    .fill(status.isConnected ? GlassColors.success : GlassColors.error)
                    .frame(width: 8, height: 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(GlassColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(status.displayName)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(GlassColors.tertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
            }
        }
        .padding(GlassConstants.itemPadding)
        .floatingGlassCard()
    }
}

// MARK: - Modern Action Card Component

struct ModernActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(isEnabled ? color : .gray)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(isEnabled ? GlassColors.primary : .gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(subtitle)
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(isEnabled ? GlassColors.tertiary : .gray.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(GlassConstants.itemPadding)
        }
        .buttonStyle(GlassActionButton(isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

// MARK: - Modern Metric Card Component

struct ModernMetricCard: View {
    let title: String
    let value: String
    let trend: TrendDirection
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(GlassColors.info)
                
                Spacer()
                
                Text(trend.icon)
                    .font(.caption2)
                    .foregroundStyle(trend.color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(GlassColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(title)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(GlassColors.tertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(GlassConstants.itemPadding)
        .floatingGlassCard()
    }
}

// MARK: - Phase Progress Component

struct PhaseProgressCard: View {
    let title: String
    let subtitle: String
    let progress: Double
    let currentPhase: String
    
    var body: some View {
        VStack(spacing: 16) {
            // Title section
            VStack(spacing: 8) {
                Text(title)
                    .glassTitle()
                
                Text(subtitle)
                    .glassSubtitle()
            }
            .padding(.top, 8)
            
            // Progress section
            VStack(spacing: 16) {
                HStack {
                    Text("Development Progress")
                        .glassHeadline()
                    
                    Spacer()
                    
                    Text(currentPhase)
                        .glassStatusBadge(color: GlassColors.accent)
                }
                
                // Progress indicators
                HStack(spacing: 12) {
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 4)
                            .foregroundStyle(Double(index) < progress ? GlassColors.success : GlassColors.primary.opacity(0.3))
                    }
                }
                .glassSpringAnimation(trigger: progress > 0)
            }
        }
        .padding(GlassConstants.cardPadding)
        .liquidGlassCard()
    }
}

// MARK: - Section Header Component

struct GlassSectionHeader: View {
    let title: String
    let icon: String
    let iconColor: Color
    let trailing: AnyView?
    
    init(title: String, icon: String, iconColor: Color = GlassColors.accent, @ViewBuilder trailing: () -> some View = { EmptyView() }) {
        self.title = title
        self.icon = icon
        self.iconColor = iconColor
        self.trailing = AnyView(trailing())
    }
    
    var body: some View {
        HStack {
            Text(title)
                .glassHeadline()
            
            Spacer()
            
            if let trailing = trailing {
                trailing
            }
            
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(iconColor)
        }
    }
}

// MARK: - Sidebar Phase Row Component

struct ModernSidebarPhaseRow: View {
    let feature: SidebarFeature
    
    var body: some View {
        HStack(spacing: 16) {
            // Feature status with circular design
            ZStack {
                Circle()
                    .fill(feature.isComplete ? AnyShapeStyle(GlassColors.success.gradient) : AnyShapeStyle(.gray.opacity(0.2)))
                    .frame(width: 32, height: 32)
                
                Image(systemName: feature.isComplete ? "checkmark" : "circle")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(feature.isComplete ? GlassColors.primary : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.subheadline.weight(feature.isComplete ? .semibold : .medium))
                    .foregroundStyle(feature.isComplete ? GlassColors.primary : GlassColors.secondary)
                
                // Progress indicator for incomplete items
                if !feature.isComplete {
                    GlassProgressBar(progress: 0.3, color: GlassColors.accent)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, GlassConstants.itemPadding)
        .padding(.vertical, GlassConstants.compactPadding)
        .background(
            RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                .fill(feature.isComplete ? GlassColors.success.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: GlassConstants.mediumRadius)
                .stroke(feature.isComplete ? GlassColors.success.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

// MARK: - Floating Sidebar Component

struct ModernFloatingSidebar: View {
    let features: [SidebarFeature]
    let currentPhase: String
    let progress: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: GlassConstants.largeSpacing) {
                // Top spacing for floating design
                GlassSpacer(height: 40)
                
                // Development Control Card
                VStack(spacing: GlassConstants.mediumSpacing) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "hammer.circle.fill")
                            .font(.title)
                            .foregroundStyle(GlassColors.warning.gradient)
                        
                        VStack(alignment: .center, spacing: 2) {
                            Text("Development")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(GlassColors.primary)
                            Text("Phase Control")
                                .glassCaption()
                        }
                        
                        Spacer()
                    }
                    
                    // Current phase indicator
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(GlassColors.accent.gradient)
                            .frame(width: 4, height: 32)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Active Phase")
                                .glassCaption()
                            Text(currentPhase)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(GlassColors.primary)
                        }
                        
                        Spacer()
                        
                        Text(progress)
                            .glassStatusBadge(color: GlassColors.accent)
                    }
                }
                .padding(GlassConstants.largeSpacing)
                .pureGlassOverlay()
                
                // Features Card
                VStack(spacing: GlassConstants.mediumSpacing) {
                    GlassSectionHeader(
                        title: "Features",
                        icon: "list.bullet.circle",
                        iconColor: GlassColors.accent
                    )
                    
                    VStack(spacing: 8) {
                        ForEach(features, id: \.title) { feature in
                            ModernSidebarPhaseRow(feature: feature)
                        }
                    }
                }
                .padding(GlassConstants.largeSpacing)
                .pureGlassOverlay()
                
                // Bottom spacing
                GlassSpacer(height: 60)
            }
            .padding(.horizontal, GlassConstants.mediumSpacing)
        }
        .frame(maxHeight: .infinity)
        .glassFadeTransition()
    }
}

// MARK: - Debug Console Component

struct GlassDebugConsole: View {
    let messages: [String]
    let onClear: () -> Void
    
    var body: some View {
        VStack(spacing: GlassConstants.mediumSpacing) {
            HStack {
                Text("Debug Console")
                    .glassHeadline()
                
                Spacer()
                
                Button("Clear", action: onClear)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(GlassColors.accent)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(GlassColors.accent.opacity(0.2), in: Capsule())
                    .overlay(
                        Capsule()
                            .stroke(GlassColors.accent.opacity(0.5), lineWidth: 1)
                    )
            }
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 2) {
                    ForEach(messages.suffix(25), id: \.self) { message in
                        Text(message)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(getMessageColor(for: message))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(GlassConstants.itemPadding)
            }
            .frame(height: 160)
            .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: GlassConstants.compactPadding))
            .overlay(
                RoundedRectangle(cornerRadius: GlassConstants.compactPadding)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
        }
        .padding(GlassConstants.cardPadding)
        .liquidGlassCard()
    }
    
    private func getMessageColor(for message: String) -> Color {
        if message.contains("✅") {
            return GlassColors.success.opacity(0.8)
        } else if message.contains("❌") {
            return GlassColors.error.opacity(0.8)
        } else if message.contains("🔄") {
            return GlassColors.warning.opacity(0.8)
        } else if message.contains("📦") || message.contains("🎮") {
            return GlassColors.info.opacity(0.8)
        } else {
            return GlassColors.secondary
        }
    }
}

// MARK: - Supporting Types

struct ComponentStatus {
    let isConnected: Bool
    let displayName: String
}

enum TrendDirection {
    case up, down, stable
    
    var icon: String {
        switch self {
        case .up: return "↗"
        case .down: return "↘"
        case .stable: return "→"
        }
    }
    
    var color: Color {
        switch self {
        case .up: return GlassColors.success
        case .down: return GlassColors.error
        case .stable: return GlassColors.accent
        }
    }
}

struct SidebarFeature {
    let title: String
    let isComplete: Bool
}
