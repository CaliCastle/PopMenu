//
//  PopMenuAppearance.swift
//  PopMenu
//
//  Created by Cali Castle on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

/// Appearance for pop menu.
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

public struct PopMenuBackgroundStyle {
    
    // MARK: - Dimmed Style
    
    public let isDimmed: Bool?
    public let dimColor: Color?
    public let dimOpacity: CGFloat?
    
    // MARK: - Blur Style
    
    public let isBlurred: Bool?
    public let blurStyle: UIBlurEffectStyle?
    
    // MARK: - Initializers
    
    public static func dimmed(color: Color, opacity: CGFloat) -> PopMenuBackgroundStyle {
        return PopMenuBackgroundStyle(isDimmed: true, dimColor: color, dimOpacity: opacity, isBlurred: nil, blurStyle: nil)
    }
    
    public static func blurred(_ style: UIBlurEffectStyle) -> PopMenuBackgroundStyle{
        return PopMenuBackgroundStyle(isDimmed: nil, dimColor: nil, dimOpacity: nil, isBlurred: true, blurStyle: style)
    }
    
    public static func none() -> PopMenuBackgroundStyle{
        return PopMenuBackgroundStyle(isDimmed: nil, dimColor: nil, dimOpacity: nil, isBlurred: nil, blurStyle: nil)
    }
    
}
