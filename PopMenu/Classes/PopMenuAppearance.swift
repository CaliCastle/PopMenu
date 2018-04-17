//
//  PopMenuAppearance.swift
//  PopMenu
//
//  Created by Cali Castle on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

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
