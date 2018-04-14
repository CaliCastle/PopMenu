//
//  PopMenuAppearance.swift
//  PopMenu
//
//  Created by Cali Castle on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

final public class PopMenuAppearance: NSObject {
    
    public var popMenuColor: PopMenuColor = .configure(background: .gradient(fill: #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1), #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)), action: .tint(.white))
    
    public var popMenuFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    public var popMenuCornerRadius: CGFloat = 24
    
    public var popMenuActionHeight: CGFloat = 50
    
}
