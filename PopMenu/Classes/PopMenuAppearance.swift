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
    
    /// The font for labels.
    public var popMenuFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    /// Corner radius for rounded corners.
    public var popMenuCornerRadius: CGFloat = 24
    
    /// How tall each action is.
    public var popMenuActionHeight: CGFloat = 50
    
}
