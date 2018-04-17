//
//  PopMenuColor.swift
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
