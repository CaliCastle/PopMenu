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
    
    public static func `default`() -> PopMenuColor {
        return PopMenuColor(backgroundColor: .gradient(fill: #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1), #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)), actionColor: .tint(.white))
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
