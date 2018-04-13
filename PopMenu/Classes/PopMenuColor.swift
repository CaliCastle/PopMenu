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
    
    public let colors: [Color]
    
    public static func solid(fill color: Color) -> PopMenuColor {
        return PopMenuColor(colors: [color])
    }
    
    public static func gradient(fill colors: Color...) -> PopMenuColor {
        return PopMenuColor(colors: colors)
    }
    
}
