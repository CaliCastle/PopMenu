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

public struct PopMenuColor {
    
    public var backgroundColor: PopMenuBackgroundColor
    public var actionColor: PopMenuActionColor
    
    public static func configure(background: PopMenuBackgroundColor, action: PopMenuActionColor) -> PopMenuColor {
        return PopMenuColor(backgroundColor: background, actionColor: action)
    }
    
}

public struct PopMenuBackgroundColor {
    
    public let colors: [Color]
    
    public static func solid(fill color: Color) -> PopMenuBackgroundColor {
        return PopMenuBackgroundColor(colors: [color])
    }
    
    public static func gradient(fill colors: Color...) -> PopMenuBackgroundColor {
        return PopMenuBackgroundColor(colors: colors)
    }
    
}

public struct PopMenuActionColor {
    
    public let color: Color
    
    public static func tint(_ color: Color) -> PopMenuActionColor {
        return PopMenuActionColor(color: color)
    }
    
}
