//
//  PopMenuAppearance.swift
//  PopMenu
//
//  Created by Cali Castle on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

#if os(macOS)
public typealias Color = NSColor
#else
public typealias Color = UIColor
#endif

/// Appearance for PopMenu.
/// Use for configuring custom styles and looks.
final public class PopMenuAppearance: NSObject {
    
    /// Background and tint colors.
    public var popMenuColor: PopMenuColor = .default()
    
    /// Background style.
    public var popMenuBackgroundStyle: PopMenuBackgroundStyle = .dimmed(color: .black, opacity: 0.4)
    
    /// The font for labels.
    public var popMenuFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    /// Corner radius for rounded corners.
    public var popMenuCornerRadius: CGFloat = 24
    
    /// How tall each action is.
    public var popMenuActionHeight: CGFloat = 50
    
    /// The separator style for each action.
    public var popMenuItemSeparator: PopMenuActionSeparator = .none()

    /// The status bar style of the pop menu.
    public var popMenuStatusBarStyle: UIStatusBarStyle?

}

/// Background styles for PopMenu.
public struct PopMenuBackgroundStyle {
    
    // MARK: - Dimmed Style
    
    /// Determines is the style in dimmed mode.
    public let isDimmed: Bool?
    
    /// If dimmed, store the dim color.
    public let dimColor: Color?
    
    /// If dimmed, store the dim opacity.
    public let dimOpacity: CGFloat?
    
    // MARK: - Blur Style
    
    /// Determines is the style in blur mode.
    public let isBlurred: Bool?
    
    /// If blurred, store the blur style.
    public let blurStyle: UIBlurEffectStyle?
    
    // MARK: - Initializers
    
    /// Quick setter for dimmed mode.
    public static func dimmed(color: Color, opacity: CGFloat) -> PopMenuBackgroundStyle {
        return PopMenuBackgroundStyle(isDimmed: true, dimColor: color, dimOpacity: opacity, isBlurred: nil, blurStyle: nil)
    }
    
    /// Quick setter for blurred mode.
    public static func blurred(_ style: UIBlurEffectStyle) -> PopMenuBackgroundStyle{
        return PopMenuBackgroundStyle(isDimmed: nil, dimColor: nil, dimOpacity: nil, isBlurred: true, blurStyle: style)
    }
    
    /// No background style.
    public static func none() -> PopMenuBackgroundStyle{
        return PopMenuBackgroundStyle(isDimmed: nil, dimColor: nil, dimOpacity: nil, isBlurred: nil, blurStyle: nil)
    }
    
}

/// Color structure for PopMenu color styles.
public struct PopMenuColor {
    
    /// Background color instance.
    public var backgroundColor: PopMenuActionBackgroundColor
    
    /// Action tint color instance.
    public var actionColor: PopMenuActionColor
    
    /// Compose the color.
    public static func configure(background: PopMenuActionBackgroundColor, action: PopMenuActionColor) -> PopMenuColor {
        return PopMenuColor(backgroundColor: background, actionColor: action)
    }
    
    /// Get default background and action color.
    public static func `default`() -> PopMenuColor {
        return PopMenuColor(backgroundColor: .gradient(fill: #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1), #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)), actionColor: .tint(.white))
    }
    
}

/// Background color structure to control PopMenu backgrounds.
public struct PopMenuActionBackgroundColor {
    
    /// All colors (only one if solid color, or else it's gradient)
    public let colors: [Color]
    
    /// Fill an only solid color into the colors palette.
    public static func solid(fill color: Color) -> PopMenuActionBackgroundColor {
        return .init(colors: [color])
    }
    
    /// Fill gradient colors into the colors palette.
    public static func gradient(fill colors: Color...) -> PopMenuActionBackgroundColor {
        return .init(colors: colors)
    }
    
}

/// Action color structure to control PopMenu actions.
public struct PopMenuActionColor {
    
    /// Tint color.
    public let color: Color
    
    /// Get action's color instance with given color.
    public static func tint(_ color: Color) -> PopMenuActionColor {
        return PopMenuActionColor(color: color)
    }
    
}

/// Action separator structure to control PopMenu item separators.
public struct PopMenuActionSeparator: Equatable {
    
    /// Height of separator.
    public let height: CGFloat
    
    /// Color of separator.
    public let color: Color
    
    /// Fill separator color with given color and height.
    public static func fill(_ color: Color = Color.white.withAlphaComponent(0.5), height: CGFloat = 0.5) -> PopMenuActionSeparator {
        return PopMenuActionSeparator(height: height, color: color)
    }
    
    /// Get separator instance with no separator style.
    public static func none() -> PopMenuActionSeparator {
        return PopMenuActionSeparator(height: 0, color: .clear)
    }
    
    /// Equatable operation.
    public static func == (lhs: PopMenuActionSeparator, rhs: PopMenuActionSeparator) -> Bool {
        return lhs.color == rhs.color && lhs.height == rhs.height
    }
    
}
